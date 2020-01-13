import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:sunriselogin/redux/app_state.dart';
import 'package:sunriselogin/ui/auth/sign_in_screen.dart';

Store<AppState> store;

void main() {
  AppState state = AppState.initialState();
  store = Store<AppState>(
      initialState: state
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Async Redux Sunrise Signin')),
          body: SignInScreenConnector(),
        ),
      )
  );
}




