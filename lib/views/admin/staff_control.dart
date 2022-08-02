// ignore_for_file: deprecated_member_use, non_constant_identifier_DoctorNames

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';

import 'package:doctors_book/core/widgets/custom_button.dart';
import 'package:doctors_book/core/widgets/drawer.dart';
import 'package:flutter/material.dart';

class StaffControl extends StatefulWidget {
  const StaffControl({Key? key}) : super(key: key);

  @override
  State<StaffControl> createState() => _StaffControlState();
}

class _StaffControlState extends State<StaffControl> {
  final CollectionReference _staff =
      FirebaseFirestore.instance.collection('doctors');
  final TextEditingController _DoctorName = TextEditingController();
  final TextEditingController _Specialize = TextEditingController();
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
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextFormField(
                                          controller: _Specialize,
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
                                              _Specialize.clear();
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
                                                  _staff.add({
                                                    "DoctorName":
                                                        _DoctorName.text,
                                                    "Specialize":
                                                        _Specialize.text,
                                                    "QualifiedCert":
                                                        _QualifiedCert.text,
                                                  });
                                                  _DoctorName.clear();
                                                  _Specialize.clear();
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
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
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
      drawer: const CustomDrawer(),
      body: StreamBuilder(
          stream: _staff.snapshots(),
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
                                DeleteStaff(data.id);
                              },
                            ),
                            title: Text(data['DoctorName']),
                            subtitle: Text(data['Specialize']),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: PColor,
                              ),
                              onPressed: () {
                                UpdateStaff(data);
                              },
                            ),
                          ),
                        ),
                      );
                    });
          }),
    );
  }

  Future<void> UpdateStaff([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _DoctorName.text = documentSnapshot['DoctorName'];
      _Specialize.text = documentSnapshot['Specialize'];
      _QualifiedCert.text = documentSnapshot['QualifiedCert'];
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
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _Specialize,
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
                                  _Specialize.clear();
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
                                      _staff.doc(documentSnapshot!.id).update({
                                        "DoctorName": _DoctorName.text,
                                        "Specialize": _Specialize.text,
                                        "QualifiedCert": _QualifiedCert.text,
                                      });

                                      _DoctorName.clear();
                                      _Specialize.clear();
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
        });
  }

  Future<void> DeleteStaff(String Id) async {
    _staff.doc(Id).delete();

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
