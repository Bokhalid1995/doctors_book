import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/views/staff.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/more_details.dart';
import 'package:doctors_book/core/widgets/services_details.dart';

var moreServicesDetailsItems = [
  MoreServicesDetails("ابراهيم مالك", "مستشفي",
      "الخرطوم - بري - شارع بري بالنص", "assets/images/136934.jpg"),
  MoreServicesDetails("رويال كير", "مستشفي", "الخرطوم 2 - جوار مطاعم برشلونة",
      "assets/images/136949.jpg"),
  MoreServicesDetails("الترا لاب", "معمل",
      "الخرطوم - العربي - قرب شارع الحوادث", "assets/images/136949.jpg"),
  MoreServicesDetails(
      "مستشفي الأطباء",
      "مستشفي",
      "الخرطوم - العمارات - قرب لفه الجريف - شارع المطار",
      "assets/images/136949.jpg"),
  MoreServicesDetails("الوسيلة", "صيدلية",
      "الخرطوم - العربي - قرب شارع الحوادث", "assets/images/136949.jpg"),
  MoreServicesDetails("الزيتونة", "مستشفي",
      "الخرطوم - العربي - قرب شارع الحوادث", "assets/images/136949.jpg"),
  MoreServicesDetails("فضيل", "مستشفي", "الخرطوم - العربي - قرب شارع الحوادث",
      "assets/images/136949.jpg"),
  MoreServicesDetails("ابن سينا", "مستشفي",
      "الخرطوم - العربي - قرب شارع الحوادث", "assets/images/136949.jpg"),
  MoreServicesDetails("المتكامل", "مركز صحي",
      "الخرطوم - العربي - قرب شارع الحوادث", "assets/images/136949.jpg"),
  MoreServicesDetails("الرعاية الخاصة", "معمل",
      "الخرطوم - العربي - قرب شارع الحوادث", "assets/images/136949.jpg"),
];

class PublicServices extends StatefulWidget {
  const PublicServices({Key? key}) : super(key: key);

  @override
  State<PublicServices> createState() => _PublicServicesState();
}

class _PublicServicesState extends State<PublicServices> {
  List<MoreServicesDetails> listToFill = moreServicesDetailsItems;
  final CollectionReference _hospital =
      FirebaseFirestore.instance.collection('Hospital');
  String? hospName = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: SizeConfig.screenheight! + 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: SizeConfig.screenheight! / 5,
                decoration: BoxDecoration(
                  color: PColor.withOpacity(0.20),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30), bottom: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      height: size.height * 0.1,
                      child: Row(
                        children: [
                          Text(
                            'ابحث من هنا ',
                            style: TextStyle(
                              color: Color(0xff0a0a0a).withOpacity(0.65),
                              fontSize: 17,
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Icon(
                              Icons.volunteer_activism,
                              color: Color(0xff0a0a0a).withOpacity(0.65),
                            ),
                            height: 40,
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 55,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        onSubmitted: (value) {
                          setState(() {
                            hospName = value;
                            listToFill = moreServicesDetailsItems
                                .where(
                                    (element) => element.title.contains(value))
                                .toList();
                            //  print("Fuuuk" + moreServicesDetailsItems.toJS().toString() + "  " + value + " === " );
                          });
                        },
                        decoration: InputDecoration(
                          suffixIconColor: PColor.withOpacity(0.33),
                          hintText: 'بحث ...',
                          hintStyle: TextStyle(color: PColor.withOpacity(0.33)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
                stream: _hospital.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: SizeConfig.screenheight! / 1.6,
                            padding: EdgeInsets.all(10),
                            child: snapshot.data!.docs.length == 0
                                ? (Text(
                                    'لايوجد نتائج للبحث',
                                    style: (TextStyle(color: Colors.red)),
                                    textAlign: TextAlign.center,
                                  ))
                                : ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot data =
                                          snapshot.data!.docs[index];
                                      return Container(
                                        height: 70,
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: PColor.withOpacity(0.10),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Staff(data['Name']),
                                              ),
                                            );
                                          },
                                          hoverColor: PColor,
                                          leading: Icon(
                                            Icons.home_work_outlined,
                                            color: PColor,
                                          ),
                                          title: Text(data['Name']),
                                          subtitle: Text(data['Location']),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        );
                }),
          ],
        ),
      ),
    );
  }
}
