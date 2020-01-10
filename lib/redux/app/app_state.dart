import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:sunriselogin/redux/auth/auth_state.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AuthState get authState;


  factory AppState() {
    return _$AppState._(
      authState: AuthState(),
    );
  }

  AppState._();
  static Serializer<AppState> get serializer => _$appStateSerializer;

}
