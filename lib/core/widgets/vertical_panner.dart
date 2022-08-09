import 'package:flutter/material.dart';
import 'package:doctors_book/core/utils/size_config.dart';

class GroceryFeaturedItem {
  final String name;
  final String imagePath;
  final int statcs;

  GroceryFeaturedItem(this.name, this.imagePath, this.statcs);
}

var groceryFeaturedItems = [
  GroceryFeaturedItem("الحجوزات", "assets/images/136934.jpg", 45),
  GroceryFeaturedItem("الاطباء", "assets/images/136949.jpg", 17),
  GroceryFeaturedItem("المستشفيات", "assets/images/136934.jpg", 34),
];

class GroceryFeaturedCard extends StatelessWidget {
  const GroceryFeaturedCard(this.groceryFeaturedItem, this.color, {Key? key})
      : super(key: key);
  final Color? color;
  final GroceryFeaturedItem groceryFeaturedItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: SizeConfig.screenWidth! / 1.8,
          height: 120,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
          decoration: BoxDecoration(
              color: color!.withOpacity(0.15),

              // image: DecorationImage(
              //     image: AssetImage(groceryFeaturedItem.imagePath),
              //     fit: BoxFit.cover),
              // boxShadow: [
              //   BoxShadow(
              //     offset: Offset(0,0),
              //     blurRadius: 30,
              //     color: Color(0xFF100E0E).withOpacity(0.05),
              //   )
              // ],
              borderRadius: BorderRadius.circular(18)),
          child: Row(
            children: [
              Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color!.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                      // boxShadow: [
                      //   BoxShadow(
                      //     offset: Offset(0,0),
                      //     blurRadius: 30,
                      //     color: Color(0xFF0377AD).withOpacity(0.5),
                      //   )
                      // ]
                    ),
                    child: Text(
                      groceryFeaturedItem.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    groceryFeaturedItem.statcs.toString(),
                    style: TextStyle(
                      color: color,
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
