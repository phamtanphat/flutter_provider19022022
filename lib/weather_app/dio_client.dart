import 'package:dio/dio.dart';

class DioClient{

  static DioClient _dioClient = DioClient._internal();
  late Dio _dio;

  DioClient._internal(){
    _dio = Dio(BaseOptions(
      baseUrl: "http://api.openweathermap.org/",
      connectTimeout: 10000,
      receiveTimeout: 10000,
      sendTimeout: 10000,
    ));
    _dio.interceptors.add(LogInterceptor());

  }

  factory DioClient.getInstance(){
    return _dioClient;
  }

  Dio get(){
    return _dio;
  }
}