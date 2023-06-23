class ServerErrorException implements Exception {
  ServerErrorException();
  static const String message = 'ServerErrorException';
  @override
  String toString() => message;
}
