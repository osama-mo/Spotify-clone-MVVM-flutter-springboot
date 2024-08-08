import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(AuthLocalRepositoryRef ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository{
  late SharedPreferences _sharedPreferences;
  
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String token) async {
    await _sharedPreferences.setString('auth-token', token);
  }

  Future<String?> getToken() async {
    return _sharedPreferences.getString('auth-token');
  }
}