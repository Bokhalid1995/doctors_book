// ignore_for_file: deprecated_member_use, non_constant_identifier_TimeFroms

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';

import 'package:doctors_book/core/widgets/custom_button.dart';
import 'package:doctors_book/core/widgets/drawer.dart';
import 'package:doctors_book/shared/models/distributions.dart';
import 'package:doctors_book/shared/models/doctors.dart';
import 'package:doctors_book/shared/models/hospitals.dart';
import 'package:doctors_book/shared/services_distributions.dart';
import 'package:doctors_book/shared/services_doctor.dart';
import 'package:doctors_book/shared/services_hospital.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DistributionControl extends StatefulWidget {
  const DistributionControl({Key? key}) : super(key: key);

  @override
  State<DistributionControl> createState() => _DistributionControlState();
}

class _DistributionControlState extends State<DistributionControl> {
  List<HospitalsModel> hospitalList = [];
  List<DoctorsModel> doctorList = [];
  var hospitalApi = ServicesHospital();
  var doctorApi = ServicesDoctor();
  var distributionApi = ServicesDistributions();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    hospitalApi.GetAll().then((value) => hospitalList = value);
    doctorApi.GetAll().then((value) => doctorList = value);
  }

  final TextEditingController _TimeFrom = TextEditingController();
  final TextEditingController _TimeTo = TextEditingController();

  final List<String> menuItems = [
    'الأحد',
    'الإتنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة'
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formUpdateKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  String? _DayAttend;
  int? _SelectedHos;
  int? _SelectedDocs;
  String? Specialize = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: PColor,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: ((context, setState) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: 450,
                              child: Form(
                                key: formKey,
                                child: ListView(
                                  children: [
                                    const Center(
                                      child: Text(
                                        'إضافة جديد',
                                        style: TextStyle(color: PColor),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 450,
                                      child: ListView(
                                        children: [
                                          const Text(
                                            'المستشفي',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.all(5),
                                              height: 40,
                                              width:
                                                  SizeConfig.screenWidth! - 20,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2<int>(
                                                  items: hospitalList.map(
                                                      (HospitalsModel item) {
                                                    return DropdownMenuItem<
                                                            int>(
                                                        value: item.id,
                                                        child:
                                                            Text(item.name!));
                                                  }).toList(),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _SelectedHos = val!;
                                                    });
                                                  },
                                                  // ignore: prefer_if_null_operators
                                                  value: _SelectedHos == null
                                                      ? hospitalList[0].id
                                                      : _SelectedHos,
                                                ),
                                              )),
                                          const Text(
                                            'الطبيب',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.all(5),
                                              height: 40,
                                              width:
                                                  SizeConfig.screenWidth! - 20,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2<int>(
                                                  items: doctorList
                                                      .map((DoctorsModel item) {
                                                    return DropdownMenuItem<
                                                            int>(
                                                        value: item.id,
                                                        child: Text(
                                                            item.doctorName!));
                                                  }).toList(),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _SelectedDocs = val!;
                                                    });
                                                  },
                                                  // ignore: prefer_if_null_operators
                                                  value: _SelectedDocs == null
                                                      ? doctorList[0].id
                                                      : _SelectedDocs,
                                                ),
                                              )),
                                          const Text(
                                            'يوم الحضور',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.all(5),
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton2<String>(
                                                  items: menuItems
                                                      .map((String item) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        value: item,
                                                        child: Text(item));
                                                  }).toList(),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _DayAttend = val!;
                                                    });
                                                  },
                                                  value: _DayAttend == null ||
                                                          _DayAttend == ""
                                                      ? "الأحد"
                                                      : _DayAttend,
                                                ),
                                              )),
                                          const Text(
                                            'من الساعة',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          inputTheme(controller: _TimeFrom),
                                          const Text(
                                            'الي الساعه',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          inputTheme(controller: _TimeTo),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              GeneralButton(
                                                customText: 'الغاء',
                                                color: Colors.redAccent,
                                                raduis: 30,
                                                onTap: () {
                                                  _TimeFrom.clear();
                                                  _TimeTo.clear();
                                                  _DayAttend = "الأحد";

                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              const Spacer(),
                                              Builder(builder: (context) {
                                                return GeneralButton(
                                                  customText: 'حفظ',
                                                  color: Colors.green,
                                                  raduis: 30,
                                                  onTap: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      distributionApi.Create(
                                                          DistributionsModel(
                                                        userId: 1,
                                                        timeFrom: int.parse(
                                                            _TimeFrom.text),
                                                        timeTo: int.parse(
                                                            _TimeTo.text),
                                                        day: _DayAttend,
                                                        hospitalsId:
                                                            _SelectedHos,
                                                        doctorsId:
                                                            _SelectedDocs,
                                                      )).then((value) {
                                                        if (value == true) {
                                                          setState(() {
                                                            _TimeFrom.clear();
                                                            _TimeTo.clear();
                                                            _DayAttend =
                                                                "الأحد";
                                                          });
                                                          print(_DayAttend);
                                                          scaffoldKey
                                                              .currentState!
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            content: const Text(
                                                              "تم الحفظ بنجاح",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                Colors.green,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                            ),
                                                          ));
                                                          Navigator.of(context)
                                                              .pop();
                                                        } else {
                                                          scaffoldKey
                                                              .currentState!
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            content: const Text(
                                                              "خطأ في ادخال البيانات ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Cairo',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                Colors
                                                                    .redAccent,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                            ),
                                                          ));
                                                        }
                                                      });
                                                    }
                                                  },
                                                );
                                              }),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    });
              },
              icon: const Icon(Icons.add_circle_outline_outlined))
        ],
        title: const Text(
          "توزيع الأطباء علي المستشفيات",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
          future: distributionApi.GetAll(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      DistributionsModel data = snapshot.data![index];
                      //  print("Fuuuuuuuuuuuck" + dataDocument['imagepath'].toString());
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        // child: DistributionDetailsBody(data['name'],data['category'],data['details'],data['phone'],data['imagepath']),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: IconButton(
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                DeleteDistribution(data.id.toString());
                              },
                            ),
                            title: Text(data.doctorsName!),
                            subtitle: Text(data.hospitalsName!),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: PColor,
                              ),
                              onPressed: () {
                                UpdateDistribution(data);
                              },
                            ),
                          ),
                        ),
                      );
                    });
          }),
    );
  }

  Future<void> _getDoctors(doctorId) async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                if (doctorId == doc["DoctorName"]) {
                  Specialize = doc["Specialize"];
                }
              })
            });
  }

  Future<void> UpdateDistribution(DistributionsModel? documentSnapshot) async {
    if (documentSnapshot != null) {
      _TimeFrom.text = documentSnapshot.timeFrom.toString();
      _TimeTo.text = documentSnapshot.timeTo.toString();
      _DayAttend = documentSnapshot.day;
      _SelectedDocs = documentSnapshot.doctorsId;
      _SelectedHos = documentSnapshot.hospitalsId;
    }
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 450,
                  child: Form(
                    key: formUpdateKey,
                    child: ListView(
                      children: [
                        const Center(
                          child: Text(
                            'تعديل البيانات',
                            style: TextStyle(color: PColor),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 450,
                          child: ListView(
                            children: [
                              const Text(
                                'المستشفي',
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
                                    child: DropdownButton2<int>(
                                      items: hospitalList
                                          .map((HospitalsModel item) {
                                        return DropdownMenuItem<int>(
                                            value: item.id,
                                            child: Text(item.name!));
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _SelectedHos = val!;
                                        });
                                      },
                                      // ignore: prefer_if_null_operators
                                      value: _SelectedHos == null
                                          ? hospitalList[0].id
                                          : _SelectedHos,
                                    ),
                                  )),
                              const Text(
                                'الطبيب',
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
                                    child: DropdownButton2<int>(
                                      items:
                                          doctorList.map((DoctorsModel item) {
                                        return DropdownMenuItem<int>(
                                            value: item.id,
                                            child: Text(item.doctorName!));
                                      }).toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          _SelectedDocs = val!;
                                        });
                                      },
                                      // ignore: prefer_if_null_operators
                                      value: _SelectedDocs == null
                                          ? doctorList[0].id
                                          : _SelectedDocs,
                                    ),
                                  )),
                              const Text(
                                'يوم الحضور',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 40,
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
                                          _DayAttend = val!;
                                        });
                                      },
                                      value:
                                          _DayAttend == null || _DayAttend == ""
                                              ? "الأحد"
                                              : _DayAttend,
                                    ),
                                  )),
                              const Text(
                                'من الساعة',
                                style: TextStyle(color: Colors.grey),
                              ),
                              inputTheme(controller: _TimeFrom),
                              const Text(
                                'الي الساعه',
                                style: TextStyle(color: Colors.grey),
                              ),
                              inputTheme(controller: _TimeTo),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  GeneralButton(
                                    customText: 'الغاء',
                                    color: Colors.redAccent,
                                    raduis: 30,
                                    onTap: () {
                                      _TimeFrom.clear();
                                      _TimeTo.clear();
                                      _DayAttend = "الأحد";

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  const Spacer(),
                                  Builder(builder: (context) {
                                    return GeneralButton(
                                      customText: 'تعديل',
                                      color: PColor,
                                      raduis: 30,
                                      onTap: () {
                                        if (formUpdateKey.currentState!
                                            .validate()) {
                                          distributionApi.Update(
                                              DistributionsModel(
                                            id: documentSnapshot!.id,
                                            timeFrom: int.parse(_TimeFrom.text),
                                            timeTo: int.parse(_TimeTo.text),
                                            day: _DayAttend,
                                            userId: 1,
                                            hospitalsId: _SelectedHos,
                                            doctorsId: _SelectedDocs,
                                          )).then((value) {
                                            if (value == true) {
                                              scaffoldKey.currentState!
                                                  .showSnackBar(SnackBar(
                                                content: const Text(
                                                  "تم التعديل بنجاح",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor: PColor,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                              ));
                                              Navigator.of(context).pop();
                                              setState(() {
                                                _TimeFrom.clear();
                                                _TimeTo.clear();
                                                _DayAttend = "الأحد";
                                              });
                                            } else {}
                                          });
                                        }
                                      },
                                    );
                                  }),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> DeleteDistribution(String Id) async {
    print("Doc ID : " + Id);
    // _dist.doc(Id).delete();

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
  }
}

class inputTheme extends StatelessWidget {
  const inputTheme({
    Key? key,
    required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: _controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "هذا الحقل ضروري";
          }
          return null;
        },
        decoration: const InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
