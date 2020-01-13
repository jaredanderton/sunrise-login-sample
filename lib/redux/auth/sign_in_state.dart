class SignInState {
  final String email;
  final String password;
  final String accessToken;
  final bool waiting;
  SignInState({this.email, this.password, this.accessToken, this.waiting = false });

// could this be generated?
  SignInState copy({String email, String password, String accessToken, bool waiting}) => SignInState(
    email: email ?? this.email,
    password: password ?? this.password,
    accessToken: accessToken ?? this.accessToken,
    waiting: waiting ?? this.waiting,
  );
}