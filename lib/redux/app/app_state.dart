import 'package:sunriselogin/redux/auth/auth_state.dart';

class AppState {
  AuthState authState;
  AppState({this.authState});

  AppState copy({AuthState authState}) => AppState(
    authState: authState ?? this.authState,
  );

  toJson() {
    return {'authState': authState};
  }
}
