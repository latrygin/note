// ignore_for_file: do_not_use_environment

abstract class Token {
  static const String _token = String.fromEnvironment('TOKEN');

  static String get token => _token;
}
