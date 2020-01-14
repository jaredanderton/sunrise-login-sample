import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:sunriselogin/redux/app/app_reducer.dart';
import 'package:sunriselogin/redux/auth/auth_middleware.dart';
import 'package:sunriselogin/redux/auth/auth_state.dart';
import 'package:sunriselogin/ui/auth/login_screen.dart';

import 'redux/app/app_state.dart';

void main() async {
  var remoteDevtools = RemoteDevToolsMiddleware('localhost:8000');

  final store = DevToolsStore<AppState>(
      appReducer,
      initialState: AppState(
        authState: AuthState()
      ),
      middleware: [
        remoteDevtools
      ]
      ..addAll(createStoreAuthMiddleware())
      ..addAll([
        LoggingMiddleware.printer(),
      ]));

  remoteDevtools.store = store;
  await remoteDevtools.connect();
  runApp(MyApp(store: store));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  MyApp({Key key, this.store}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}



