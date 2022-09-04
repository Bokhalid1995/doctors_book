// ignore_for_file: deprecated_member_use, non_constant_identifier_UserNames

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';

import 'package:doctors_book/core/widgets/custom_button.dart';
import 'package:doctors_book/core/widgets/drawer.dart';
import 'package:doctors_book/shared/models/user.dart';
import 'package:doctors_book/shared/services_connection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/models/doctors.dart';
import '../../shared/models/hospitals.dart';
import '../../shared/services_hospital.dart';

class RegisterControl extends StatefulWidget {
  const RegisterControl({Key? key}) : super(key: key);

  @override
  State<RegisterControl> createState() => _RegisterControlState();
}

class _RegisterControlState extends State<RegisterControl> {
  List<HospitalsModel> hospitalList = [];
  var hospitalApi = ServicesHospital();
  var userApi = ServicesConnection();
  // final CollectionReference _register =
  //     FirebaseFirestore.instance.collection('Users');
  // final CollectionReference _hospital =
  //     FirebaseFirestore.instance.collection('Hospital');
  final TextEditingController _UserName = TextEditingController();
  final TextEditingController _Password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hospitalApi.GetAll().then((value) => hospitalList = value);
  }

  final List<String> menuItems = ['Supervisor', 'Admin', 'Recieption'];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formUpdateKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  String? _UserType;
  int? _SelectedHos;

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
                              height: 390,
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
                                      height: 390,
                                      child: ListView(
                                        children: [
                                          const Text(
                                            'اسم المستخدم',
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
                                                    BorderRadius.circular(10)),
                                            child: TextFormField(
                                              controller: _UserName,
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
                                            'كلمة المرور',
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
                                                    BorderRadius.circular(10)),
                                            child: TextFormField(
                                              controller: _Password,
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
                                            'صلاحية المستخدم',
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
                                                      _UserType = val!;
                                                    });
                                                  },
                                                  value: _UserType == null ||
                                                          _UserType == ""
                                                      ? "Admin"
                                                      : _UserType,
                                                ),
                                              )),
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
                                          Row(
                                            children: [
                                              GeneralButton(
                                                customText: 'الغاء',
                                                color: Colors.redAccent,
                                                raduis: 30,
                                                onTap: () {
                                                  _UserName.clear();
                                                  _Password.clear();
                                                  _UserType = "Admin";

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
                                                      userApi
                                                          .register(User(
                                                        userName:
                                                            _UserName.text,
                                                        password:
                                                            _Password.text,
                                                        userType: _UserType,
                                                        hospitalsId:
                                                            _SelectedHos,
                                                      ))
                                                          .then((value) {
                                                        setState(() {
                                                          _UserName.clear();
                                                          _Password.clear();
                                                          _UserType = "Admin";
                                                        });
                                                        print(_UserType);
                                                        scaffoldKey
                                                            .currentState!
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: const Text(
                                                            "تم الحفظ بنجاح",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Cairo',
                                                              color:
                                                                  Colors.white,
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
                                                                    .circular(
                                                                        0),
                                                          ),
                                                        ));
                                                        Navigator.of(context)
                                                            .pop();
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
          "إدارة المستخدمين",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: FutureBuilder(
          future: userApi.GetAll(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      User data = snapshot.data![index];
                      //  print("Fuuuuuuuuuuuck" + dataDocument['imagepath'].toString());
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        // child: RegisterDetailsBody(data['name'],data['category'],data['details'],data['phone'],data['imagepath']),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: IconButton(
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                DeleteRegister(data.id!);
                              },
                            ),
                            title: Text(data.userName!),
                            subtitle: Text(data.userType!),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: PColor,
                              ),
                              onPressed: () {
                                UpdateRegister(data);
                              },
                            ),
                          ),
                        ),
                      );
                    });
          }),
    );
  }

  Future<void> UpdateRegister(User? documentSnapshot) async {
    if (documentSnapshot != null) {
      _UserName.text = documentSnapshot.userName!;
      _Password.text = documentSnapshot.password!;
      _UserType = documentSnapshot.userType;
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
                  height: 390,
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
                          height: 390,
                          child: ListView(
                            children: [
                              const Text(
                                'اسم المستخدم',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  controller: _UserName,
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
                                'كلمة المرور',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  controller: _Password,
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
                                'صلاحية المستخدم',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<String>(
                                    value: _UserType == null || _UserType == ""
                                        ? "Admin"
                                        : _UserType,
                                    items: menuItems.map((String item) {
                                      return DropdownMenuItem<String>(
                                          value: item, child: Text(item));
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _UserType = val!;
                                      });
                                    },
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
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
                                      _UserName.clear();
                                      _Password.clear();
                                      _UserType = "Admin";

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
                                          userApi.Update(User(
                                            id: documentSnapshot!.id,
                                            userName: _UserName.text,
                                            password: _Password.text,
                                            userType: _UserType,
                                            hospitalsId: _SelectedHos,
                                          )).then((value) {
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
                                            setState(() {
                                              _UserName.clear();
                                              _Password.clear();
                                              _UserType = "Admin";
                                            });
                                            Navigator.of(context).pop();
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

  Future<void> DeleteRegister(int Id) async {
    // _register.doc(Id).delete();

    userApi.Delete(Id).then((value) {
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
