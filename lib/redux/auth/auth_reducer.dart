import 'package:redux/redux.dart';
import 'package:sunriselogin/redux/app/app_state.dart';
import 'package:sunriselogin/redux/auth/auth_actions.dart';
import 'package:sunriselogin/redux/auth/auth_state.dart';

Reducer<AppState> authReducer = combineReducers([
  TypedReducer<AppState, AuthUserLoginSetEmail>(userLoginEmailSetReducer),
  TypedReducer<AppState, AuthUserLoginSetPassword>(userLoginPasswordSetReducer),
  TypedReducer<AppState, AuthUserLoginSetAccessToken>(userLoginAccessTokenSetReducer),
]);

AppState userLoginEmailSetReducer(AppState appState, AuthUserLoginSetEmail action) {
  return appState.copy(
      authState: appState.authState.copy(
        email: action.email
      )
  );
}

AppState userLoginPasswordSetReducer(AppState appState, AuthUserLoginSetPassword action) {
  return appState.copy(
      authState: appState.authState.copy(
          password: action.password
      )
  );
}

AppState userLoginAccessTokenSetReducer(AppState appState, AuthUserLoginSetAccessToken action) {
  return appState.copy(
      authState: appState.authState.copy(
          accessToken: action.accessToken
      )
  );
}
