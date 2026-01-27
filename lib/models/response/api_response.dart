class ApiResponse<T> {
  final T data;
  final bool result;
  final int code;

  ApiResponse({
    required this.data,
    required this.result,
    required this.code,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiResponse<T>(
      data: fromJsonT(json['data']),
      result: json['result'],
      code: json['code'],
    );
  }
}
