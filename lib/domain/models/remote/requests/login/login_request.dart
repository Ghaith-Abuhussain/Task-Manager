class LoginRequest {
  final String? username;
  final String? password;
  final int? expiresInMins;

  LoginRequest({this.username, this.password, this.expiresInMins});

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'expiresInMins': expiresInMins
  };
}