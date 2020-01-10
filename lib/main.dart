import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:sunriselogin/redux/app/app_reducer.dart';
import 'package:sunriselogin/redux/auth/auth_middleware.dart';
import 'package:sunriselogin/ui/auth/login_screen.dart';

import 'redux/app/app_state.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState(),
      middleware: []
        ..addAll(createStoreAuthMiddleware())
        ..addAll([
          LoggingMiddleware.printer(),
        ]));

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



