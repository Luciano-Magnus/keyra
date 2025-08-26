class CustomException implements Exception {
  final String message;
  final int? code;

  CustomException(this.message, {this.code});

  @override
  String toString() {
    if (code != null) {
      return 'CustomException(code: $code, message: $message)';
    }
    return 'CustomException(message: $message)';
  }
}