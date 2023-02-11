import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        return ServerFailure('Connection Timeout With ApiServer');
      case DioErrorType.sendTimeout:
        return ServerFailure('Send Timeout With ApiServer');
      case DioErrorType.receiveTimeout:
        return ServerFailure('Receive Timeout With ApiServer');
      case DioErrorType.response:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioErrorType.cancel:
        return ServerFailure('Request To ApiServer Was Canseled');
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please Try Again!');
      default:
        return ServerFailure('Oops There Was An Error, Please Try Again!');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your Request Not Found, Please Try Later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internet Server Error, Please Try Later!');
    } else {
      return ServerFailure('Oops There Was An Error, Please Try Again!');
    }
  }
}
