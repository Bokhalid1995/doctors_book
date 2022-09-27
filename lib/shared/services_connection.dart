import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:doctors_book/shared/models/user.dart';
// import 'package:doctors_book/views/user_manager/login.dart';

class ServicesConnection {
  //https://localhost:5001/api/Users/GetUserDetails
  static const base_url = "http://shihab123test-001-site1.etempurl.com/api/";

  Future<User> register(User user) async {
    final http.Response response =
        await http.post(Uri.parse("${base_url}Users/CreateUser"),
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(user.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Not Registered${response.reasonPhrase}");
    }
  }

  static Future<User> Login(String userName, String password) async {
    final http.Response response = await http.post(
        // ignore: prefer_interpolation_to_compose_strings
        Uri.parse('${base_url}Users/Login?UserName=' +
            userName +
            "&Password=" +
            password),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
    print(response.body);
    if (response.statusCode == 200) {
      User data = User.fromJson(jsonDecode(response.body));

      return data;
    } else {
      User notFound = User(userName: "notFound");
      print(notFound.userName);
      return notFound;
    }
  }

  Future<bool> Update(User user) async {
    final http.Response response =
        await http.put(Uri.parse('${base_url}Users/UpdateUser?id=${user.id}'),
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(user.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> Delete(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('${base_url}Users/DeleteUser?id=${id}'),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<User>> GetAll() async {
    final http.Response response = await http.get(
        // ignore: prefer_interpolation_to_compose_strings
        Uri.parse('${base_url}Users/GetUserDetails'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      print(result);

      return result.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception("");
    }
  }
}
