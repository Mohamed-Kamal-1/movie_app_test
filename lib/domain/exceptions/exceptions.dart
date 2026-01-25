class NoInternetException implements Exception {
  String? message;

  NoInternetException({this.message = 'No Internet Connection'});
}

class ServerError implements Exception {
  String? message;
  String? statusMessage;

  ServerError({
    this.message = 'Something went Wrong',
    this.statusMessage = 'fail',
  });
}
