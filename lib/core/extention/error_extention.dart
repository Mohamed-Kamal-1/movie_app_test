import 'package:flutter/cupertino.dart';
import 'package:movie_app/domain/exceptions/exceptions.dart';

extension ContextErrorMessageExtractor on BuildContext {
  String getErrorMessage(Exception error) {
    if (error is ServerError) {
      return error.message ?? 'Something went Wrong';
    } else if (error is NoInternetException) {
      return 'Please check your internet';
    } else {
      return 'Something went Wrong';
    }
  }
}
