import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';


import 'custom_exception.dart';
import 'dio_exception.dart';

class DioHelper {
  static late Dio dio;

  /// initializing dio baseUrl
  static init() {
    try {
      dio = Dio(
        BaseOptions(
          baseUrl: 'https://dr-brains.com/api/',
          headers: {
            'Accept': 'application/json',
          },
          receiveDataWhenStatusError: true,
        ),
      );
    } on DioError catch (exception) {
      /// Get custom massage for the exception
      final errorMessage = DioExceptions.fromDioError(exception).errorType;

      /// throw custom exception
      throw CustomException(errorMessage, 'error.png');
    } catch (e) {
      throw CustomException(CustomStatusCodeErrorType.unExcepted, 'error.png');
    }
  }

  ///use this method to get data from api
  static Future<Response> getDate({required String url}) async {
    try {
      return await dio.get(url);
    } on DioError catch (exception) {
      /// Get custom massage for the exception
      print("this is error from dio error exception$exception");

      print(
          "here is the error from dio  ${exception.response!.data["message"]} ");
      final errorType = DioExceptions.fromDioError(exception).errorType;
      final errorMessage = DioExceptions.fromDioError(exception).errorMassage;

      /// throw custom exception
      throw CustomException(errorType, 'error.png', errorMassage: errorMessage);
    } catch (e) {
      throw CustomException(CustomStatusCodeErrorType.unExcepted, 'error.png');
    }
  }

  ///use this method to send data to api
  static Future<Response> postData(
      {required String url, required FormData data}) async {
    try {
      final response = await dio.post(url, data: data);

      print(response.statusCode.toString());
      print(response.statusMessage);

      return response;
    } on DioError catch (exception) {
      print("this is error from dio error exception$exception");
      print(
          "here is the error from dio  ${exception.response!.data["message"]} ");

      /// G1et custom massage for the exception
      final errorType = DioExceptions.fromDioError(exception).errorType;

      final errorMessage = DioExceptions.fromDioError(exception).errorMassage;

      /// throw custom exception
      throw CustomException(errorType, 'error.png', errorMassage: errorMessage);
    } catch (error) {
      print("this is error from unexcepected exception$error");
      print("this is error from unexcepected exception${error.runtimeType}");

      throw CustomException(CustomStatusCodeErrorType.unExcepted, 'error.png');
    }
  }

}
