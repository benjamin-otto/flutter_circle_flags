import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:path/path.dart';

enum FlagType {
  country(
    assetsSubDir: 'svg/country_flags/',
    outputFilename: 'country_code.dart',
    outputClassName: 'CountryCode',
  ),
  language(
    assetsSubDir: 'svg/language_flags/',
    outputFilename: 'language_code.dart',
    outputClassName: 'LanguageCode',
  ),
  other(
    assetsSubDir: 'svg/other_flags/',
    outputFilename: 'other_code.dart',
    outputClassName: 'OtherCode',
  );

  const FlagType({
    required this.assetsSubDir,
    required this.outputFilename,
    required this.outputClassName,
  });

  final String assetsSubDir;
  final String outputFilename;
  final String outputClassName;
}

/// This builder create one file: lib/src/flags.dart, it run only after all calls
/// to [AssetToCacheBuilder.build] are finished.
///
/// It triggered only if `flags.dart` file didn't exist, for this reason
/// [AssetToCacheBuilder.build] will always delete this file.
///
/// It combine all files generated by [AssetToCacheBuilder].
class FlagsFileBuilder implements Builder {
  FlagsFileBuilder();

  @override
  Map<String, List<String>> get buildExtensions => {
        r'$lib$': [
          'src/codes/${FlagType.country.outputFilename}',
          'src/codes/${FlagType.language.outputFilename}',
          'src/codes/${FlagType.other.outputFilename}',
        ],
      };

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    generateFile(buildStep, FlagType.country);
    generateFile(buildStep, FlagType.language);
    generateFile(buildStep, FlagType.other);
  }

  Future<void> generateFile(BuildStep buildStep, FlagType type) async {
    // make sure Builders never run in user package even if user
    // import package from git or other sources
    // (this doesn't needed for pub.dev, because of .pubignore)
    if (buildStep.inputId.package != 'circle_flags') {
      return;
    }

    final codesFileAssetId = AssetId(
      buildStep.inputId.package,
      join('lib', 'src', 'codes', type.outputFilename),
    );

    print("----------- Writing ${codesFileAssetId.path} -----------");

    final fileHeader = '''
// GENERATED FILE, timestamp: ${DateTime.now()}
// Regenerate with: dart run build_runner build

import 'package:circle_flags/circle_flags.dart';

/// List of available ${type.name} codes for [CircleFlag].
abstract class ${type.outputClassName} {
''';

    var list = '''
  static const values = <String>[
''';
    var newFileContent = '';
    final dir = Directory(
        '.dart_tool/build/generated/circle_flags/assets/${type.assetsSubDir}');
    for (final file in dir.listSync().toList()
      ..sort((a, b) => a.path.compareTo(b.path))) {
      if (file is File) {
        newFileContent += file.readAsStringSync();
        var baseName = file.path.split('/').last;
        baseName = baseName.substring(0, baseName.length - 9); // cut .part.txt
        list += "    ${baseName.toUpperCase().replaceAll('-', '_')},\n";
      }
    }

    list += "  ];\n";
    newFileContent += "}\n";

    await buildStep.writeAsString(
        codesFileAssetId, fileHeader + list + newFileContent);
  }
}
