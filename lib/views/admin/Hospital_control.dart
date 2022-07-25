import 'package:doctors_book/core/widgets/drawer.dart';
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
  final CollectionReference _hospital =  FirebaseFirestore.instance.collection('Hospital');
  final TextEditingController _Name = TextEditingController();
  final TextEditingController _Location = TextEditingController();
  final TextEditingController _Description = TextEditingController();
  final TextEditingController _PhoneNumber = TextEditingController();
 

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formUpdateKey  = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: PColor,
        title: Text("إدارة المستشفيات"),
         actions: [
          IconButton(onPressed: (){
              showDialog(context: context, builder: (BuildContext context){
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 420,
                    child: Form(
                      key: formKey,
                      child: ListView(

                        children: [
                            const Center(
                              child:  Text('إضافة جديد',style:  TextStyle(
                              color: PColor
                        ),
                        ),
                            ),

                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 420,
                            child: ListView(

                              children: [
                               const Text('اسم المستشفي',
                              style: TextStyle(
                                color: Colors.grey
                                ),
                               ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: TextFormField(
                                    controller: _Name,
                                   validator: (value){
                                      if(value!.isEmpty){
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
                                const Text('الموقع',
                                  style:  TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: TextFormField(
                                    controller: _Location,
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "هذا الحقل ضروري";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const Text('رقم الهاتف',
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                                  Container(
                        padding: const EdgeInsets.all(5),
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)
                        ),
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
                                const Text('تفاصيل اضافية',
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                                  Container(
                        padding: const EdgeInsets.all(5),
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)
                        ),
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
                                 const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    GeneralButton(
                                      customText: 'الغاء',
                                      color: Colors.redAccent,
                                      raduis: 30,
                                      onTap: (){

                                        _Name.clear();
                                        _Location.clear();
                                        _PhoneNumber.clear();
                                        _Location.clear();
                                   

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const Spacer(),
                                    Builder(
                                      builder: (context) {
                                        return GeneralButton(
                                          customText: 'حفظ',
                                          color: Colors.green,
                                          raduis: 30,
                                          onTap: (){
                                            if(formKey.currentState!.validate()){

                                            _hospital.add({
                                              "Name" : _Name.text ,
                                              "Location" : _Location.text ,
                                              "PhoneNumber" : int.parse(_PhoneNumber.text) ,
                                              "Description" : _Description.text,
                                            
                                            
                                            });
                                            _Name.clear();
                                            _Location.clear();
                                            _PhoneNumber.clear();
                                            _Description.clear();
                                         
                                            scaffoldKey.currentState!.showSnackBar(
                                              SnackBar(content: const Text("تم الحفظ بنجاح",textAlign: TextAlign.center, style: TextStyle(
                                                fontFamily: 'Cairo',
                                                
                                                color: Colors.white,
                                              ),
                                              ),backgroundColor: Colors.green ,
                                                behavior: SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(24),
                                                ),
                                              )
                                            );
                                            Navigator.of(context).pop();
                                            }
                                          },
                                        );
                                      }
                                    ),
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
              }
            );
          }, icon: const Icon(Icons.add_circle_outline_outlined))
        ],
      ),
      drawer: const CustomDrawer(),
      body: StreamBuilder(
          stream:_hospital.snapshots(),
          builder: (context ,AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context , index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  //  print("Fuuuuuuuuuuuck" + dataDocument['imagepath'].toString());
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                   // child: hospitalDetailsBody(data['name'],data['category'],data['details'],data['phone'],data['imagepath']),
                    child : Card(
                      elevation: 5,
                      child: ListTile(
                        leading: IconButton(icon : const Icon(Icons.delete_forever,color: Colors.redAccent,),
                                 onPressed: (){
                                   Deletehospital(data.id);
                                 },

                        ),
                        title: Text(data['Name']),
                        subtitle: Text(data['Location']),
                        trailing:IconButton(icon : const Icon(Icons.edit_outlined,color: PColor,),
                          onPressed: (){
                            Updatehospital(data);
                          },

                        ),
                      ),
                    ),
                  ) ;
                }
            );
          }

      ),
    );
  }
   Future<void> Updatehospital([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null){
      _Name.text = documentSnapshot['Name'];
      _Location.text = documentSnapshot['Location'];
      _Description.text = documentSnapshot['Description'];
      _PhoneNumber.text =  documentSnapshot['PhoneNumber'].toString();
      

    }
   await showDialog(context: context, builder: (BuildContext context)
    {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 420,
          child: Form(
            key: formUpdateKey,
            child: ListView(

              children: [
                const Center(
                  child: Text('تعديل البيانات', style: TextStyle(
                      color: PColor
                  ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(10),
                  height: 420,
                  child: ListView(

                    children: [
                      const Text('الإسم',
                        style: TextStyle(
                            color: Colors.grey
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)
                        ),
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
                     
                     
                      const Text('الموقع',
                                  style:  TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: TextFormField(
                                    controller: _Location,
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "هذا الحقل ضروري";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const Text('رقم الهاتف',
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                                  Container(
                        padding: const EdgeInsets.all(5),
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)
                        ),
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
                                const Text('تفاصيل اضافية',
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                                  Container(
                        padding: const EdgeInsets.all(5),
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)
                        ),
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
                  const SizedBox(height: 10,),
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
                          Builder(
                              builder: (context) {
                                return GeneralButton(
                                  customText: 'تعديل',
                                  color: PColor,
                                  raduis: 30,
                                  onTap: () {
                                    if (formUpdateKey.currentState!.validate()) {
                                      _hospital.doc(documentSnapshot!.id).update({
                                        "Name": _Name.text,
                                        "Location": _Location.text,
                                        "Description": _Description.text,
                                        "PhoneNumber":  int.parse(_PhoneNumber.text),
                                      
                                      });

                                      _Name.clear();
                                      _Location.clear();
                                      _Description.clear();
                                      _PhoneNumber.clear();
                                  

                                      scaffoldKey.currentState!.showSnackBar(
                                          SnackBar(content: const Text(
                                            "تم التعديل بنجاح",textAlign: TextAlign.center, style: TextStyle(
                                            fontFamily: 'Cairo',
                                            color: Colors.white,
                                          ),)
                                            , backgroundColor: PColor,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(24),
                                            ),
                                          )
                                      );
                                      Navigator.of(context).pop();
                                    }
                                  },
                                );
                              }
                          ),
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
    }
    );

  }

  Future<void> Deletehospital(String Id) async {

    _hospital.doc(Id).delete();

    scaffoldKey.currentState!.showSnackBar(
        SnackBar(content: const Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "تم حذف العنصر",textAlign: TextAlign.center, style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
          ),),
        )
          , backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius
                .circular(24),
          ),
        )
    );

        }
}
