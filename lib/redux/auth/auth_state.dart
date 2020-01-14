class AuthState {

  String email;
  String password;
  String accessToken;

  AuthState({this.email, this.password, this.accessToken});

  AuthState copy({String email, String password, String accessToken}) => AuthState(
    email: email ?? this.email,
    password: password ?? this.password,
    accessToken: accessToken ?? this.accessToken,
  );

  toJson() {
    return {
      'email': email,
      'password': password,
      'accessToken': accessToken,
    };
  }

}
