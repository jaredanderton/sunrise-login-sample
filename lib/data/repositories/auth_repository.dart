import 'package:sunriselogin/data/data_sources/auth_datasource.dart';
import 'package:sunriselogin/models/auth/auth_response.dart';

class AuthRepository {
  AuthDataSource _dataSource;
  AuthRepository(this._dataSource);

  Future<AuthResponse> login(String email, String password, bool remember) async {
    return await _dataSource.loginRequest(email, password, remember);
  }
}