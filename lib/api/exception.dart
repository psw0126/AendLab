
class APIException implements Exception {
  final int httpStatus;
  final String? errorCode;
  final String errorMessage;

  APIException({
    required this.httpStatus,
    required this.errorCode,
    required this.errorMessage,
  });
}