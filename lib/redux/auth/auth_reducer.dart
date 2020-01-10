import 'package:redux/redux.dart';
import 'package:sunriselogin/redux/auth/auth_actions.dart';
import 'package:sunriselogin/redux/auth/auth_state.dart';

Reducer<AuthState> authReducer = combineReducers([
  TypedReducer<AuthState, AuthUserLoginRequest>(userLoginRequestReducer),
]);

AuthState userLoginRequestReducer(AuthState authState, AuthUserLoginRequest action) {
  return authState.rebuild((b) => b
    ..email = action.email
    ..password = action.password);
}
