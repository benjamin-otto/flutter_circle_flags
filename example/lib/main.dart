import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool preloaded = false;
  bool showFlags = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // preloading flags so they show instantly (mostly useful for web)
    if (!preloaded) {
      CircleFlag.preload(FlagType.country, CountryCode.values);
      CircleFlag.preload(FlagType.language, LanguageCode.values);
      CircleFlag.preload(FlagType.other, OtherCode.values);
      preloaded = true;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example Flags'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            children: [
              ..._countryFlags(context),
              ..._languageFlags(context),
              ..._otherFlags(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _countryFlags(BuildContext context) {
    return [
      Text('Country flags', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 16),
      ListTile(
        leading: CircleFlag(CountryCode.US),
        title: const Text('United States'),
      ),
      const SizedBox(height: 16),
      ListTile(
        leading: CircleFlag(CountryCode.ES),
        title: const Text('Spain'),
      ),
      const SizedBox(height: 16),
      ListTile(
        leading: CircleFlag(CountryCode.SA),
        title: const Text('Saudi Arabia'),
      ),
      const SizedBox(height: 16),
    ];
  }

  List<Widget> _languageFlags(BuildContext context) {
    return [
      Text('Language flags', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 16),
      ListTile(
        leading: CircleFlag.language(LanguageCode.EN_US),
        title: const Text('English US'),
      ),
      const SizedBox(height: 16),
      ListTile(
        leading: CircleFlag.language(LanguageCode.EO),
        title: const Text('Esperanto'),
      ),
      const SizedBox(height: 16),
      ListTile(
        leading: CircleFlag.language(LanguageCode.AR),
        title: const Text('Arabic'),
      ),
      const SizedBox(height: 16),
    ];
  }

  List<Widget> _otherFlags(BuildContext context) {
    return [
      Text('Other flags', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 16),
      ListTile(
        leading: CircleFlag.other(OtherCode.PIRATE),
        title: const Text('Pirate'),
      ),
      const SizedBox(height: 16),
      ListTile(
        leading: CircleFlag.other(OtherCode.KLINGON),
        title: const Text('Klingon'),
      ),
      const SizedBox(height: 16),
      ListTile(
        leading: CircleFlag('unrecognized code'),
        title: const Text('Question mark (shown for unknown codes)'),
      ),
    ];
  }
}
