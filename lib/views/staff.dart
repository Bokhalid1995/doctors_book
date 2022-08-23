import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/staff_details_body.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class Staff extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Staff(this._hosName);
  final String _hosName;

  @override
  State<Staff> createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  String? _Specialize = "الكل";

  @override
  void initState() {
    // TODO: implement initState
  }

  String DoctorName = "";
  String Specialist = "";
  bool isLoaded = false;
  final CollectionReference _distribution =
      FirebaseFirestore.instance.collection('Distriputions');

  @override
  Widget build(BuildContext context) {
    final List<String> menuItems = [
      'الكل',
      'باطنية',
      'جراحة عامه',
      'جراحة عظام',
      'طب الاسنان',
      'اطفال'
    ];
    // print(widget._hosName);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PColor,
          title: Text(
            'الاطباء المتوفرون - ${widget._hosName}',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              'ابحث بالتخصص',
              style: TextStyle(color: Colors.grey),
            ),
            Container(
                padding: const EdgeInsets.all(5),
                height: 40,
                width: SizeConfig.screenWidth! - 20,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    items: menuItems.map((String item) {
                      return DropdownMenuItem<String>(
                          value: item, child: Text(item));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _Specialize = val!;
                      });
                    },
                    value: _Specialize == null || _Specialize == ""
                        ? "باطنية"
                        : _Specialize,
                  ),
                )),
            SizedBox(
              height: SizeConfig.screenheight! / 1.14,
              child: StreamBuilder(
                  stream: _distribution.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              // var x = "";

                              // _getDoctors(data['DoctorName']).then((value) =>
                              //     {x = value, print("Fuck" + value)});
                              // Timer(
                              //     const Duration(milliseconds: 1000), () => {});

                              // print("DoctorName" + data['DoctorName']);
                              // print("Fuuuuuuuuuuuck" +
                              //     data['HospitalName'] +
                              //     widget._hosName);
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];
                              if (data['HospitalName']
                                  .toString()
                                  .contains(widget._hosName)) {
                                if (data['Specialize'].toString() ==
                                    _Specialize) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: StaffDetailsBody(
                                        widget._hosName,
                                        data['DoctorName'],
                                        data['Specialize'],
                                        data['Day'],
                                        data['TimeFrom'],
                                        data['TimeTo']),
                                  );
                                } else if (_Specialize == "الكل") {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: StaffDetailsBody(
                                        widget._hosName,
                                        data['DoctorName'],
                                        data['Specialize'],
                                        data['Day'],
                                        data['TimeFrom'],
                                        data['TimeTo']),
                                  );
                                }
                              }

                              return Container();
                            });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getDoctors(doctorId) async {
    var Doctor = "";
    await FirebaseFirestore.instance
        .collection('doctors')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                if (doctorId == doc.id) {
                  Doctor = doc["DoctorName"];
                  print("Doctor" + Doctor);
                }
              })
            });
    return Doctor;
  }
}
