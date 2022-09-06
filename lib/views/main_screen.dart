// ignore_for_file: unnecessary_const

import 'package:doctors_book/splash/splash_view.dart';
import 'package:doctors_book/views/admin/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:doctors_book/views/contracts.dart';
import 'package:doctors_book/views/hom_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Directionality(
        textDirection: TextDirection.rtl, child: const MainScreenBody());
  }
}

class MainScreenBody extends StatefulWidget {
  const MainScreenBody({Key? key}) : super(key: key);

  @override
  State<MainScreenBody> createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(2);
  }

  // ignore: unused_field
  static const List<Tab> _tabs = [
    const Tab(icon: Icon(Icons.home), child: const Text('الرئيسية')),
    const Tab(icon: Icon(Icons.people_outlined), text: 'المستشفيات'),
  ];

  static const List<Widget> _views = [
    const Center(child: HomeScreen()),
    // const Staff(),
    const PublicServices(),
    // const AboutHospital(),
    // const AboutApp(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cairo',
      ),
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const SplashView()));
              },
              backgroundColor: Colors.white,
              elevation: 2,
              hoverColor: Colors.grey.shade700,
              child: const Icon(
                Icons.logout,
                color: PColor,
              ),
            ),
            backgroundColor: PColor,
            // drawer: Drawer(
            //   backgroundColor: Colors.transparent,
            //   child: Container(
            //     height: SizeConfig.screenheight!,
            //     decoration: const BoxDecoration(
            //       color: PColor,
            //       borderRadius:
            //           BorderRadius.horizontal(left: Radius.circular(30)),
            //     ),
            //     child: ListView(
            //       children: [
            //         DrawerHeader(
            //           decoration: const BoxDecoration(
            //             color: PColor,
            //           ),
            //           child: Center(
            //             child: Row(
            //               children: [
            //                 Expanded(
            //                   flex: 2,
            //                   child: CircleAvatar(
            //                     child: Image.asset(
            //                         "assets/images/insurance/pic (5).png"),
            //                   ),
            //                 ),
            //                 const Expanded(
            //                   flex: 6,
            //                   child: const Text(
            //                     "تطبيق حجز الطبيب",
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 16,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         Container(
            //           height: SizeConfig.screenheight! / 1.33,
            //           decoration: BoxDecoration(
            //             borderRadius: const BorderRadius.only(
            //                 bottomLeft: Radius.circular(30)),
            //             color: Colors.green.shade50,
            //           ),
            //           child: Column(
            //             children: [
            //               ListTile(
            //                 title: const Text("عن التطبيق"),
            //                 leading: IconButton(
            //                   color: PColor,
            //                   icon:
            //                       const Icon(Icons.add_to_home_screen_outlined),
            //                   onPressed: () {},
            //                 ),
            //                 onTap: () {
            //                   Navigator.of(context).pop();
            //                   // Navigator.of(context).push(MaterialPageRoute(
            //                   //     builder: (BuildContext context) => DepartmentControl()));
            //                 },
            //               ),
            //               const Divider(
            //                 color: Colors.grey,
            //               ),
            //               ListTile(
            //                 title: const Text("تواصل معنا"),
            //                 leading: IconButton(
            //                   color: PColor,
            //                   icon: const Icon(Icons.login),
            //                   onPressed: () {},
            //                 ),
            //                 onTap: () {
            //                   //Navigator.of(context).pop();
            //                   // Navigator.of(context).push(MaterialPageRoute(
            //                   //     builder: (BuildContext context) => Register()));
            //                 },
            //               ),
            //               const Divider(
            //                 color: Colors.grey,
            //               ),
            //               ListTile(
            //                 title: const Text("الخروج"),
            //                 leading: IconButton(
            //                   icon: const Icon(Icons.logout),
            //                   onPressed: () {},
            //                 ),
            //                 onTap: () {
            //                   Navigator.of(context).push(MaterialPageRoute(
            //                       builder: (BuildContext context) =>
            //                           const SplashView()));
            //                 },
            //               )
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            appBar: AppBar(
              backgroundColor: PColor,
              elevation: 0,
              centerTitle: true,
              actions: const [Icon(Icons.info_sharp)],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/pic_1.png',
                    height: 35,
                    width: 35,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'تطبيق حجز الأطباء',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              bottom: TabBar(
                padding: const EdgeInsets.all(15),
                // labelColor: Colors.white,
                unselectedLabelColor: Colors.blueGrey,
                labelStyle: const TextStyle(
                    fontFamily: 'cairo', fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(
                    fontFamily: 'cairo', fontWeight: FontWeight.bold),
                overlayColor:
                    MaterialStateColor.resolveWith((Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return PColor;
                  }
                  if (states.contains(MaterialState.focused)) {
                    return Colors.white;
                  } else if (states.contains(MaterialState.hovered)) {
                    return Colors.grey;
                  }

                  return PColor.withOpacity(0.20);
                }),
                indicatorWeight: 10,
                indicatorColor: Colors.black45,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.all(2),
                indicator: BoxDecoration(
                  border: Border.all(color: PColor),
                  borderRadius: BorderRadius.circular(100),
                  color: PColor,
                ),
                isScrollable: true,
                physics: const BouncingScrollPhysics(),
                onTap: (int index) {
                  print('Tab $index is tapped');
                },
                enableFeedback: true,
                // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
                // controller: _tabController,
                tabs: _tabs,
              ),
              // title: const Text(
              //   'تطبيق حجز الطبيب',
              //   style: TextStyle(fontSize: 17, color: Colors.white),
              // ),
            ),
            body: const Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
                // controller: _tabController,
                children: _views,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
