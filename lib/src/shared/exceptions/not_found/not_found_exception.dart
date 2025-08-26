class NotFoundException implements Exception {
  final String message;

  NotFoundException([this.message = 'Resource not found']);

  @override
  String toString() {
    return 'NotFoundException: $message';
  }
}