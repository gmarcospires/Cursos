abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  AppException(this.message, [this.stackTrace]);

  @override
  String toString() {
    if (stackTrace != null) {
      return 'AppException - $runtimeType: $message\n$stackTrace';
    }
    return 'AppException - $runtimeType: $message';
  }
}
