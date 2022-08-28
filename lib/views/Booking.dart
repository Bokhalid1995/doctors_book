import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/custom_button.dart';
import 'package:doctors_book/core/widgets/staff_details_body.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart' as intl;

class Booking extends StatefulWidget {
  const Booking(this._hosName, this.DoctorName, this.Day, this.From, this.To);
  final String _hosName;

  final String DoctorName;
  final String Day;
  final int From;
  final int To;

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  int length = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBooking(widget._hosName, widget.DoctorName);
  }

  final CollectionReference _booking =
      FirebaseFirestore.instance.collection('BookingDetails');
  final TextEditingController _PatientName = TextEditingController();
  final TextEditingController _BookingDate = TextEditingController();
  final TextEditingController _Age = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(widget._hosName);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: PColor,
          title: Text(
            'اجراء الحجز  - ' + widget._hosName,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        body: Container(
          height: SizeConfig.screenheight,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: SizeConfig.screenWidth! - 20,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.20),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "تأكد من البيانات جيدا قبل اجراء الحجز",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: PColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.house_siding_sharp,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        const Text('المستشفي: '),
                        const SizedBox(width: 10),
                        Text(widget._hosName),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        const Text('الطبيب: '),
                        const SizedBox(width: 10),
                        Text(widget.DoctorName),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 390,
                      child: ListView(
                        children: [
                          const Text(
                            'اسم المريض',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _PatientName,
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
                            'العمر',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: _Age,
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
                            'تاريخ الحجز',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              onTap: (() => _selectDate(context)),
                              controller: _BookingDate,
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
                              customText: 'حجز',
                              color: Colors.green,
                              raduis: 30,
                              onTap: () {
                                if (length <= 10) {
                                  if (formKey.currentState!.validate()) {
                                    _booking.add({
                                      "PatientName": _PatientName.text,
                                      "Age": _Age.text,
                                      "BookingDate": _BookingDate.text,
                                      "DoctorName": widget.DoctorName,
                                      "HospitalName": widget._hosName,
                                      "TimeFrom": widget.From,
                                      "TimeTo": widget.To,
                                      "Status": "Waiting",
                                    });

                                    setState(() {
                                      _PatientName.clear();
                                      _Age.clear();
                                    });

                                    scaffoldKey.currentState!
                                        .showSnackBar(SnackBar(
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "تم  تاكيد الحجز بنجاح",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ));
                                  }
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
                                          " الحجوزات مغلقه لهذا الطبيب الرجاء  المحاوله لاحقا ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            color: Colors.white,
                                          ),
                                        ),
                                        Icon(
                                          Icons.work_off,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    backgroundColor: Colors.redAccent,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ));

                                  // Navigator.of(context).pop();
                                }
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
        _BookingDate.value = TextEditingValue(
            text: formatter.format(
                picked)); //Use formatter to format selected date and assign to text field
      });
  }

  Future<void> _getBooking(hospital, DoctorName) async {
    await FirebaseFirestore.instance
        .collection('Distriputions')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                if (hospital == doc["HospitalName"] &&
                    DoctorName == doc["DoctorName"]) {
                  ++length;
                }
              })
            });
  }
}
