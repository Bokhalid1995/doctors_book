// ignore_for_file: deprecated_member_use, non_constant_identifier_DoctorNames

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';

import 'package:doctors_book/core/widgets/custom_button.dart';
import 'package:doctors_book/core/widgets/drawer.dart';
import 'package:doctors_book/shared/models/doctors.dart';
import 'package:doctors_book/shared/models/specialize.dart';
import 'package:doctors_book/shared/services_doctor.dart';
import 'package:doctors_book/shared/services_specialize.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class StaffControl extends StatefulWidget {
  const StaffControl({Key? key}) : super(key: key);

  @override
  State<StaffControl> createState() => _StaffControlState();
}

class _StaffControlState extends State<StaffControl> {
  List<SpecializesModel> menuItems = [];
  var speclizerApi = ServicesSpecializes();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speclizerApi.GetAll().then((value) => menuItems = value);
  }

  var doctorApi = ServicesDoctor();
  final TextEditingController _DoctorName = TextEditingController();
  int? _Specialize;
  final TextEditingController _QualifiedCert = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formUpdateKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

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
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          height: 350,
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
                                  height: 350,
                                  child: ListView(
                                    children: [
                                      const Text(
                                        'الإسم',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextFormField(
                                          controller: _DoctorName,
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
                                      ),
                                      const Text(
                                        'التخصص',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.all(5),
                                          height: 40,
                                          width: SizeConfig.screenWidth! - 20,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2<int>(
                                              items: menuItems
                                                  .map((SpecializesModel item) {
                                                return DropdownMenuItem<int>(
                                                    value: item.id,
                                                    child: Text(item.name!));
                                              }).toList(),
                                              onChanged: (val) {
                                                setState(() {
                                                  _Specialize = val!;
                                                });
                                              },
                                              value: _Specialize == null
                                                  ? menuItems[0].id
                                                  : _Specialize,
                                            ),
                                          )),
                                      const Text(
                                        'المؤهل العلمي',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextFormField(
                                          controller: _QualifiedCert,
                                          decoration: const InputDecoration(
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "هذا الحقل ضروري";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
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
                                              _DoctorName.clear();
                                              _Specialize = menuItems[0].id;
                                              _QualifiedCert.clear();

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
                                                  doctorApi.Create(DoctorsModel(
                                                    doctorName:
                                                        _DoctorName.text,
                                                    specializeId: _Specialize,
                                                    qualifiedCert:
                                                        _QualifiedCert.text,
                                                  ));
                                                  _DoctorName.clear();
                                                  _Specialize = menuItems[0].id;
                                                  _QualifiedCert.clear();

                                                  scaffoldKey.currentState!
                                                      .showSnackBar(SnackBar(
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
                                                        SnackBarBehavior.fixed,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                    ),
                                                  ));
                                                  Navigator.of(context).pop();
                                                  setState(() {});
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
                    });
              },
              icon: const Icon(Icons.add_circle_outline_outlined))
        ],
        title: const Text(
          "إدارة الأطباء",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      drawer: CustomDrawer(popOut: () {
        Navigator.of(context).pop();
      }),
      body: FutureBuilder(
          future: doctorApi.GetAll(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      //  DocumentSnapshot data = snapshot.data![index];
                      //  print("Fuuuuuuuuuuuck" + dataDocument['imagepath'].toString());
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        // child: StaffDetailsBody(data['name'],data['category'],data['details'],data['phone'],data['imagepath']),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: IconButton(
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                DeleteStaff(snapshot.data![index].id);
                              },
                            ),
                            title: Text(snapshot.data![index].doctorName),
                            subtitle:
                                Text(snapshot.data![index].specializeName),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: PColor,
                              ),
                              onPressed: () {
                                UpdateStaff(snapshot.data![index]);
                              },
                            ),
                          ),
                        ),
                      );
                    });
          }),
    );
  }

  Future<void> UpdateStaff(DoctorsModel? documentSnapshot) async {
    if (documentSnapshot != null) {
      _DoctorName.text = documentSnapshot.doctorName!;
      _Specialize = documentSnapshot.specializeId!;
      _QualifiedCert.text = documentSnapshot.qualifiedCert!;
    }
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 350,
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
                      height: 350,
                      child: ListView(
                        children: [
                          const Text(
                            'الإسم',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _DoctorName,
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
                          ),
                          const Text(
                            'التخصص',
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
                                  items: menuItems.map((SpecializesModel item) {
                                    return DropdownMenuItem<int>(
                                        value: item.id,
                                        child: Text(item.name!));
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _Specialize = val!;
                                    });
                                  },
                                  value: _Specialize == null
                                      ? menuItems[0].id
                                      : _Specialize,
                                ),
                              )),
                          const Text(
                            'المؤهل العلمي',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _QualifiedCert,
                              decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "هذا الحقل ضروري";
                                }
                                return null;
                              },
                            ),
                          ),
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
                                  _DoctorName.clear();
                                  _Specialize = menuItems[0].id;
                                  _QualifiedCert.clear();

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
                                      doctorApi.Update(DoctorsModel(
                                        id: documentSnapshot!.id,
                                        doctorName: _DoctorName.text,
                                        specializeId: _Specialize,
                                        qualifiedCert: _QualifiedCert.text,
                                      ));

                                      _DoctorName.clear();
                                      _Specialize = menuItems[0].id;
                                      _QualifiedCert.clear();

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
                                        behavior: SnackBarBehavior.fixed,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      ));
                                      Navigator.of(context).pop();
                                      setState(() {});
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
        });
  }

  Future<void> DeleteStaff(int Id) async {
    // _staff.doc(Id).delete();
    doctorApi.Delete(Id).then((value) {
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
          behavior: SnackBarBehavior.fixed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
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
          backgroundColor: Colors.amber.shade300,
          behavior: SnackBarBehavior.fixed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ));
      }
    });
  }
}
