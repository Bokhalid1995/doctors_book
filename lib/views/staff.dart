import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/staff_details_body.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class StaffDetails {
  String name;
  String category;
  String details;
  String phone;
  String imagePath;

  StaffDetails(
      this.name, this.category, this.details, this.imagePath, this.phone);

  static StaffDetails fromJson(Map<String, dynamic> json) => StaffDetails(
        json['name'],
        json['category'],
        json['details'],
        json['phone'],
        json['imagePath'],
      );
}

var moreStaffDetailsItems = [
  StaffDetails(
      "د. نزار السر ",
      "اخصائي النساء والتوليد",
      "نوفر خدمة موجات صوتيه اليه الدقة وعلي مدي 24 ساعه والنتيجه فوريه",
      "assets/images/pic_6.jpg",
      "0922164150"),
  StaffDetails(
      "د. الطيب ابايزيد",
      "اخصائي الأطفال",
      "غرف مجهزة بأفضل وسائل الراحة للمرضي وبمواصفات ممتازة جدا",
      "assets/images/pic_7.jpg",
      "0920888593"),
  StaffDetails(
      "د. محبوب الهاشمي",
      "اخصائي العظام",
      "غرف مجهزة بأفضل وسائل الراحة للمرضي وبمواصفات ممتازة جدا",
      "assets/images/pic_6.jpg",
      "0114195290"),
  StaffDetails(
      "د. احمد خالد",
      "اخصائي الأطفال",
      "غرف مجهزة بأفضل وسائل الراحة للمرضي وبمواصفات ممتازة جدا",
      "assets/images/pic_7.jpg",
      "0920829900"),
  StaffDetails(
      "د. ألاء عثمان",
      "اخصائي الباطنية",
      "غرف مجهزة بأفضل وسائل الراحة للمرضي وبمواصفات ممتازة جدا",
      "assets/images/pic_7.jpg",
      "0962000077"),
];

class Staff extends StatefulWidget {
  const Staff(this._hosName);
  final String _hosName;

  @override
  State<Staff> createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  final CollectionReference _distribution =
      FirebaseFirestore.instance.collection('Distriputions');
  @override
  Widget build(BuildContext context) {
    print(widget._hosName);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PColor,
          title: Text(
            'الاطباء المتوفرون | ' + widget._hosName,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: SizeConfig.screenheight! / 1.14,
              child: StreamBuilder(
                  stream: _distribution.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];
                              // print("DoctorName" + data['DoctorName']);
                              // print("Fuuuuuuuuuuuck" +
                              //     data['HospitalName'] +
                              //     widget._hosName);
                              if (data['HospitalName']
                                  .toString()
                                  .contains(widget._hosName)) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: StaffDetailsBody(
                                      data['DoctorName'],
                                      data['Day'],
                                      data['TimeFrom'],
                                      data['TimeTo']),
                                );
                              }
                              return const Text('');
                            });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

Stream<List<StaffDetails>> getStaffDetails() => FirebaseFirestore.instance
    .collection('doctors')
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((docs) => StaffDetails.fromJson(docs.data()))
        .toList());
