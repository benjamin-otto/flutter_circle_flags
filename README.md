# circle_flags

A Flutter widget for easily displaying country, language, and other
miscellaneous flags.

Flags are from [circle-flags](https://github.com/HatScripts/circle-flags). 🙏

This is a modification of the package
[flutter_circle_flags](https://github.com/cedvdb/flutter_circle_flags). 🙏

The modification has added the language and other flags.

## Demo

Country Flag Examples

<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/br.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/cn.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/gb.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/id.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/in.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/ng.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/ru.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/us.svg" width="48">

Flag Examples

<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/ar.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/en-us.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/en-au.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/eo.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/es-mx.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/vo.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/mr.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/yi.svg" width="48">

<p>Other Flag Examples</p>
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/checkered.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/klingon.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/lgbt.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/mars.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/nato.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/pirate.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/olympics.svg" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/united_nations.svg" width="48">

## Usage

```dart
// Country flags
CircleFlag(CountryCodes.US);
CircleFlag('us');

// Language flags 
CircleFlag.language(LanguageCodes.EN_US);
CircleFlag('en-us');

// Other flags
CircleFlag.other(OtherCodes.PIRATE);
CircleFlag.other(OtherCodes.KLINGON);
```

# Preloading

You might want to preload images for a smoother list scrolling experience:

```dart
CircleFlag.preload(['fr', 'us']);
```

# Dart Build Runner

After adding/removing .svg files (or symbolic links) within the /assets/svg/
folders run the builder.

```bash
dart run build_runner build
```

The builder will iterate through the .svg files (and symbolic links) creating:

1. lib/src/codes/country_codes.dart
2. lib/src/codes/language_codes.dart
3. lib/src/codes/other_codes.dart
