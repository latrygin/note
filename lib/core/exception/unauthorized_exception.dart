class UnauthorizedException implements Exception {
  static const String message = 'UnauthorizedException';
  UnauthorizedException();

  @override
  String toString() => message;
}
