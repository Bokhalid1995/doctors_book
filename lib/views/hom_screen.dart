import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/shared/models/bookingDetails.dart';
import 'package:doctors_book/shared/models/doctors.dart';
import 'package:doctors_book/shared/services_bookingDetails.dart';
import 'package:doctors_book/shared/services_doctor.dart';
import 'package:doctors_book/shared/services_hospital.dart';
import 'package:flutter/material.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/more_details.dart';
import 'package:doctors_book/core/widgets/services_details.dart';
import 'package:doctors_book/core/widgets/vertical_panner.dart';

import '../shared/models/hospitals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference _doctors =
      FirebaseFirestore.instance.collection('doctors');

  List<HospitalsModel> hospitalList = [];
  List<DoctorsModel> doctorList = [];
  List<BookingDetailsModel> bookingList = [];
  var hospitalApi = ServicesHospital();
  var doctorApi = ServicesDoctor();
  var bookingApi = ServicesBookingDetails();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    hospitalApi.GetAll().then((value) => hospitalList = value);
    doctorApi.GetAll().then((value) => doctorList = value);
    bookingApi.GetAll().then((value) => bookingList = value);
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            //   Container(
            //     padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            //     decoration: const BoxDecoration(
            //       color: PColor,
            //       borderRadius:
            //           BorderRadius.vertical(bottom: Radius.circular(30)),
            //     ),
            //     width: SizeConfig.screenWidth!,
            //     child: Image.asset(
            //       "assets/images/insurance/pic (7).png",
            //       width: SizeConfig.screenWidth! / 2,
            //       height: 150,
            //     ),
            //   ),
            Container(
              height: SizeConfig.screenheight! * 2,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        GroceryFeaturedCard(
                            GroceryFeaturedItem(
                                'مستشفي', '', hospitalList.length),
                            const Color(0xff068e93)),
                        const SizedBox(
                          width: 15,
                        ),
                        GroceryFeaturedCard(
                            GroceryFeaturedItem('حجز', '', bookingList.length),
                            PColor),
                        const SizedBox(
                          width: 15,
                        ),
                        GroceryFeaturedCard(
                            GroceryFeaturedItem('طبيب', '', doctorList.length),
                            const Color(0xff7506af)),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          '  قائمة من أميز الأطباء في السودان  ',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder(
                    stream: _doctors.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                height: SizeConfig.screenheight!,
                                padding: EdgeInsets.all(10),
                                child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot data =
                                        snapshot.data!.docs[index];
                                    return Column(
                                      children: [
                                        MoreDetails(
                                          name: data['DoctorName'],
                                          degree: data['QualifiedCert'],
                                          spec: data['Specialize'],
                                          press: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context) => ServicesBodyDetails(moreServicesDetailsItems[0]),
                                            //   ),
                                            // );
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    );
                                  },
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
