// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:doctors_book/shared/models/distributions.dart';
// import 'package:doctors_book/views/DistributionsModel_manager/login.dart';

class ServicesDistributions {
  //https://localhost:5001/api/DistributionsModels/GetDistributionsModelDetails
  static const base_url = "http://shihab123test-001-site1.etempurl.com/api/";

  Future<bool> Create(DistributionsModel DistributionModel) async {
    print("${base_url}Distributions/CreateDistribution");

    final http.Response response = await http.post(
        Uri.parse('${base_url}Distributions/CreateDistribution'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(DistributionModel.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception((e) => e.toString());
    }
  }

  Future<bool> Update(DistributionsModel DistributionModel) async {
    final http.Response response = await http.put(
        Uri.parse(
            '${base_url}Distributions/UpdateDistribution?id=${DistributionModel.id}'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(DistributionModel.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> Delete(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('${base_url}Distributions/DeleteDistribution?id=$id'),
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

  Future<List<DistributionsModel>> GetAll() async {
    final http.Response response = await http.get(
        // ignore: prefer_interpolation_to_compose_strings
        Uri.parse('${base_url}Distributions/GetDistributionDetails'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);

      return result.map((e) => DistributionsModel.fromJson(e)).toList();
    } else {
      throw Exception((e) => e.toString());
    }
  }
}
