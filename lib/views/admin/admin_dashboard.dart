import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/custom_button.dart';
import 'package:doctors_book/core/widgets/drawer.dart';
import 'package:doctors_book/shared/models/bookingDetails.dart';
import 'package:doctors_book/shared/services_bookingDetails.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as wi;

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final box = GetStorage();
  String user = "";
  String hospital = "";
  final TextEditingController _searchControl = TextEditingController();
  String _searchText = "";
  List<BookingDetailsModel?> bookingList = [];
  var filterData = [];
  var BookingDetailsApi = ServicesBookingDetails();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = box.read('UserName');
    // hospital = box.read('HospitalName');
    BookingDetailsApi.GetAll().then((value) => bookingList = value);
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        filterData = bookingList;
      });
      if (user == null || user == "") {}
    });
  }

  bool isConfirmed = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: PColor,
        title: const Text("التقارير"),
      ),
      drawer: CustomDrawer(popOut: () {
        Navigator.of(this.context).pop();
      }),
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
                  "تقرير بجميع الحجوزات",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: PColor, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: _searchControl,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.grey.shade300,
                ),
                contentPadding: const EdgeInsets.all(5),
                border: const OutlineInputBorder(),
                labelText: '  بحث بأسم المريض , الطبيب  أو تاريخ الحجز ...',
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                  filterData = bookingList
                      .where((data) =>
                          data!.patientName.toString().contains(_searchText) ||
                          data.doctorsName.toString().contains(_searchText) ||
                          data.bookingDate.toString().contains(_searchText) ||
                          data.hospitalsName.toString().contains(_searchText))
                      .toList();
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: SizeConfig.screenWidth! - 50,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: PColor.withOpacity(0.20),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "الإجمالي ( ${filterData.length} ) ",
              textAlign: TextAlign.center,
              style: TextStyle(color: PColor, fontSize: 13),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              dividerThickness: 2,
              headingRowColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.grey.withOpacity(0.20)),
              columnSpacing: 38.0,
              columns: [
                DataColumn(
                    label: Text(
                  'الاسم',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue.shade300),
                )),
                DataColumn(
                    label: Text(
                  'العمر',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue.shade300),
                )),
                DataColumn(
                    label: Text(
                  'الطبيب',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue.shade300),
                )),
                DataColumn(
                    label: Text(
                  'تاربخ الحجز',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue.shade300),
                )),
                DataColumn(
                    label: Text(
                  'المستشفي',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue.shade300),
                )),
              ],
              rows: List.generate(filterData.length, (index) {
                final y = filterData[index]!.patientName.toString();

                final x = filterData[index]!.age.toString();
                final z = filterData[index]!.bookingDate.toString();
                final w = filterData[index]!.doctorsName.toString();
                final o = filterData[index]!.hospitalsName.toString();

                return DataRow(cells: [
                  DataCell(Container(width: 75, child: Text(y))),
                  DataCell(Container(child: Text(x))),
                  DataCell(Container(child: Text(w))),
                  DataCell(Container(child: Text(z))),
                  DataCell(Container(child: Text(o)))
                ]);
              }),
            ),
          )
        ],
      ),
    );
  }

  Future<void> Update(BookingDetailsModel? documentSnapshot) async {
    //bool checkConfirm = documentSnapshot!['Status'] == "Accept" ? true : false;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          " تفاصيل الحجز",
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.connect_without_contact_outlined,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        const Text('اسم المريض: '),
                        const SizedBox(width: 10),
                        Text(documentSnapshot!.patientName.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        const Text('الطبيب: '),
                        const SizedBox(width: 10),
                        Text(documentSnapshot.doctorsName!),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.house_siding_sharp,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        const Text('المستشفي: '),
                        const SizedBox(width: 10),
                        Text(documentSnapshot.hospitalsName!),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        const Text('تاريخ الحجز: '),
                        const SizedBox(width: 10),
                        Text(documentSnapshot.bookingDate!),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Builder(builder: (context) {
                    //   return IgnorePointer(
                    //     ignoring: checkConfirm ? true : false,
                    //     child: GeneralButton(
                    //       customText:
                    //           checkConfirm ? 'تم التأكيد ' : 'تأكيد الحجز',
                    //       color: checkConfirm ? Colors.blueGrey[200] : PColor,
                    //       raduis: 30,
                    //       onTap: () {
                    //         _booking.doc(documentSnapshot.id).update({
                    //           "Status": "Accept",
                    //         });

                    //         scaffoldKey.currentState!.showSnackBar(SnackBar(
                    //           content: const Text(
                    //             "تم تأكيد الحجز بنجاح",
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //               fontFamily: 'Cairo',
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //           backgroundColor: PColor,
                    //           behavior: SnackBarBehavior.floating,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(24),
                    //           ),
                    //         ));
                    //         Navigator.of(context).pop();
                    //       },
                    //     ),
                    //   );
                    // }),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    GeneralButton(
                      customText: 'رجوع',
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

  Future<void> DeleteBooking(int Id) async {
    BookingDetailsApi.Delete(Id).then((value) {
      if (value == true) {
        scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: const Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "تم حذف العنصر",
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
        setState(() {});
      } else {
        scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: const Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "لم يتم حذف العنصر",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: Colors.blue.shade300,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ));
      }
    });
  }
}
