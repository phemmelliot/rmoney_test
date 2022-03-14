import 'package:dio/dio.dart';


class ApiClient {
  static Future<Dio> getClient() async {
    Dio dio = Dio();

    dio.options.connectTimeout = 30000;
    dio.options.receiveTimeout = 30000;

    dio.options.contentType = 'application/json';

    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(options, handler){
          // Do something before request is sent
          Map<String, dynamic> headers = options.headers;
          headers["sourceappid"] = "ckpu7zo0p0000gg5436coo7xs";
          headers["Authorization"] = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyMzQ4OTkzOTQ5NjMzIiwiaWF0IjoxNjQ2OTk4MzgwLCJleHAiOjE2NDcwODQ3ODB9.iLzStUQEOsde38vGwHT5AT6nb0f63PGGkgVUrgcfcQBq16qTzdotWd-JCl1QM7budyav5tX2ufA0JZoEfwtw6Q";
          options.headers = headers;

          return handler.next(options); //continue
        },
        onResponse:(response,handler) {
          // Do something with response data
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: `handler.reject(dioError)`
        },
        onError: (DioError e, handler) {
          // Do something with response error
          return  handler.next(e);//continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        }
    ));

    return dio;
  }
}
