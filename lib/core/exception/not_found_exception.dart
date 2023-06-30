class NotFoundException implements Exception {
  static const String message = 'NotFoundException';

  NotFoundException();

  @override
  String toString() => message;
}
