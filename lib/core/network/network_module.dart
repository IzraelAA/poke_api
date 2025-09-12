import 'dart:async';

import 'package:dio/dio.dart';
import 'package:poke_api/core/local_storage/storage.dart';
import 'package:poke_api/core/network/api_exception.dart';
import 'package:poke_api/core/network/dio_module.dart';
import 'package:poke_api/core/network/logging_interceptor.dart';
import 'package:poke_api/core/network/result.dart';

import 'refresh_token_interceptor.dart';

abstract class NetworkModule {
  Dio get _dio => DioModule.getInstance();

  BaseOptions? options;

  Future<Result<T>> _safeCallApi<T>(
    Future<Response<T>> call,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      var response = await call;
      return Result.success(
        response.data as T,
        response.statusMessage,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return Result.error(
          e.response!.statusCode ?? 400,
          e.response!.data,
        );
      } else {
        return Result.timeout(
          '' as dynamic,
          'Network Failure',
        );
      }
    } catch (ex) {
      return Result.timeout(
        '' as dynamic,
        'Network Failure',
      );
    }
  }

  Future<Result<dynamic>> getMethod(
    String endpoint, {
    Map<String, dynamic>? param,
    Map<String, String>? headers,
    String? url,
    bool withAccessToken = true,
  }) async {
    if (withAccessToken == true) {
      final token = await Storage.getString(Storage.jwt) ?? "";
      if (token.isEmpty) {
        throw UnAuthorizedExceptions("Token is empty");
      }

      if (headers != null) {
        headers["Authorization"] = "Bearer $token";

        headers["Accept"] = "application/json";
      } else {
        headers = {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        };
      }
    }
    var options = Options(headers: headers);

    late Dio dio;
    if (url != null) {
      dio = DioModule.getInstance(
        BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
    } else {
      dio = _dio;
    }

    var response = await _safeCallApi(
      dio.get(
        endpoint,
        queryParameters: param,
        options: options,
      ),
    );

    return response;
  }

  Future<Result<dynamic>> postMethod(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    String? url,
    bool withAccessToken = true,
  }) async {
    if (withAccessToken == true) {
      final token = await Storage.getString(Storage.jwt) ?? "";

      if (headers != null) {
        headers["Authorization"] = "Bearer $token";

        headers["Accept"] = "application/json";
      } else {
        headers = {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        };
      }
    }
    var options = Options(headers: headers);

    late Dio dio;
    if (url != null) {
      dio = DioModule.getInstance(
        BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
    } else {
      dio = _dio;
    }

    var response = await _safeCallApi(
      dio.post(
        endpoint,
        data: body,
        options: options,
      ),
    );

    return response;
  }

  Future<Result<dynamic>> putMethod(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    String? url,
    bool withAccessToken = true,
  }) async {
    if (withAccessToken == true) {
      final token = await Storage.getString(Storage.jwt) ?? "";
      if (headers != null) {
        headers["Authorization"] = "Bearer $token";

        headers["Accept"] = "application/json";
      } else {
        headers = {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        };
      }
    }
    var options = Options(headers: headers);

    late Dio dio;
    if (url != null) {
      dio = DioModule.getInstance(
        BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
    } else {
      dio = _dio;
    }

    var response = await _safeCallApi(
      dio.put(
        endpoint,
        data: body,
        options: options,
      ),
    );

    return response;
  }

  Future<Result> postUploadDocument(
    String endpoint, {
    Map<String, String>? headers,
    FormData? body,
    String? url,
    bool withAccessToken = true,
  }) async {
    if (withAccessToken == true) {
      final token = await Storage.getString(Storage.jwt) ?? "";

      if (headers != null) {
        headers["Authorization"] = "Bearer $token";

        headers["Accept"] = "application/json";
      } else {
        headers = {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        };
      }
    }
    headers!["Content-Type"] = "multipart/form-data";
    var options = Options(headers: headers);

    late Dio dio;
    if (url != null) {
      dio = DioModule.getInstance(
        BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
    } else {
      dio = _dio;
    }
    dio.interceptors.add(LoggingInterceptor());
    dio.interceptors.add(RefreshTokenInterceptor(dio));
    var response = await _safeCallApi(
      dio.post(
        endpoint,
        data: body,
        options: options,
      ),
    );

    return response;
  }

  Future<Result> putUploadDocument(
    String endpoint, {
    Map<String, String>? headers,
    FormData? body,
    String? url,
    bool withAccessToken = true,
  }) async {
    if (withAccessToken == true) {
      final token = await Storage.getString(Storage.jwt) ?? "";

      if (headers != null) {
        headers["Authorization"] = "Bearer $token";

        headers["Accept"] = "application/json";
      } else {
        headers = {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        };
      }
    }
    var options = Options(headers: headers);

    late Dio dio;
    if (url != null) {
      dio = DioModule.getInstance(
        BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
    } else {
      dio = _dio;
    }

    var response = await _safeCallApi(
      dio.put(
        endpoint,
        data: body,
        options: options,
      ),
    );

    return response;
  }

  Future<Result<dynamic>> deleteMethod(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    String? url,
    bool withAccessToken = true,
  }) async {
    if (withAccessToken == true) {
      final token = await Storage.getString(Storage.jwt) ?? "";

      if (headers != null) {
        headers["Authorization"] = "Bearer $token";

        headers["Accept"] = "application/json";
      } else {
        headers = {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        };
      }
    }
    var options = Options(headers: headers);

    late Dio dio;
    if (url != null) {
      dio = DioModule.getInstance(
        BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
    } else {
      dio = _dio;
    }

    var response = await _safeCallApi(
      dio.delete(
        endpoint,
        data: body,
        options: options,
      ),
    );

    return response;
  }

  Future<Result<dynamic>> patchMethod(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    String? url,
    bool withAccessToken = true,
  }) async {
    if (withAccessToken == true) {
      final token = await Storage.getString(Storage.jwt) ?? "";

      if (headers != null) {
        headers["Authorization"] = "Bearer $token";

        headers["Accept"] = "application/json";
      } else {
        headers = {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        };
      }
    }
    var options = Options(headers: headers);

    late Dio dio;
    if (url != null) {
      dio = DioModule.getInstance(
        BaseOptions(
          baseUrl: url,
          connectTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
    } else {
      dio = _dio;
    }

    var response = await _safeCallApi(
      dio.patch(
        endpoint,
        data: body,
        options: options,
      ),
    );

    return response;
  }

  /// [dynamic] this method is return response from [Result<dynamic>]
  dynamic responseHandler(Result<dynamic> result) {
    switch (result.status) {
      case Status.success:
        return result.body;
      case Status.error:
        if (result.code == 401) {
          throw UnAuthorizedExceptions(result.body);
        } else {
          throw ErrorRequestException(
            result.code,
            result.code >= 500 ? {"errors": "Server Error"} : result.body,
          );
        }
      case Status.unreachable:
        throw NetworkException(result.message);
      default:
        throw ArgumentError();
    }
  }
}
