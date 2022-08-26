import 'package:intl/intl.dart';

class BookingDetailsModel {
  int? id;
  int? hospitalsId;
  int? doctorsId;
  int? patientName;
  String? phone;
  int? age;
  DateTime? bookingDate;

  BookingDetailsModel(
      {this.id,
      this.hospitalsId,
      this.doctorsId,
      this.patientName,
      this.phone,
      this.age,
      this.bookingDate});

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      BookingDetailsModel(
          id: json['id'],
          hospitalsId: json['hospitalsId'],
          doctorsId: json['doctorsId'],
          patientName: json['patientName'],
          age: json['age'],
          bookingDate:
              DateTime.parse(json['bookingDate'].toString().substring(0, 10)),
          phone: json['phone']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalsId": hospitalsId,
        "doctorsId": doctorsId,
        "patientName": patientName,
        "phone": phone,
        "bookingDate": bookingDate,
        "age": age
      };
}
