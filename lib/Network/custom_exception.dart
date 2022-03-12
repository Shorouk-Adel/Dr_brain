class CustomException implements Exception {
  CustomStatusCodeErrorType type;
  String errorMassage;
  String imgPath;

  CustomException(this.type, this.imgPath, {this.errorMassage = ""});

  @override
  String toString() {
    return 'SomeThing Wrong Happen: \n$type';
  }
}

enum CustomStatusCodeErrorType {
  init,
  server,
  internet,
  gatWay,
  redirection,
  connectTimeout,
  receiveTimeout,
  sendTimeout,
  badRequest,
  unExcepted,
  unVerified,
  notFound,
  gone
}
