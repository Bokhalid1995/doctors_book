import 'package:flutter/material.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';

class MoreServicesDetails {
  final String title;
  final String category;
  final String details;
  final String imagePath;

  MoreServicesDetails(this.title, this.category, this.details, this.imagePath);
}

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
  MoreServicesDetails("الزيتونة", "مستشفي",
      "الخرطوم - العربي - قرب شارع الحوادث", "assets/images/136949.jpg"),
  MoreServicesDetails("فضيل", "مستشفي", "الخرطوم - العربي - قرب شارع الحوادث",
      "assets/images/136949.jpg"),
];

class MoreDetails extends StatefulWidget {
  const MoreDetails(
      {this.color = Colors.white12,
      this.press,
      required this.name,
      required this.spec,
      required this.degree});

  final String name;
  final String spec;
  final String degree;
  final Color color;
  final Function? press;

  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.press!(),
      child: Container(
        width: SizeConfig.screenWidth! / 2.2,
        height: 160,
        // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
        decoration: BoxDecoration(
          // border: Border.all(color: PColor.withOpacity(0.8),width: 0.2),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),

        child: Column(
          children: [
            Container(
              width: SizeConfig.screenWidth! / 2.2,
              height: 120,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                    topLeft: Radius.circular(18),
                    topRight: const Radius.circular(18)),
                image: DecorationImage(
                    image: AssetImage("assets/images/pic_8.jpg"),
                    fit: BoxFit.contain),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: (SizeConfig.screenWidth! / 2) - 17,
                    height: 30,
                    decoration: BoxDecoration(
                      color: PColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18)),
                    ),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          color: Colors.grey.shade100,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.spec,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.degree,
                    style: const TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
