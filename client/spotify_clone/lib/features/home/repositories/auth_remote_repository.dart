import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<void > login(String username, String password) async {


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
      Uri.parse("http://192.168.1.82:8080/auth/signin"),
      body: json.encode(body),
      headers: header,
    );
      if (response.statusCode == 200) {
        log(response.body);
      } else {
        log(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Map<String,dynamic>> signup(
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
      Uri.parse("http://192.168.1.82:8080/auth/signup"),
      body: json.encode(body),
      headers: header,
    );
    log(response.body);
    log(response.statusCode.toString());

      if (response.statusCode == 201) {
        throw '';
      } else {
        final user = jsonDecode(response.body) as Map<String, dynamic>;
        return user;
      }
    } catch (e) {
      throw '';
    }
  }
}
