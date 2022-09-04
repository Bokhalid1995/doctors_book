import 'package:doctors_book/core/widgets/drawer.dart';
import 'package:doctors_book/shared/models/hospitals.dart';
import 'package:doctors_book/shared/services_hospital.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';

import 'package:doctors_book/core/widgets/custom_button.dart';

class HospitalControl extends StatefulWidget {
  const HospitalControl({Key? key}) : super(key: key);

  @override
  State<HospitalControl> createState() => _HospitalControlState();
}

class _HospitalControlState extends State<HospitalControl> {
  final TextEditingController _Name = TextEditingController();
  final TextEditingController _Location = TextEditingController();
  final TextEditingController _Description = TextEditingController();
  final TextEditingController _PhoneNumber = TextEditingController();

  var hospitalApi = ServicesHospital();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formUpdateKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: PColor,
        title: Text("إدارة المستشفيات"),
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
                          height: 420,
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
                                  height: 420,
                                  child: ListView(
                                    children: [
                                      const Text(
                                        'اسم المستشفي',
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
                                          controller: _Name,
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
                                        'الموقع',
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
                                          controller: _Location,
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
                                        'رقم الهاتف',
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
                                          controller: _PhoneNumber,
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
                                        'تفاصيل اضافية',
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
                                          controller: _Description,
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
                                              _Name.clear();
                                              _Location.clear();
                                              _PhoneNumber.clear();
                                              _Location.clear();

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
                                                  hospitalApi.Create(
                                                          HospitalsModel(
                                                              id: 0,
                                                              name: _Name.text,
                                                              location:
                                                                  _Location
                                                                      .text,
                                                              description:
                                                                  _Description
                                                                      .text,
                                                              phone:
                                                                  _PhoneNumber
                                                                      .text))
                                                      .then((value) {
                                                    if (value == true) {
                                                      _Name.clear();
                                                      _Location.clear();
                                                      _PhoneNumber.clear();
                                                      _Description.clear();

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
                                                                .fixed,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0),
                                                        ),
                                                      ));
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {});
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
                    });
              },
              icon: const Icon(Icons.add_circle_outline_outlined))
        ],
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
          future: hospitalApi.GetAll(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      //DocumentSnapshot data = snapshot.data![index].name;
                      //  print("Fuuuuuuuuuuuck" + dataDocument['imagepath'].toString());
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
                                Deletehospital(snapshot.data![index].id);
                              },
                            ),
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(snapshot.data![index].location),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: PColor,
                              ),
                              onPressed: () {
                                Updatehospital(snapshot.data![index]);
                              },
                            ),
                          ),
                        ),
                      );
                    });
          }),
    );
  }

  Future<void> Updatehospital(HospitalsModel? documentSnapshot) async {
    if (documentSnapshot != null) {
      _Name.text = documentSnapshot.name!;
      _Location.text = documentSnapshot.location!;
      _Description.text = documentSnapshot.description!;
      _PhoneNumber.text = documentSnapshot.phone!;
    }
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 420,
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
                      height: 420,
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
                              controller: _Name,
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
                            'الموقع',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _Location,
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
                            'رقم الهاتف',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _PhoneNumber,
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
                            'تفاصيل اضافية',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _Description,
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
                                  _Name.clear();
                                  _Location.clear();
                                  _Description.clear();

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
                                      hospitalApi.Update(HospitalsModel(
                                              id: documentSnapshot!.id,
                                              name: _Name.text,
                                              location: _Location.text,
                                              description: _Description.text,
                                              phone: _PhoneNumber.text))
                                          .then((value) {
                                        if (value == true) {
                                          _Name.clear();
                                          _Location.clear();
                                          _Description.clear();
                                          _PhoneNumber.clear();

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
                                        } else {
                                          scaffoldKey.currentState!
                                              .showSnackBar(SnackBar(
                                            content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  "تأكد من بيانات المدخله ",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.dangerous,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                            backgroundColor: Colors.redAccent,
                                            behavior: SnackBarBehavior.fixed,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
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
        });
  }

  Future<void> Deletehospital(int Id) async {
    hospitalApi.Delete(Id).then((value) {
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
