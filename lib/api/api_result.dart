class ApiResult<T> {
  T? data;
  ApiResultType type;
  String? message;

  ApiResult({
    this.data,
    required this.type,
    this.message,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) => ApiResult(
        data: json["data"],
        type: ApiResultType.success,
        message: json["message"],
      );

  factory ApiResult.failure(String errorMsg) => ApiResult(message: errorMsg,type:ApiResultType.failure);
  String get errorMessage => message ?? 'error';
}

enum ApiResultType { success, failure }
