import 'package:flutter/material.dart';
import 'package:doctors_book/core/utils/size_config.dart';

class GroceryFeaturedItem {
  final String name;
  final String imagePath;
  final int statcs;

  GroceryFeaturedItem(this.name, this.imagePath ,this.statcs);
}

var groceryFeaturedItems = [
  GroceryFeaturedItem("المستشفيات", "assets/images/136934.jpg" , 45),
  GroceryFeaturedItem("المعامل", "assets/images/136949.jpg" , 17),
  GroceryFeaturedItem("الصيدليات", "assets/images/136934.jpg" , 34),
  GroceryFeaturedItem("الخدمات ", "assets/images/136949.jpg", 13),
];

class GroceryFeaturedCard extends StatelessWidget {
   const GroceryFeaturedCard(this.groceryFeaturedItem, this.color, {Key? key}) : super(key: key);
  final Color? color;
  final GroceryFeaturedItem groceryFeaturedItem;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: SizeConfig.screenWidth! / 1.7,
          height: 150,
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
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      style:  const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              ),
              const Spacer(),
              Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    groceryFeaturedItem.statcs.toString(),
                    style: TextStyle(
                      color: color,
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
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
  