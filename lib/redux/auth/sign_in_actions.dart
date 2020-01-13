import 'package:async_redux/async_redux.dart';
import 'package:sunriselogin/data/api.dart';
import 'package:sunriselogin/data/data_sources/auth_datasource.dart';
import 'package:sunriselogin/data/repositories/auth_repository.dart';
import 'package:sunriselogin/models/auth/auth_response.dart';
import 'package:sunriselogin/redux/app_state.dart';

class SignInAttemptAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
// dep inject
    Api _api = Api();
    AuthDataSource _dataSource = AuthDataSource(_api);
    AuthRepository repository = AuthRepository(_dataSource);

    AuthResponse response = await repository.login(state.signInState.email, state.signInState.password, true);
    return state.copy(
        signInState: state.signInState.copy(accessToken: response?.meta?.accessToken)
    );
  }

  void before() => dispatch(SignInWaitAction(waiting: true));
  void after() => dispatch(SignInWaitAction(waiting: false));
}

class SignInSetAccessTokenAction extends ReduxAction<AppState> {
  String accessToken;
  SignInSetAccessTokenAction({this.accessToken});
  AppState reduce() {
    return state.copy(
        signInState: state.signInState.copy(accessToken: accessToken)
    );
  }
}

class SignInSetEmailAction extends ReduxAction<AppState> {
  String email;
  SignInSetEmailAction({this.email});
  AppState reduce() {
    return state.copy(
        signInState: state.signInState.copy(email: email)
    );
  }
}

class SignInSetPasswordAction extends ReduxAction<AppState> {
  String password;
  SignInSetPasswordAction({this.password});
  AppState reduce() {
    return state.copy(
        signInState: state.signInState.copy(password: password)
    );
  }
}

class SignInWaitAction extends ReduxAction<AppState> {
  bool waiting;
  SignInWaitAction({this.waiting});
  AppState reduce() {
    return state.copy(
        signInState: state.signInState.copy(waiting: waiting)
    );
  }
}

