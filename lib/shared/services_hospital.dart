// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:doctors_book/shared/models/hospitals.dart';
// import 'package:doctors_book/views/HospitalsModel_manager/login.dart';

class ServicesHospital {
  //https://localhost:5001/api/HospitalsModels/GetHospitalsModelDetails
  static const base_url = "http://shihab123test-001-site1.etempurl.com/api/";

  Future<bool> Create(HospitalsModel HospitalModel) async {
    print("${base_url}Hospitals/CreateHospital");
    final http.Response response =
        await http.post(Uri.parse('${base_url}Hospitals/CreateHospital'),
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(HospitalModel.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> Update(HospitalsModel HospitalModel) async {
    final http.Response response = await http.put(
        Uri.parse('${base_url}Hospitals/UpdateHospital?id=${HospitalModel.id}'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(HospitalModel.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<HospitalsModel>> GetAll() async {
    final http.Response response = await http.get(
        // ignore: prefer_interpolation_to_compose_strings
        Uri.parse('${base_url}Hospitals/GetHospitalDetails'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);

      return result.map((e) => HospitalsModel.fromJson(e)).toList();
    } else {
      throw Exception("");
    }
  }
}
