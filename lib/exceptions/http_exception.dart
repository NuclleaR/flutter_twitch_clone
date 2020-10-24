class HttpException implements Exception {
  final int statusCode;
  final String cause;

  HttpException(this.cause, [this.statusCode]);
}
