// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:doctors_book/shared/models/specialize.dart';
// import 'package:doctors_book/views/SpecializesModel_manager/login.dart';

class ServicesSpecializes {
  //https://localhost:5001/api/SpecializesModels/GetSpecializesModelDetails
  static const base_url = "http://shihab123test-001-site1.etempurl.com/api/";

  Future<bool> Create(SpecializesModel SpecializesModel) async {
    print("${base_url}Specializes/CreateSpecializes");
    final http.Response response =
        await http.post(Uri.parse('${base_url}Specializes/CreateSpecialize'),
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(SpecializesModel.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> Update(SpecializesModel SpecializesModel) async {
    final http.Response response = await http.put(
        Uri.parse(
            '${base_url}Specializes/UpdateSpecialize?id=${SpecializesModel.id}'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(SpecializesModel.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> Delete(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('${base_url}Specializes/DeleteSpecializes?id=${id}'),
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

  Future<List<SpecializesModel>> GetAll() async {
    final http.Response response = await http.get(
        // ignore: prefer_interpolation_to_compose_strings
        Uri.parse('${base_url}Specializes/GetSpecializeDetails'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);

      return result.map((e) => SpecializesModel.fromJson(e)).toList();
    } else {
      throw Exception("");
    }
  }
}
