class ResponseObj {
  MsgState? message;
  ErrorState? errorState;
  dynamic data;

  ResponseObj({this.data, this.message, this.errorState});
}

enum MsgState {
  loading,
  data,
  error,
}
enum ErrorState {
  clientError,
  fileNotFoundError,
  serverError,
  redirectError,
}
