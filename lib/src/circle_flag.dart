library circle_flags;

import 'dart:convert';

import 'package:circle_flags/src/codes/other_code.dart';
import 'package:circle_flags/src/flag_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A flag of a country, rounded by default.
///
/// First positional argument is iso code of the country - can be used string
/// or [Flags] helper.
class CircleFlag extends StatelessWidget {
  static final _FlagCache cache = _FlagCache();

  /// check if a flag has been preloaded if so, returns its byteloader
  static BytesLoader _createLoader(FlagType type, String isoCode) {
    final cacheKey = _FlagCache.createCacheKey(type, isoCode);
    final cacheEntry = cache._loaders[cacheKey];
    if (cacheEntry != null) {
      return cacheEntry;
    }
    return _FlagAssetLoader(type, isoCode);
  }

  /// preload a list of flags in memory
  static preload(FlagType type, Iterable<String> isoCodes) {
    return cache.preload(type, isoCodes);
  }

  CircleFlag._(
    String isoCode, {
    super.key,
    required this.type,
    required this.size,
  }) : loader = _createLoader(type, isoCode);

  /// Create a country flag from an [ISO 3166-1 alpha-2 code](https://www.wikiwand.com/en/ISO_3166-1_alpha-2).
  factory CircleFlag(
    String countryCode, {
    Key? key,
    double size = 48,
  }) =>
      CircleFlag._(
        countryCode,
        key: key,
        type: FlagType.country,
        size: size,
      );

  /// Create a language flag from and [IETF language tag](https://en.wikipedia.org/wiki/IETF_language_tag).
  factory CircleFlag.language(
    String languageCode, {
    Key? key,
    double size = 48,
  }) =>
      CircleFlag._(
        languageCode,
        key: key,
        type: FlagType.language,
        size: size,
      );

  /// Create one of the other miscellaneous flags.
  ///
  /// See [OtherCodes] for available codes
  factory CircleFlag.other(
    String otherCode, {
    Key? key,
    double size = 48,
  }) =>
      CircleFlag._(
        otherCode,
        key: key,
        type: FlagType.other,
        size: size,
      );

  final FlagType type;
  final double size;
  final BytesLoader loader;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SvgPicture(
        loader,
        width: size,
        height: size,
      ),
    );
  }
}

/// create an SvgAssetLoader that points to circle flag svg file
/// it will resolve to the "?" flag if the normal asset is not found
class _FlagAssetLoader extends SvgAssetLoader {
  static String computeAssetName(FlagType type, String isoCode) {
    final assetsDir = 'packages/circle_flags/assets';
    return '$assetsDir/${type.assetsSubDir}/${isoCode.toLowerCase()}.svg';
  }

  static Future<ByteData> loadAsset(String assetName,
      [BuildContext? context, AssetBundle? assetBundle]) {
    final bundle = _FlagAssetLoader._resolveBundle(assetBundle, context);
    return bundle
        .load(assetName)
        .catchError((e) => rootBundle.load(_notFoundAssetName));
  }

  static AssetBundle _resolveBundle(
      AssetBundle? assetBundle, BuildContext? context) {
    if (assetBundle != null) {
      return assetBundle;
    }
    if (context != null) {
      return DefaultAssetBundle.of(context);
    }
    return rootBundle;
  }

  static final String _notFoundAssetName =
      computeAssetName(FlagType.other, OtherCode.QUESTION_MARK);

  _FlagAssetLoader(this.type, this.isoCode)
      : super(computeAssetName(type, isoCode));

  final FlagType type;
  final String isoCode;

  @override
  Future<ByteData?> prepareMessage(BuildContext? context) {
    final bundle = _resolveBundle(assetBundle, context);
    return bundle
        .load(computeAssetName(type, isoCode))
        .catchError((e) => bundle.load(_notFoundAssetName));
  }

  @override
  String provideSvg(ByteData? message) =>
      utf8.decode(message!.buffer.asUint8List(), allowMalformed: true);

  @override
  SvgCacheKey cacheKey(BuildContext? context) {
    return SvgCacheKey(
      keyData: _FlagCache.createCacheKey(type, isoCode),
      theme: theme,
      colorMapper: colorMapper,
    );
  }
}

/// a flag loader cache that allows for preloading
/// svg bytes.
/// Currently only caches preloaded items
class _FlagCache {
  static String createCacheKey(FlagType type, String isoCode) =>
      '${type.name}_$isoCode';

  final _loaders = <String, SvgBytesLoader>{};

  /// preloads flag data into svg cache
  Future<void> preload(
    FlagType type,
    Iterable<String> isoCodes, [
    BuildContext? context,
    AssetBundle? assetBundle,
  ]) async {
    final tasks = <Future>[];
    for (final isoCode in isoCodes) {
      final task = _createLoader(type, isoCode, context, assetBundle)
          .then((loader) => _addLoaderToCache(type, isoCode, loader));
      tasks.add(task);
    }
    await Future.wait(tasks);
  }

  Future<SvgBytesLoader> _createLoader(
    FlagType type,
    String isoCode,
    BuildContext? context,
    AssetBundle? assetBundle,
  ) async {
    final assetName = _FlagAssetLoader.computeAssetName(type, isoCode);
    final byteData =
        await _FlagAssetLoader.loadAsset(assetName, context, assetBundle);
    final loader = SvgBytesLoader(Uint8List.sublistView(byteData));
    // add it to svg cache
    svg.cache
        .putIfAbsent(loader.cacheKey(context), () => loader.loadBytes(context));
    return loader;
  }

  void _addLoaderToCache(
    FlagType type,
    String isoCode,
    SvgBytesLoader loader,
  ) {
    final cacheKey = createCacheKey(type, isoCode);
    _loaders[cacheKey] = loader;
  }
}
