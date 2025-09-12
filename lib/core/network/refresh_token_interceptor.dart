import 'dart:async';

import 'package:dio/dio.dart';

class RefreshTokenInterceptor extends Interceptor {
  final Dio dio;

  RefreshTokenInterceptor(this.dio);

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {

    return super.onError(err, handler);
  }
}
