import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/custom_button.dart';
import 'package:doctors_book/core/widgets/staff_details_body.dart';
import 'package:doctors_book/views/admin/admin_dashboard.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart' as intl;

class Login extends StatefulWidget {
  const Login();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final CollectionReference _Login =
      FirebaseFirestore.instance.collection('LoginDetails');
  final TextEditingController _UserName = TextEditingController();
  final TextEditingController _LoginDate = TextEditingController();
  final TextEditingController _Password = TextEditingController();
  final box = GetStorage();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool Auth = false;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PColor.withOpacity(0.30),
        body: Container(
          height: SizeConfig.screenheight,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text(
                      "تسجيل الدخول ",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: PColor, fontSize: 20),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: SizeConfig.screenWidth! - 20,
                      height: 50,
                      decoration: BoxDecoration(
                        color: PColor.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "ادخل اسم المستخدم وكلمة المرور ",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
                                color: Colors.grey.shade500,
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
                            padding: const EdgeInsets.all(8),
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.grey.shade500,
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
                          const SizedBox(
                            height: 10,
                          ),
                          Builder(builder: (context) {
                            return GeneralButton(
                              customText: 'تسجيل الدخول',
                              color: Colors.green,
                              raduis: 30,
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .get()
                                    .then((QuerySnapshot querySnapshot) => {
                                          querySnapshot.docs.forEach((doc) {
                                            if (_UserName.text ==
                                                    doc["UserName"] &&
                                                _Password.text ==
                                                    doc["Password"]) {
                                              Auth = true;

                                              box.write(
                                                  'UserName', doc["UserName"]);
                                              box.write('HospitalName',
                                                  doc["HospitalName"]);

                                              _UserName.clear();
                                              _Password.clear();
                                            }
                                          }),
                                          if (Auth == true)
                                            {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const AdminDashboard()))
                                            }
                                          else
                                            {
                                              scaffoldKey.currentState!
                                                  .showSnackBar(SnackBar(
                                                content: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: const [
                                                    Text(
                                                      "تأكد من بيانات الدخول ",
                                                      textAlign:
                                                          TextAlign.center,
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
                                                backgroundColor:
                                                    Colors.redAccent,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                              ))

                                              // Navigator.of(context).pop();
                                            }
                                        });
                              },
                            );
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    intl.DateFormat formatter =
        intl.DateFormat('dd/MM/yyyy'); //specifies day/month/year format

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != DateTime.now())
      setState(() {
        // selectedDate = picked;
        _LoginDate.value = TextEditingValue(
            text: formatter.format(
                picked)); //Use formatter to format selected date and assign to text field
      });
  }
}
