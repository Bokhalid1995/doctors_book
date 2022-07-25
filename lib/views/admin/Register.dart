
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';



class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formUpdateKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  bool? isOnStart = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.amber.shade500,
                image: const DecorationImage(
                    image: AssetImage("assets/images/insurance/pic (1).png"),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 170,
                      height: 170,
                      child: Lottie.asset('assets/images/img_2.json'),
                    ),
                    const Center(
                      child: Text(
                        'انشاء حساب جديد',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            letterSpacing: 0.0),
                      ),
                    ),
                    Visibility(
                        visible: isOnStart!,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(20),
                          height: 470,
                          decoration: BoxDecoration(
                            color: Colors.black38.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 420,
                                  child: ListView(
                                    children: [
                                      Text(
                                        'الإسم',
                                        style: TextStyle(
                                            color: Colors.grey.shade200),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade200),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextFormField(
                                          controller: _name,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "هذا الحقل ضروري";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.person_pin,
                                              color: Colors.grey.shade300,
                                            ),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'رقم الهاتف',
                                        style: TextStyle(
                                            color: Colors.grey.shade200),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade200),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextFormField(
                                          controller: _phone,
                                          decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.phone_iphone_rounded,
                                              color: Colors.grey.shade300,
                                            ),
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
                                      Text(
                                        'كلمة المرور',
                                        style: TextStyle(
                                            color: Colors.grey.shade200),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade200),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextFormField(
                                          controller: _password,
                                          decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: Colors.grey.shade300,
                                            ),
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
                                        height: 20,
                                      ),
                                      Builder(builder: (context) {
                                        return GeneralButton(
                                          customText: 'حفظ',
                                          color: Colors.amber.shade500,
                                          raduis: 30,
                                          onTap: () {
                                            // if (formKey.currentState!
                                            //     .validate()) {
                                            //   ServicesConnection.register()
                                            //       .then((value) {
                                            //     _name.clear();

                                            //     _phone.clear();
                                            //     _password.clear();

                                            //     scaffoldKey.currentState!
                                            //         .showSnackBar(SnackBar(
                                            //       content: Text(
                                            //         "تم الحفظ بنجاح",
                                            //         style: TextStyle(
                                            //           fontFamily: 'Cairo',
                                            //           color: Colors.white,
                                            //         ),
                                            //       ),
                                            //       backgroundColor: Colors.green,
                                            //       behavior:
                                            //           SnackBarBehavior.floating,
                                            //       shape: RoundedRectangleBorder(
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 24),
                                            //       ),
                                            //     ));
                                            //   });
                                            // }
                                          },
                                        );
                                      }),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GeneralButton(
                                        customText: 'لديك حساب مسبقا؟',
                                        color: Colors.grey,
                                        raduis: 30,
                                        onTap: () {
                                          _name.clear();
                                          _phone.clear();
                                          _password.clear();

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    IconButton(
                      color: Colors.black12,
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
