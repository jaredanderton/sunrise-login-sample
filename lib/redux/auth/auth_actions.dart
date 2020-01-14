import 'dart:async';
import 'package:sunriselogin/redux/redux.dart';

class AuthUserLoginRequest implements Action {
  final Completer completer;
  AuthUserLoginRequest(this.completer);
}

class AuthUserLoginSetEmail {
  final String email;
  AuthUserLoginSetEmail(this.email);

  toJson() {
    return {'email': email};
  }
}

class AuthUserLoginSetPassword {
  final String password;
  AuthUserLoginSetPassword(this.password);

  toJson() {
    return {'password': password};
  }
}

class AuthUserLoginSuccess {}
class AuthUserLoginFailure {}