import 'package:dio/dio.dart';
import 'package:sunriselogin/data/api.dart';
import 'package:sunriselogin/models/auth/auth_response.dart';

class AuthDataSource {
  Api _api;
  AuthDataSource(this._api);
  String get host {
    // environment check here
    return 'http://localhost:4100';
  }

  Future<AuthResponse> loginRequest(String email, String password, bool remember) async {

    Map<String, dynamic> data = {
      "credentials": {
        "email": email,
        "password": password,
        'remember': remember
      }
    };
    Response response = await _api.post('${host}/v2/user/login', data);
    return AuthResponseJsonSerializer().fromMap(response?.data);
  }

}