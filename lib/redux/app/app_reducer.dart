import 'package:sunriselogin/redux/app/app_state.dart';
import 'package:sunriselogin/redux/auth/auth_reducer.dart';

AppState appReducer(AppState state, action) {

  return state.rebuild((b) => b
    ..authState.replace(authReducer(state.authState, action))
  );
}


