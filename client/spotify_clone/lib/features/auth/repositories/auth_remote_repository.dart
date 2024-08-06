import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/constants/server_constant.dart';
import 'package:spotify_clone/features/auth/model/User.dart';


part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<Exception,User>> login(String username, String password) async {


    try {
      const Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var body = {
      "username": username,
      "password": password,
    };
    final response = await http.post(
      Uri.parse("${ServerConstant.BASE_URL}/auth/signin"),
      body: json.encode(body),
      headers: header,
    );
      if (response.statusCode == 200) {

        return right(User.fromJson(response.body));
      } else {

        return left(Exception(response.body));
      }
    } catch (e) {

      return left(Exception(e.toString()));
    }
  }

  Future<Either<Exception,User>> signup(
      {required String name,
      required String email,
      required String password}) async {
  

    try {
        
    const Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var body = {
      "name": name,
      "username": email,
      "password": password,
    };

    final response = await http.post(
      Uri.parse("${ServerConstant.BASE_URL}/auth/signup"),
      body: json.encode(body),
      headers: header,
    );


      if (response.statusCode == 200) {
        return right(User.fromJson(response.body));
      } else {
        return left(Exception(response.body));
      }
    } catch (e) {
      return left(Exception(e.toString()));
    }
  }
}
