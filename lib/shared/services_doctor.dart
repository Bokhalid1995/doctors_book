// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:doctors_book/shared/models/doctors.dart';
// import 'package:doctors_book/views/DoctorsModel_manager/login.dart';

class ServicesDoctor {
  //https://localhost:5001/api/DoctorsModels/GetDoctorsModelDetails
  static const base_url = "http://shihab123test-001-site1.etempurl.com/api/";

  Future<bool> Create(DoctorsModel DoctorModel) async {
    print("${base_url}Doctors/CreateDoctor");
    final http.Response response =
        await http.post(Uri.parse('${base_url}Doctors/CreateDoctor'),
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(DoctorModel.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> Update(DoctorsModel DoctorModel) async {
    final http.Response response = await http.put(
        Uri.parse('${base_url}Doctors/UpdateDoctor?id=${DoctorModel.id}'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(DoctorModel.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> Delete(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('${base_url}Doctors/DeleteDoctor?id=${id}'),
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

  Future<List<DoctorsModel>> GetAll() async {
    final http.Response response = await http.get(
        // ignore: prefer_interpolation_to_compose_strings
        Uri.parse('${base_url}Doctors/GetDoctorDetails'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);

      return result.map((e) => DoctorsModel.fromJson(e)).toList();
    } else {
      throw Exception("");
    }
  }
}
