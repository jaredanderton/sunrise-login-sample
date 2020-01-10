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
  final Function(BuildContext, String, String) onLoginPressed;

  LoginVM({
    @required this.isLoading,
    @required this.authState,
    @required this.onLoginPressed,
  });

  static LoginVM fromStore(Store<AppState> store) {
    return LoginVM(
        authState: store.state.authState,
        onLoginPressed: (BuildContext context, String email, String password) {
          final Completer<String> completer = new Completer<String>();
          completer.future.then((accessToken) {
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

          store.dispatch(AuthUserLoginRequest(completer, email, password));
        });
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
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void didChangeDependencies() {
    var authState = widget.viewModel.authState;
    _emailController.text = authState.email;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;

    final Key _emailKey = Key('__login__email__');
    final Key _passwordKey = Key('__login__password__');

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: FormCard(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  key: _emailKey,
                  autocorrect: false,
                  decoration: InputDecoration(
                      labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) => val.isEmpty || val.trim().length == 0
                      ? 'Please enter your email'
                      : null,
                ),
                TextFormField(
                  controller: _passwordController,
                  key: _passwordKey,
                  autocorrect: false,
                  decoration: InputDecoration(
                      labelText: 'Password'),
                  validator: (val) => val.isEmpty || val.trim().length == 0
                      ? 'Please enter your password'
                      : null,
                  obscureText: true,
                ),
                viewModel.authState.error == null
                    ? Container()
                    : Container(
                  padding: EdgeInsets.only(top: 26.0, bottom: 4.0),
                  child: Center(
                    child: Text(
                      viewModel.authState.error,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            child: Text('LOGIN'),
            onPressed: () {
              if (!_formKey.currentState.validate()) {
                return;
              }
              viewModel.onLoginPressed(
                  context,
                  _emailController.text,
                  _passwordController.text
              );
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
