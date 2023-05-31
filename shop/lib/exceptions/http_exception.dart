class HttpException implements Exception {
  final String msg;
  final int statusCodes;

  HttpException({
    required this.msg,
    required this.statusCodes,
  });

  @override
  String toString() {
    return msg;
  }
}
