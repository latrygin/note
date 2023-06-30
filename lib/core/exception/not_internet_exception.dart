class NotInternetException implements Exception {
  NotInternetException();
  static const String message = 'NotInternetException';
  @override
  String toString() => message;
}
