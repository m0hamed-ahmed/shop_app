import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true
      )
    );
  }

  static Future<Response> getData({
    String url,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    String url,
    Map<String, dynamic> query,
    Map<String, dynamic> data,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio.post(url, data: data);
  }

  static Future<Response> putData({
    String url,
    Map<String, dynamic> query,
    Map<String, dynamic> data,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return await dio.put(url, data: data);
  }
}