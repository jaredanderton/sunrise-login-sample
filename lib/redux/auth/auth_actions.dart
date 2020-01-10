import 'dart:async';

import 'package:sunriselogin/redux/redux.dart';

class AuthUserLoginRequest implements Action {
  final Completer completer;
  final String email;
  final String password;

  AuthUserLoginRequest(this.completer, this.email, this.password);
}

class AuthUserLoginSuccess {}
class AuthUserLoginFailure {}