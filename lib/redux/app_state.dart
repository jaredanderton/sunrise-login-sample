import 'package:sunriselogin/redux/auth/sign_in_state.dart';

class AppState {
  final SignInState signInState;

  AppState({this.signInState});

  AppState copy({SignInState signInState}) => AppState(
    signInState: signInState ?? this.signInState,
  );

  static AppState initialState() => AppState(
      signInState: SignInState(),
  );
}