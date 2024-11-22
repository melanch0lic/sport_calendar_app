class AuthResponse {
  final String message;
  final String userId;

  AuthResponse({required this.message, required this.userId});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message'],
      userId: json['user_id'],
    );
  }
}
