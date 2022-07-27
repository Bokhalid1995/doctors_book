// ignore_for_file: deprecated_member_use, non_constant_identifier_UserNames

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/core/constants.dart';

import 'package:doctors_book/core/widgets/custom_button.dart';
import 'package:doctors_book/core/widgets/drawer.dart';
import 'package:flutter/material.dart';

 
class RegisterControl extends StatefulWidget {
  const RegisterControl({Key? key}) : super(key: key);

  @override
  State<RegisterControl> createState() => _RegisterControlState();
}

class _RegisterControlState extends State<RegisterControl> {
  final CollectionReference _register =  FirebaseFirestore.instance.collection('Users');
  final CollectionReference _hospital =  FirebaseFirestore.instance.collection('Hospital');
  final TextEditingController _UserName = TextEditingController();
  final TextEditingController _Password = TextEditingController();
   
 
  final List<String> menuItems = ['Supervisor', 'Admin', 'Recieption'];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formUpdateKey  = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
   String? _UserType ;

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
           backgroundColor: PColor,
        actions: [
          IconButton(onPressed: (){
              showDialog(context: context, builder: (BuildContext context){
                return StatefulBuilder(

               builder: ((context, setState) {
                   return  Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 350,
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
                              height: 350,
                              child: ListView(
                
                                children: [
                                 const Text('اسم المستخدم',
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
                                      controller: _UserName,
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
                                  const Text('كلمة المرور',
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
                                      controller: _Password,
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
                                  const Text('صلاحية المستخدم',
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
                          child:  DropdownButton<String>(
                            
                            items: menuItems.map((String item){
                                 return DropdownMenuItem<String>(value:item, child: Text(item));
                            }).toList(),
                            onChanged: (val){
                              setState(() {
                                  _UserType = val!;
                              });
                            },
                               value: _UserType == null || _UserType == "" ? "Admin" : _UserType ,
                          )
                        ),
                                   const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      GeneralButton(
                                        customText: 'الغاء',
                                        color: Colors.redAccent,
                                        raduis: 30,
                                        onTap: (){
                
                                          _UserName.clear();
                                              _Password.clear();
                                              _UserType ="Admin";   
                                     
                
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
                
                                              _register.add({
                                                "UserName" : _UserName.text ,
                                                "Password" : _Password.text ,
                                                "UserType" : _UserType,
                                              
                                              
                                              });
                
                                              setState(() {
                                              _UserName.clear();
                                              _Password.clear();
                                              _UserType ="Admin";    
                                              });
                                                   print(_UserType)    ;                          
                                              scaffoldKey.currentState!.showSnackBar(
                                                SnackBar(content: const Text("تم الحفظ بنجاح",textAlign: TextAlign.center,style: TextStyle(
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
               }),
                );
              }
            );
          }, icon: const Icon(Icons.add_circle_outline_outlined))
        ],
        title: const Text("إدارة الأطباء" ,
        style: TextStyle(
          fontSize: 15,
        ),),
      ),
      drawer: const CustomDrawer(),
      body: StreamBuilder(
          stream:_register.snapshots(),
          builder: (context ,AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context , index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  //  print("Fuuuuuuuuuuuck" + dataDocument['imagepath'].toString());
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                   // child: RegisterDetailsBody(data['name'],data['category'],data['details'],data['phone'],data['imagepath']),
                    child : Card(
                      elevation: 5,
                      child: ListTile(
                        leading: IconButton(icon : const Icon(Icons.delete_forever,color: Colors.redAccent,),
                                 onPressed: (){
                                   DeleteRegister(data.id);
                                 },

                        ),
                        title: Text(data['UserName']),
                        subtitle: Text(data['Password']),
                        trailing:IconButton(icon : const Icon(Icons.edit_outlined,color: PColor,),
                          onPressed: (){
                            UpdateRegister(data);
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
  Future<void> UpdateRegister([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null){
      _UserName.text = documentSnapshot['UserName'];
      _Password.text = documentSnapshot['Password'];
      _UserType = documentSnapshot['UserType'];

    }
   await showDialog(context: context, builder: (BuildContext context)
    {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 350,
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
                  height: 350,
                  child: ListView(

                    children: [
                      const Text('اسم المستخدم',
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
                      const Text('كلمة المرور',
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
                      const Text('صلاحية المستخدم',
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
                        child: DropdownButton<String>(
                          value: _UserType == null || _UserType == "" ? "Admin" : _UserType ,
                          items: menuItems.map((String item){
                               return DropdownMenuItem<String>( value:item, child: Text(item));
                          }).toList(),
                          onChanged: ( val){
                            setState(() {
                                _UserType = val!;
                            });
                          },

                        )
                      ),
                  const SizedBox(height: 10,),
                      Row(
                        children: [
                          GeneralButton(
                            customText: 'الغاء',
                            color: Colors.redAccent,
                            raduis: 30,
                            onTap: () {

                              _UserName.clear();
                              _Password.clear();
                              _UserType ="Admin";
                           

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
                                      _register.doc(documentSnapshot!.id).update({
                                        "UserName": _UserName.text,
                                        "Password": _Password.text,
                                        "UserType": _UserType,
                                      
                                      });

                              setState(() {
                                 _UserName.clear();
                                      _Password.clear();
                                      _UserType ="Admin";
                              });
                                     
                                  

                                      scaffoldKey.currentState!.showSnackBar(
                                          SnackBar(content: const Text(
                                            "تم التعديل بنجاح", textAlign: TextAlign.center, style: TextStyle(
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

  Future<void> DeleteRegister(String Id) async {

    _register.doc(Id).delete();

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
