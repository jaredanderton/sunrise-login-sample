import 'package:sunriselogin/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'package:sunriselogin/redux/auth/auth_reducer.dart';

final appReducer = combineReducers<AppState>([
  authReducer
]);


