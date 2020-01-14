import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sunriselogin/redux/app/app_state.dart';
import 'package:sunriselogin/redux/auth/auth_actions.dart';
import 'package:sunriselogin/redux/auth/auth_state.dart';
import 'package:redux/redux.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, LoginVM>(
        converter: LoginVM.fromStore,
        builder: (context, vm) {
          return LoginView(
            viewModel: vm,
          );
        },
      ),
    );
  }
}

class LoginVM {
  bool isLoading;
  AuthState authState;
//  String email;
  final Function(BuildContext) onLoginPressed;
  final Function(String email) onEmailChanged;
  final Function(String password) onPasswordChanged;

  LoginVM({
    @required this.isLoading,
    @required this.authState,
    @required this.onLoginPressed,
    @required this.onEmailChanged,
    @required this.onPasswordChanged,
  });

  static LoginVM fromStore(Store<AppState> store) {
    return LoginVM(
        authState: store.state.authState,
        onLoginPressed: (BuildContext context) {
          final Completer<String> completer = new Completer<String>();
          completer.future.then((accessToken) {
            store.dispatch(AuthUserLoginSetAccessToken(accessToken));
            if(accessToken != null) {
              final snackBar = SnackBar(
                content: Text("Access Token: ${accessToken}"),
                backgroundColor: Colors.blue,
              );
              Scaffold.of(context).showSnackBar(snackBar);
            } else {
              final snackBar = SnackBar(
                content: Text("Login Failed"),
                backgroundColor: Colors.red,
              );
              Scaffold.of(context).showSnackBar(snackBar);
            }

          });
          store.dispatch(AuthUserLoginRequest(completer));
        },
        onEmailChanged: (String email) {
          store.dispatch(AuthUserLoginSetEmail(email));
        },
        onPasswordChanged: (String password) {
          store.dispatch(AuthUserLoginSetPassword(password));
        },
      );
  }
}


class LoginView extends StatefulWidget {
  final LoginVM viewModel;

  LoginView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginView> {

  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    LoginVM viewModel = widget.viewModel;

// this is really bad, but seems to be neccessary (maybe just for when the keyboard is dismissed, but we're still typing; e.g. development/ external keyboard) - need to research this
    _emailController.value = _emailController.value.copyWith(text: viewModel?.authState?.email, selection: TextSelection.collapsed(offset: viewModel?.authState?.email?.length ?? -1));
    _passwordController.value = _passwordController.value.copyWith(text: viewModel?.authState?.password, selection: TextSelection.collapsed(offset: viewModel?.authState?.password?.length ?? -1));

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Form(
            child: FormCard(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  autocorrect: false,
                  decoration: InputDecoration(labelText: 'Email:'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (email) => viewModel.onEmailChanged(email),
                ),
                TextFormField(
                  controller: _passwordController,
                  autocorrect: false,
                  decoration: InputDecoration(labelText: 'Password'),
                  onChanged: (password) => viewModel.onPasswordChanged(password),
                  obscureText: true,
                ),
              ],
            ),
          ),
          RaisedButton(
            child: Text('LOGIN'),
            onPressed: () {
              viewModel.onLoginPressed(context);
            },
          ),
        ],
      ),
    );
  }
}


class FormCard extends StatelessWidget {

  FormCard({
    Key key,
    @required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
