import 'package:intl/intl.dart';

class BookingDetailsModel {
  int? id;
  int? hospitalsId;
  int? doctorsId;
  int? userId;
  String? hospitalsName;
  String? doctorsName;
  int? patientName;
  String? phone;
  int? age;
  String? bookingDate;

  BookingDetailsModel(
      {this.id,
      this.hospitalsId,
      this.doctorsId,
      this.userId,
      this.hospitalsName,
      this.doctorsName,
      this.patientName,
      this.phone,
      this.age,
      this.bookingDate});

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      BookingDetailsModel(
          id: json['id'],
          hospitalsId: json['hospitalsId'],
          doctorsId: json['doctorsId'],
          userId: json['userId'],
          hospitalsName: json['hospitalsName'],
          doctorsName: json['doctorsName'],
          patientName: json['patientName'],
          age: json['age'],
          bookingDate: json['bookingDate'].toString().substring(0, 10),
          phone: json['phone']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalsId": hospitalsId,
        "doctorsId": doctorsId,
        "userId": userId,
        "hospitalName": hospitalsName,
        "doctorsName": doctorsName,
        "patientName": patientName,
        "phone": phone,
        "bookingDate": bookingDate,
        "age": age
      };
}
