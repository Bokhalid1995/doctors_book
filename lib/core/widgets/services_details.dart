import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_book/views/staff.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'more_details.dart';

//final MoreServicesDetails = new MoreServicesDetails(title, category, details, imagePath)
int activeIndex = 0;
var images = [
  "assets/images/136934.jpg",
  "assets/images/136949.jpg",
  "assets/images/1939782.jpg",
  "assets/images/pic_6.jpg",
  "assets/images/pic_7.jpg"
];
var moreServicesDetailsItems = [
  MoreServicesDetails(
      "الموجات الصوتية",
      "العيادات",
      "نوفر خدمة موجات صوتيه اليه الدقة وعلي مدي 24 ساعه والنتيجه فوريه",
      "assets/images/136934.png"),
  MoreServicesDetails(
      "غرف إقامة مريحة",
      "التنويم",
      "غرف مجهزة بأفضل وسائل الراحة للمرضي وبمواصفات ممتازة جدا",
      "assets/images/136949.png"),
];

class ServicesBodyDetails extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ServicesBodyDetails(
    this.moreDetails, {
    this.color = Colors.white12,
  });

  final int moreDetails;
  final Color color;

  @override
  State<ServicesBodyDetails> createState() => _ServicesBodyDetailsState();
}

class _ServicesBodyDetailsState extends State<ServicesBodyDetails> {
  final CollectionReference _hospital =
      FirebaseFirestore.instance.collection('Hospital');
  String hospName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: PColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: StreamBuilder(
            stream: _hospital.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print('fuuuuuuuck : ' + widget.moreDetails.toString());
              DocumentSnapshot data = snapshot.data!.docs[widget.moreDetails];
              print('fuuuuuuuck : ' + data.toString());
              hospName = data['Name'];
              return Column(
                children: [
                  Container(
                    width: SizeConfig.screenWidth!,
                    height: 300,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                    ),
                    child: CarouselSlider.builder(
                        itemCount: images.length,
                        options: CarouselOptions(
                            height: 250,
                            autoPlay: true,
                            autoPlayCurve: Curves.easeInCirc,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            }),
                        itemBuilder: (context, index, realIndex) {
                          final urlImages = images[index];
                          return buildImage(urlImages, index);
                        }),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        data['Name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        data['Location'],
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 15,
                          decorationStyle: null,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        height: SizeConfig.screenheight! / 6,
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(children: [
                          Text(
                            data['Description'],
                            style: const TextStyle(fontSize: 14, color: PColor),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 60,
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  'VIP',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                width: 60,
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: PColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  'اتصل الان',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: PColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              height: 70,
                              child: Row(
                                children: const [
                                  Text(
                                    'الخدمات',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.medical_services,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Staff(hospName, int.parse(hospName))));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: PColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 70,
                                child: Row(
                                  children: const [
                                    Text(
                                      'الكوادر الطبية',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.people_alt_rounded,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const Spacer()
                ],
              );
            }),
      ),
    );
  }

  Widget buildImage(String url, int index) => Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black45), color: Colors.white),
        child: Image.asset(
          url,
          fit: BoxFit.cover,
        ),
      );

  Widget buidIndecator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images.length,
        effect: const JumpingDotEffect(
          dotHeight: 5,
          dotWidth: 15,
          activeDotColor: PColor,
        ),
      );
}

Widget makeInput({label, obsureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obsureText,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(
              color: PColor,
            ),
          ),
          border:
              const OutlineInputBorder(borderSide: BorderSide(color: PColor)),
        ),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
