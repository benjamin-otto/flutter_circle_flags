enum FlagType {
  country('svg/country_flags'),
  language('svg/language_flags'),
  other('svg/other_flags');

  const FlagType(this.assetsSubDir);

  final String assetsSubDir;
}
