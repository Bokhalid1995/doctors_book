import 'package:flutter/material.dart';
import 'package:doctors_book/core/constants.dart';


//Unused
// ignore: must_be_immutable
class Navigation extends StatelessWidget {
  static int? selindex;
  static List<BottomNavigationBarItem> items = [];

  Navigation({Key? key}) : super(key: key) {
    items.add(const BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: PColor,
        ),
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: "Explore"));
    items.add(const BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.favorite,
          color: PColor,
        ),
        icon: Icon(
          Icons.favorite,
          color: Colors.black,
        ),
        label: "WishList"));
    items.add(const BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.local_offer,
          color: PColor,
        ),
        icon: Icon(
          Icons.local_offer,
          color: Colors.black,
        ),
        label: "Deals"));
    items.add(const BottomNavigationBarItem(
        //backgroundColor: Colors.blue,
        activeIcon: Icon(
          Icons.notifications,
          color: PColor,
        ),
        icon: Icon(
          Icons.notifications,
          color: Colors.black,
        ),
        label: "Notifications"));
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      type: BottomNavigationBarType.shifting,
      selectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal),
      unselectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal),
      currentIndex: selindex!,
      elevation: 1.5,
    );
  }

  int index = 0;
}

class NavigationTest extends StatefulWidget {
  const NavigationTest({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavigationTest createState() => _NavigationTest();
}

class _NavigationTest extends State<NavigationTest> {
  final List<BottomNavigationBarItem> items = [];
  int index = -1;
  Widget navigation() {
    items.add(const BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: PColor,
        ),
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: "Explore"));
    items.add(const BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.favorite,
          color: PColor,
        ),
        icon: Icon(
          Icons.favorite,
          color: Colors.black,
        ),
        label: "WishList"));
    items.add(const BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.local_offer,
          color: PColor,
        ),
        icon: Icon(
          Icons.local_offer,
          color: Colors.black,
        ),
        label: "Deals"));
    items.add(const BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.notifications,
          color: PColor,
        ),
        icon: Icon(
          Icons.notifications,
          color: Colors.black,
        ),
        label: "Notifications"));

    return BottomNavigationBar(
      items: items,
      type: BottomNavigationBarType.fixed,
      currentIndex: -1 + 1,
      elevation: 1.5,
      onTap: (sel) {},
      selectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal),
      unselectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigation();
  }
}
