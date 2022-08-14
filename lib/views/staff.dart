import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/staff_details_body.dart';
import 'package:flutter/material.dart';

class Staff extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Staff(this._hosName);
  final String _hosName;

  @override
  State<Staff> createState() => _StaffState();
}

class _StaffState extends State<Staff> {
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
                              var x = "";
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];
                              _getDoctors(data['DoctorName']).then((value) =>
                                  {x = value, print("Fuck" + value)});
                              Timer(
                                  const Duration(milliseconds: 1000), () => {});

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
                                      widget._hosName,
                                      x,
                                      data['Day'],
                                      data['TimeFrom'],
                                      data['TimeTo']),
                                );
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
