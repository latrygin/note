class BadRequestException implements Exception {
  static const String message = 'BadRequestException';

  BadRequestException();

  @override
  String toString() => message;
}
