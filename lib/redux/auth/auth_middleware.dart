import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:sunriselogin/data/api.dart';
import 'package:sunriselogin/data/data_sources/auth_datasource.dart';
import 'package:sunriselogin/data/repositories/auth_repository.dart';
import 'package:sunriselogin/redux/app/app_state.dart';
import 'package:sunriselogin/redux/auth/auth_actions.dart';

List<Middleware<AppState>> createStoreAuthMiddleware() {

  Api _api = Api();
  AuthDataSource _dataSource = AuthDataSource(_api);
  AuthRepository repository = AuthRepository(_dataSource);
  final _authloginRequest = _createAuthLoginRequest(repository);

  return [
    TypedMiddleware<AppState, AuthUserLoginRequest>(_authloginRequest),
  ];
}

Middleware<AppState> _createAuthLoginRequest(AuthRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.login(store.state.authState.email, store.state.authState.password, true).then((data) {
        action.completer.complete(data?.meta?.accessToken);
      });
    next(action);
  };
}
