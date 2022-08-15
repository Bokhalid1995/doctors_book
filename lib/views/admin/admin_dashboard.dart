import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/custom_button.dart';
import 'package:doctors_book/core/widgets/drawer.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final box = GetStorage();
  String user = "";
  String hospital = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = box.read('UserName');
    hospital = box.read('HospitalName');
  }

  bool isConfirmed = false;
  final CollectionReference _booking =
      FirebaseFirestore.instance.collection('BookingDetails');

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: PColor,
        title: const Text("لوحة التحكم"),
      ),
      drawer: const CustomDrawer(),
      body: ListView(
        children: [
          Container(
            width: SizeConfig.screenWidth! - 20,
            height: 70,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: PColor.withOpacity(0.20),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "مرحبا $user",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: PColor, fontSize: 15),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "قائمة حجوزات اليوم",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: PColor, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: SizeConfig.screenheight,
            child: StreamBuilder(
                stream: _booking.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot data = snapshot.data!.docs[index];
                            if (data['Status'] == "Waiting") {
                              isConfirmed = false;
                            } else {
                              isConfirmed = true;
                            }

                            if (hospital == data['HospitalName']) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                // child: hospitalDetailsBody(data['name'],data['category'],data['details'],data['phone'],data['imagepath']),
                                child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    leading: IconButton(
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () {
                                        DeleteBooking(data.id);
                                      },
                                    ),
                                    // ignore: prefer_interpolation_to_compose_strings
                                    title: Text(
                                      'اسم المريض : ' + data['PatientName'],
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    // ignore: prefer_interpolation_to_compose_strings
                                    subtitle: Text('التاريخ : ' +
                                        data['BookingDate'] +
                                        ' | ' +
                                        data['TimeFrom'] +
                                        '- ' +
                                        data['TimeTo']),
                                    trailing: IconButton(
                                      icon: Icon(
                                        isConfirmed == true
                                            ? Icons.check
                                            : Icons.info,
                                        color: PColor,
                                      ),
                                      onPressed: () {
                                        Update(data);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          });
                }),
          ),
        ],
      ),
    );
  }

  Future<void> Update([DocumentSnapshot? documentSnapshot]) async {
    bool checkConfirm = documentSnapshot!['Status'] == "Accept" ? true : false;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
                padding: const EdgeInsets.all(8),
                height: 350,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Container(
                        width: SizeConfig.screenWidth! / 2,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 6, 90, 8)
                              .withOpacity(0.20),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "تأكيد  اجراء الحجز",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color.fromARGB(255, 6, 90, 8)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.connect_without_contact_outlined,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        const Text('اسم المريض: '),
                        const SizedBox(width: 10),
                        Text(documentSnapshot['PatientName']),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        const Text('الطبيب: '),
                        const SizedBox(width: 10),
                        Text(documentSnapshot['DoctorName']),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.house_siding_sharp,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        const Text('المستشفي: '),
                        const SizedBox(width: 10),
                        Text(documentSnapshot['HospitalName']),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        const Text('تاريخ الحجز: '),
                        const SizedBox(width: 10),
                        Text(documentSnapshot['BookingDate']),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Builder(builder: (context) {
                      return IgnorePointer(
                        ignoring: checkConfirm ? true : false,
                        child: GeneralButton(
                          customText:
                              checkConfirm ? 'تم التأكيد ' : 'تأكيد الحجز',
                          color: checkConfirm ? Colors.blueGrey[200] : PColor,
                          raduis: 30,
                          onTap: () {
                            _booking.doc(documentSnapshot.id).update({
                              "Status": "Accept",
                            });

                            scaffoldKey.currentState!.showSnackBar(SnackBar(
                              content: const Text(
                                "تم تأكيد الحجز بنجاح",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: PColor,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ));
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    GeneralButton(
                      customText: 'الغاء',
                      color: Colors.redAccent,
                      raduis: 30,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )),
          );
        });
  }

  Future<void> DeleteBooking(String Id) async {
    _booking.doc(Id).delete();

    scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: const Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          "تم الغاء الحجز بنجاح ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ));
  }
}
