// ignore_for_file: deprecated_member_use, non_constant_identifier_TimeFroms

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';

import 'package:doctors_book/core/widgets/custom_button.dart';
import 'package:doctors_book/core/widgets/drawer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DistributionControl extends StatefulWidget {
  const DistributionControl({Key? key}) : super(key: key);

  @override
  State<DistributionControl> createState() => _DistributionControlState();
}

class _DistributionControlState extends State<DistributionControl> {
  final CollectionReference _dist =
      FirebaseFirestore.instance.collection('Distriputions');
  final CollectionReference _hospital =
      FirebaseFirestore.instance.collection('Hospital');
  final CollectionReference _doctor =
      FirebaseFirestore.instance.collection('doctors');
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
  String? _SelectedHos;
  String? _SelectedDocs;

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
                                          BuildDropDown(
                                              setState,
                                              _hospital.snapshots(),
                                              "hospital"),
                                          const Text(
                                            'الطبيب',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          BuildDropDown(setState,
                                              _doctor.snapshots(), "doctor"),
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
                                                      _dist.add({
                                                        "TimeFrom":
                                                            _TimeFrom.text,
                                                        "TimeTo": _TimeTo.text,
                                                        "Day": _DayAttend,
                                                        "HospitalName":
                                                            _SelectedHos,
                                                        "DoctorName":
                                                            _SelectedDocs,
                                                        "Status": "Active",
                                                      });

                                                      setState(() {
                                                        _TimeFrom.clear();
                                                        _TimeTo.clear();
                                                        _DayAttend = "الأحد";
                                                      });
                                                      print(_DayAttend);
                                                      scaffoldKey.currentState!
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: const Text(
                                                          "تم الحفظ بنجاح",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: 'Cairo',
                                                            color: Colors.white,
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
                                                                  .circular(24),
                                                        ),
                                                      ));
                                                      Navigator.of(context)
                                                          .pop();
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
      body: StreamBuilder(
          stream: _dist.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data!.docs[index];
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
                                DeleteDistribution(data.id);
                              },
                            ),
                            title: Text(data['DoctorName']),
                            subtitle: Text(data['HospitalName']),
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

  StreamBuilder<QuerySnapshot<Object?>> BuildDropDown(
      StateSetter setState, Stream<QuerySnapshot<Object?>> _ref, String Type) {
    return StreamBuilder<QuerySnapshot>(
        stream: _ref,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          var length = snapshot.data!.docs.length;
          //DocumentSnapshot ds = snapshot.data!.docs[length - 1];
          var hospitalname = snapshot.data!.docs;
          return Container(
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  items: hospitalname.map((DocumentSnapshot document) {
                    var name = Type == "doctor"
                        ? document['DoctorName']
                        : document['Name'];
                    return DropdownMenuItem<String>(
                        value: name, child: Text(name));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      if (Type == "doctor") {
                        _SelectedDocs = val!;
                      } else {
                        _SelectedHos = val!;
                      }
                    });
                  },
                  value: Type != "doctor"
                      ? _SelectedHos ?? "المتكامل"
                      : _SelectedDocs ?? "الطيب ابايزيد",

                  // buttonDecoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(14),
                  //   border: Border.all(
                  //     color: Colors.black26,
                  //   ),
                  //   color: Colors.redAccent,
                  // ),
                ),
              ));
        });
  }

  Future<void> UpdateDistribution([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _TimeFrom.text = documentSnapshot['TimeFrom'];
      _TimeTo.text = documentSnapshot['TimeTo'];
      _DayAttend = documentSnapshot['Day'];
      _SelectedDocs = documentSnapshot['DoctorName'];
      _SelectedHos = documentSnapshot['HospitalName'];
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
                              BuildDropDown(
                                  setState, _hospital.snapshots(), "hospital"),
                              const Text(
                                'الطبيب',
                                style: TextStyle(color: Colors.grey),
                              ),
                              BuildDropDown(
                                  setState, _doctor.snapshots(), "doctor"),
                              const SizedBox(
                                height: 10,
                              ),
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
                                          _dist
                                              .doc(documentSnapshot!.id)
                                              .update({
                                            "TimeFrom": _TimeFrom.text,
                                            "TimeTo": _TimeTo.text,
                                            "Day": _DayAttend,
                                            "HospitalName": _SelectedHos,
                                            "DoctorName": _SelectedDocs,
                                          });

                                          setState(() {
                                            _TimeFrom.clear();
                                            _TimeTo.clear();
                                            _DayAttend = "الأحد";
                                          });

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
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                          ));
                                          Navigator.of(context).pop();
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
    _dist.doc(Id).delete();

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
