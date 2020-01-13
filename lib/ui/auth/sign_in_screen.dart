import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:sunriselogin/main.dart';
import 'package:sunriselogin/redux/app_state.dart';
import 'package:sunriselogin/redux/auth/sign_in_actions.dart';


class SignInScreenConnector extends StatelessWidget {
  SignInScreenConnector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SignInViewModel>(
      model: SignInViewModel(),
      builder: (BuildContext context, SignInViewModel vm) {
        return Stack(children: [
          SignInScreen(
            email: vm.email,
            password: vm.password,
            accessToken: vm.accessToken,
            waiting: vm.waiting,
            onSubmit: vm.onSubmit,
          ),
          if (vm.waiting) ModalBarrier(color: Colors.black.withOpacity(0.4)),
        ]);
      }
    );
  }
}

class SignInViewModel extends BaseModel<AppState> {
  SignInViewModel({this.email, this.password, this.accessToken, this.waiting, this.onSubmit});

  final String email;
  final String password;
  final String accessToken;
  final bool waiting;
  final VoidCallback onSubmit;

// could this be generated?
  SignInViewModel.build({
    @required this.email,
    @required this.password,
    @required this.accessToken,
    @required this.waiting,
    @required this.onSubmit,
  }) : super(equals: [email, password, accessToken, waiting]);

  @override
  SignInViewModel fromStore() => SignInViewModel.build(
    email: state.signInState.email,
    password: state.signInState.password,
    accessToken: state.signInState.accessToken,
    waiting: state.signInState.waiting,
    onSubmit: () => dispatch(SignInAttemptAction()),
  );
}

class SignInScreen extends StatelessWidget {
  final String email;
  final String password;
  final String accessToken;
  final bool waiting;
  final VoidCallback onSubmit;

  SignInScreen({Key key, this.email, this.password, this.accessToken, this.waiting, this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Center(child:
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Access Token: $accessToken"),
          TextField(
            autocorrect: false,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) => store.dispatch(SignInSetEmailAction(email: text)),
          ),
          TextFormField(
            autocorrect: false,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            onChanged: (text) => store.dispatch(SignInSetPasswordAction(password: text)),
          ),
          RaisedButton(
            child: Text('Sign In'),
            onPressed: onSubmit,
          ),

        ]),
      );
  }
}

//