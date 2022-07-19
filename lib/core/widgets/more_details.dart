import 'package:flutter/material.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';


class MoreServicesDetails {
  final String title;
  final String category;
  final String details;
  final String imagePath;

  MoreServicesDetails(this.title,this.category,this.details ,this.imagePath);
}

var moreServicesDetailsItems = [
  MoreServicesDetails("ابراهيم مالك","مستشفي","الخرطوم - بري - شارع بري بالنص", "assets/images/136934.jpg"),
  MoreServicesDetails("رويال كير","مستشفي","الخرطوم 2 - جوار مطاعم برشلونة", "assets/images/136949.jpg"),
  MoreServicesDetails("الترا لاب","معمل","الخرطوم - العربي - قرب شارع الحوادث", "assets/images/136949.jpg"),
  MoreServicesDetails("مستشفي الأطباء","مستشفي","الخرطوم - العمارات - قرب لفه الجريف - شارع المطار", "assets/images/136949.jpg"),
  MoreServicesDetails("الزيتونة","مستشفي","الخرطوم - العربي - قرب شارع الحوادث", "assets/images/136949.jpg"),
  MoreServicesDetails("فضيل","مستشفي","الخرطوم - العربي - قرب شارع الحوادث", "assets/images/136949.jpg"),

];

class MoreDetails extends StatelessWidget {
  const MoreDetails(this.moreDetails,
      {this.color = Colors.white12 ,this.press});

  final MoreServicesDetails moreDetails;
  final Color color;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap:() => press!(),
      child: Container(
        width: SizeConfig.screenWidth! / 2.2,
        height: 160,
        // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
        decoration: BoxDecoration(
         // border: Border.all(color: PColor.withOpacity(0.8),width: 0.2),
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(15),
          ),

        child: Column(

          children: [
            Container(

               width: SizeConfig.screenWidth! / 2.2,
              height: 120,

              decoration : BoxDecoration(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.zero, bottomRight: Radius.zero,topLeft: const Radius.circular(18),topRight: const Radius.circular(18)),

                image: DecorationImage(
                    image: AssetImage(moreDetails.imagePath),
                    fit: BoxFit.cover
                ),
              ),
              child:   Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      color: PColor.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(bottomRight: const Radius.circular(30) , topLeft: Radius.circular(15)),
                    ),

                    child: Text(

                      'VIP',style: TextStyle(
                        color: Colors.grey.shade100,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
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
                    moreDetails.title,
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    moreDetails.category,
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
