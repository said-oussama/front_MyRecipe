class ApiResponse {
  final String? message;
  final String? error;
  final String? id;

  const ApiResponse({this.message, this.error, this.id});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json["message"],
      error: json["error"],
      id: json["id"],
    );
  }
}
