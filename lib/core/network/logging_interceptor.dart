import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(
      '--> ${options.method.toUpperCase()} ${options.baseUrl + options.path}',
    );
    log(
      '--> Headers: ${options.headers}',
    );
    if (options.queryParameters.isNotEmpty) {
      log(
        '--> Query Parameters: ${options.queryParameters}',
      );
    }
    log(
      '--> Data: ${options.data}',
    );
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    response.headers.forEach(
          (k, v) => log('$k: $v'),
    );
    log(
      '<-- ${response.requestOptions.method} ${response.requestOptions.baseUrl + response.requestOptions.path} --> ${response.data}',
    );
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the error response contains data
    if (err.response?.data != null) {
      log(
        'ERROR[${err.response?.statusCode}] => PATH: '
            '${err.requestOptions.baseUrl + err.requestOptions.path}'
            '\nResponse Data: ${err.response?.data}'
            '\nError Message: ${err.response?.statusMessage}',
      );
    } else {
      // Handle case when there is no response data
      log(
        'ERROR[${err.response?.statusCode}] => PATH: '
            '${err.requestOptions.baseUrl + err.requestOptions.path}'
            '\nNo Response Data Available'
            '\nError Message: ${err.response?.statusMessage}',
      );
    }
    return super.onError(err, handler);
  }
}
