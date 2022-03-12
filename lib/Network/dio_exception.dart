import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'custom_exception.dart';

class DioExceptions implements Exception {
  /// custom Exceptions message
  DioExceptions.fromDioError(exception) {
    switch (exception.type) {
      case DioErrorType.cancel:
        errorType = CustomStatusCodeErrorType.internet;
        break;
      case DioErrorType.connectTimeout:
        errorType = CustomStatusCodeErrorType.connectTimeout;
        break;
      case DioErrorType.other:
        print("error is ${exception.type} ");
        errorType = CustomStatusCodeErrorType.server;

        break;
      case DioErrorType.receiveTimeout:
        errorType = CustomStatusCodeErrorType.receiveTimeout;

        break;
      case DioErrorType.response:
        print('code ${exception.response!.statusCode}');
        errorType = _handleErrorType(exception.response!.statusCode);
        errorMassage = exception.response!.data["message"];
        break;
      case DioErrorType.sendTimeout:
        errorType = CustomStatusCodeErrorType.receiveTimeout;
        break;
      default:
        errorType = CustomStatusCodeErrorType.unExcepted;
        break;
    }
  }

  late CustomStatusCodeErrorType errorType;
  String errorMassage = "";

  /// custom response statusCode massage
  CustomStatusCodeErrorType _handleErrorType(int statusCode) {
    switch (statusCode) {
      case 400:
        return CustomStatusCodeErrorType.badRequest;
      case 401:
        return CustomStatusCodeErrorType.unVerified;
      case 404:
        print('code 404 done');
        return CustomStatusCodeErrorType.notFound;
        case 410:
        print('code 404 done');
        return CustomStatusCodeErrorType.gone;
      case 500:
        return CustomStatusCodeErrorType.server;
      case 502:
        return CustomStatusCodeErrorType.badRequest;
      case 302:
        return CustomStatusCodeErrorType.redirection;
      default:
        return CustomStatusCodeErrorType.unExcepted;
    }
  }



  @override
  String toString() => '$errorType';
}
