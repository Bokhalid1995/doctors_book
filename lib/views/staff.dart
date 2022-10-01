import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/staff_details_body.dart';
import 'package:doctors_book/shared/models/distributions.dart';
import 'package:doctors_book/shared/models/doctors.dart';
import 'package:doctors_book/shared/models/specialize.dart';
import 'package:doctors_book/shared/services_distributions.dart';
import 'package:doctors_book/shared/services_doctor.dart';
import 'package:doctors_book/shared/services_hospital.dart';
import 'package:doctors_book/shared/services_specialize.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../shared/models/hospitals.dart';

class Staff extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Staff(this._hosName, this._hosId);
  final int _hosId;
  final String _hosName;

  @override
  State<Staff> createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  List<SpecializesModel> menuItems = [];
  var speclizerApi = ServicesSpecializes();

  List<HospitalsModel> hospitalList = [];
  List<DoctorsModel> doctorList = [];
  var hospitalApi = ServicesHospital();
  var doctorApi = ServicesDoctor();
  var distributionApi = ServicesDistributions();
  int? _Specialize = 1;

  String DoctorName = "";
  String Specialist = "";
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    speclizerApi.GetAll().then((value) => menuItems = value);
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget._hosName);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              height: 120,
              width: SizeConfig.screenWidth,
              decoration: const BoxDecoration(
                  // border: Border.all(color: PColor),
                  color: PColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30,
                        color: Colors.white,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'الاطباء المتوفرون',
                        style: TextStyle(
                          // color: PColor,
                          color: Colors.white,

                          fontSize: 11,
                        ),
                      ),
                      Text(
                        widget._hosName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: Lottie.asset('assets/images/img_2.json'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'ابحث بالتخصص',
              style: TextStyle(color: Colors.grey),
            ),
            Container(
                padding: const EdgeInsets.all(10),
                height: 50,
                width: SizeConfig.screenWidth! - 20,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 5,
                          offset: Offset(0, 3))
                    ],
                    borderRadius: BorderRadius.circular(30)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<int>(
                    items: menuItems.length == 0
                        ? []
                        : menuItems.map((SpecializesModel item) {
                            return DropdownMenuItem<int>(
                                value: item.id, child: Text(item.name!));
                          }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _Specialize = val!;
                      });
                    },
                    value: _Specialize == null ? menuItems[0].id : _Specialize,
                  ),
                )),
            SizedBox(
              height: SizeConfig.screenheight! / 1.14,
              child: FutureBuilder(
                  future: distributionApi.GetAll(),
                  builder: (context,
                      AsyncSnapshot<List<DistributionsModel>> snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.length,
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
                              DistributionsModel data = snapshot.data![index];
                              if (data.hospitalsId == widget._hosId) {
                                if (data.specializeId == _Specialize) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: StaffDetailsBody(
                                        widget._hosName.toString(),
                                        widget._hosId,
                                        data.doctorsName!,
                                        data.doctorsId!,
                                        data.specializeName,
                                        data.day!,
                                        data.timeFrom!,
                                        data.timeTo!),
                                  );
                                } else if (_Specialize == null) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: StaffDetailsBody(
                                        widget._hosName.toString(),
                                        widget._hosId,
                                        data.doctorsName!,
                                        data.doctorsId!,
                                        data.userId.toString(),
                                        data.day!,
                                        data.timeFrom!,
                                        data.timeTo!),
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
}
