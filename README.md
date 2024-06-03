# circle_flags

A Flutter widget for easily displaying country, language, and other
miscellaneous flags.

Flags are from [circle-flags](https://github.com/HatScripts/circle-flags). 🙏

This is a modification of the package
[flutter_circle_flags](https://github.com/cedvdb/flutter_circle_flags). 🙏

The modification has added the language and other flags.

## Demo

**Country Flag Examples**

<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/br.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/cn.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/gb.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/id.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/in.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/ng.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/ru.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/country_flags/us.svg?raw=true" width="48">

**Language Flag Examples**

<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/ar.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/en-us.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/en-au.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/eo.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/es-mx.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/vo.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/mr.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/language_flags/yi.svg?raw=true" width="48">

**Other Flag Examples**

<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/checkered.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/klingon.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/lgbt.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/mars.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/nato.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/pirate.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/olympics.svg?raw=true" width="48">
<img src="https://github.com/benjamin-otto/flutter_circle_flags/blob/main/assets/svg/other_flags/united_nations.svg?raw=true" width="48">

## Usage

```dart
// Country flags 
CircleFlag(CountryCode.US);
CircleFlag('us');

// Language flags 
CircleFlag.language(LanguageCode.EN_US);
CircleFlag('en-us');

// Other flags
CircleFlag.other(OtherCode.PIRATE);
CircleFlag.other(OtherCode.KLINGON);
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
