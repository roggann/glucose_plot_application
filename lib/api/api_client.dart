import 'dart:async';

import 'package:dio/dio.dart';
import 'package:glucose_plot_application/api/api_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final dioProvider = Provider((ref) => ApiClient(ref));

class ApiClient {
  final ProviderRef ref;

  ApiClient(this.ref) {
    initDio();
  }

  late Dio _dio;

  initDio() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://s3-de-central.profitbricks.com/una-health-frontend-tech-challenge/",
      contentType: 'application/json',
      followRedirects: false,
      validateStatus: (status) {
        return status == null ? false : status < 500;
      },
      headers: {
        Headers.acceptHeader: "application/json",
        'Accept-Language': "en",
      },
    );
    _dio = Dio(options);
  }


  Future<ApiResult> get({
    required String url,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio
          .get(
            _dio.options.baseUrl + url,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
          )
          .timeout(const Duration(seconds: 15));
        return ApiResult(data:response, type: ApiResultType.success);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }
}
