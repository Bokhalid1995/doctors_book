import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/staff_details_body.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

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
            'الاطباء المتوفرون - ' + widget._hosName,
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
                                      widget._hosName,
                                      data['DoctorName'],
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
}
