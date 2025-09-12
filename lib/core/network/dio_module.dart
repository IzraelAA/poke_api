import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:poke_api/core/network/api_url.dart';
import 'package:poke_api/core/network/logging_interceptor.dart';
import 'package:poke_api/core/network/refresh_token_interceptor.dart';

class DioModule with DioMixin implements Dio {
  /// Private constructor for DioModule.
  DioModule._([BaseOptions? options]) {
    options ??= BaseOptions(
      baseUrl: Endpoint.api,
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );

    this.options = options;
    interceptors.add(LoggingInterceptor());
    interceptors.add(RefreshTokenInterceptor(this));
    httpClientAdapter = IOHttpClientAdapter();
  }

  /// Static method to get an instance of DioModule.
  static Dio getInstance([BaseOptions? options]) => DioModule._(options);
}

