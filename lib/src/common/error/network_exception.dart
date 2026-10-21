/// Исключение, вызванное ошибкой интернет-соединения.
abstract class NetworkException implements Exception {}

/// {@template http_client_exception}
/// Исключение, вызванное ошибкой http клиента.
/// {@endtemplate}
class HttpClientException implements NetworkException {
  /// {@macro http_client_exception}
  const HttpClientException({this.message, this.statusCode});

  /// Сообщение об ошибке.
  final String? message;

  /// Статус код ошибки.
  final int? statusCode;

  @override
  String toString() {
    return '$HttpClientException(message: $message, statusCode: $statusCode)';
  }
}
