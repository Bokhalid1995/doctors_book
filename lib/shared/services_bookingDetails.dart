// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:doctors_book/shared/models/bookingDetails.dart';
// import 'package:doctors_book/views/BookingDetailsModel_manager/login.dart';

class ServicesBookingDetails {
  //https://localhost:5001/api/BookingDetailsModels/GetBookingDetailsModelDetails
  static const base_url = "http://shihab123test-001-site1.etempurl.com/api/";

  Future<bool> Create(BookingDetailsModel bookingDetailsModel) async {
    print("${base_url}BookingDetails/CreatebookingDetails");
    final http.Response response = await http.post(
        Uri.parse('${base_url}BookingDetails/CreateBookingDetails'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(bookingDetailsModel.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> Update(BookingDetailsModel bookingDetailsModel) async {
    final http.Response response = await http.put(
        Uri.parse(
            '${base_url}BookingDetails/UpdateBookingDetails?id=${bookingDetailsModel.id}'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(bookingDetailsModel.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> Delete(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('${base_url}BookingDetails/DeleteBookingDetails?id=$id'),
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

  Future<List<BookingDetailsModel>> GetAll() async {
    final http.Response response = await http.get(
        // ignore: prefer_interpolation_to_compose_strings
        Uri.parse('${base_url}BookingDetails/GetBookingDetailsDetails'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      print(result);

      return result.map((e) => BookingDetailsModel.fromJson(e)).toList();
    } else {
      throw Exception("");
    }
  }
}
