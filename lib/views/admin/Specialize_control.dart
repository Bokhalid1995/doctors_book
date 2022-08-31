import 'package:doctors_book/core/widgets/drawer.dart';
import 'package:doctors_book/shared/models/specialize.dart';
import 'package:doctors_book/shared/services_specialize.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';

import 'package:doctors_book/core/widgets/custom_button.dart';

class SpecializeControl extends StatefulWidget {
  const SpecializeControl({Key? key}) : super(key: key);

  @override
  State<SpecializeControl> createState() => _SpecializeControlState();
}

class _SpecializeControlState extends State<SpecializeControl> {
  final CollectionReference _Specialize =
      FirebaseFirestore.instance.collection('Specialize');
  final TextEditingController _Name = TextEditingController();

  final TextEditingController _Description = TextEditingController();

  var SpecializeApi = new ServicesSpecializes();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formUpdateKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: PColor,
        title: Text("إدارة التخصصات"),
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
                                        'اسم التخصص',
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
                                              _Description.clear();

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
                                                  SpecializeApi.Create(
                                                      SpecializesModel(
                                                    id: 0,
                                                    name: _Name.text,
                                                    description:
                                                        _Description.text,
                                                  )).then((value) {
                                                    if (value == true) {
                                                      _Name.clear();
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
          future: SpecializeApi.GetAll(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
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
                        // child: SpecializeDetailsBody(data['name'],data['category'],data['details'],data['phone'],data['imagepath']),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: IconButton(
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                DeleteSpecialize(snapshot.data![index].id);
                              },
                            ),
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(snapshot.data![index].description),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: PColor,
                              ),
                              onPressed: () {
                                UpdateSpecialize(snapshot.data![index]);
                              },
                            ),
                          ),
                        ),
                      );
                    });
          }),
    );
  }

  Future<void> UpdateSpecialize(SpecializesModel? documentSnapshot) async {
    if (documentSnapshot != null) {
      _Name.text = documentSnapshot.name!;

      _Description.text = documentSnapshot.description!;
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
                                      SpecializeApi.Update(SpecializesModel(
                                        id: documentSnapshot!.id,
                                        name: _Name.text,
                                        description: _Description.text,
                                      )).then((value) {
                                        if (value == true) {
                                          _Name.clear();
                                          _Description.clear();

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
  }

  Future<void> DeleteSpecialize(int Id) async {
    SpecializeApi.Delete(Id).then((value) {
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
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ));
      }
    });
  }
}
