class UnknownException implements Exception {
  UnknownException();
  static const String message = 'NotInternetException';
  @override
  String toString() => message;
}
