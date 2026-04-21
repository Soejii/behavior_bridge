class BuildEnv {
  static const client =
      String.fromEnvironment('CLIENT', defaultValue: 'default');
  static const env = String.fromEnvironment('ENV', defaultValue: 'dev');
}
