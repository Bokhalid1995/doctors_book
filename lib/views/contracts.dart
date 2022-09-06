import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/shared/models/hospitals.dart';
import 'package:doctors_book/shared/services_distributions.dart';
import 'package:doctors_book/shared/services_hospital.dart';
import 'package:doctors_book/views/staff.dart';
import 'package:flutter/material.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/core/widgets/more_details.dart';

class PublicServices extends StatefulWidget {
  const PublicServices({Key? key}) : super(key: key);

  @override
  State<PublicServices> createState() => _PublicServicesState();
}

class _PublicServicesState extends State<PublicServices> {
  List<MoreServicesDetails> listToFill = moreServicesDetailsItems;
  final CollectionReference _hospital =
      FirebaseFirestore.instance.collection('Hospital');

  var hospitalApi = ServicesHospital();
  String? hospName = "";
  int? hospId;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: SizeConfig.screenheight! + 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: SizeConfig.screenheight! / 5,
                decoration: BoxDecoration(
                  color: PColor.withOpacity(0.20),
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30), bottom: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: size.height * 0.1,
                      child: Row(
                        children: [
                          Text(
                            'ابحث من هنا ',
                            style: TextStyle(
                              color: const Color(0xff0a0a0a).withOpacity(0.40),
                              fontSize: 17,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: Icon(
                              Icons.volunteer_activism,
                              color: const Color(0xff0a0a0a).withOpacity(0.65),
                            ),
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
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: hospitalApi.GetAll(),
                builder:
                    (context, AsyncSnapshot<List<HospitalsModel>> snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: SizeConfig.screenheight! / 1.6,
                            padding: const EdgeInsets.all(10),
                            child: snapshot.data!.isEmpty
                                ? (const Text(
                                    'لايوجد نتائج للبحث',
                                    style: (TextStyle(color: Colors.red)),
                                    textAlign: TextAlign.center,
                                  ))
                                : ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      HospitalsModel data =
                                          snapshot.data![index];
                                      return Container(
                                        height: 70,
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                      PColor.withOpacity(0.20),
                                                  blurRadius: 5,
                                                  offset: Offset(0, 3))
                                            ]),
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Staff(data.name!, data.id!),
                                              ),
                                            );
                                          },
                                          hoverColor: PColor,
                                          leading: const Icon(
                                            Icons.home_work_outlined,
                                            color: PColor,
                                          ),
                                          title: Text(data.name!),
                                          subtitle: Text(data.location!),
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
