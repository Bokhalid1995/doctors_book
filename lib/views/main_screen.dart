// ignore_for_file: unnecessary_const

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
    const Tab(icon: Icon(Icons.people_outlined), text: 'التعاقدات'),
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              elevation: 2,
              hoverColor: Colors.grey.shade700,
              child: const Icon(
                Icons.call,
                color: PColor,
              ),
            ),
            backgroundColor: PColor,
            drawer: Drawer(
              backgroundColor: Colors.transparent,
              child: Container(
                height: SizeConfig.screenheight!,
                decoration: const BoxDecoration(
                  color: PColor,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(30)),
                ),
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: PColor,
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CircleAvatar(
                                child: Image.asset(
                                    "assets/images/insurance/pic (5).png"),
                              ),
                            ),
                            const Expanded(
                              flex: 6,
                              child: const Text(
                                "تطبيق حجز الطبيب",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: SizeConfig.screenheight! / 1.33,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30)),
                        color: Colors.green.shade50,
                      ),
                      child: Column(
                        children: [
                          // ListTile(
                          //   title: const Text("الفروع"),
                          //   leading: IconButton(
                          //     color: PColor,
                          //     icon: const Icon(Icons.home_work_outlined),
                          //     onPressed: () {
                          //       Navigator.of(context).pop();
                          //     },
                          //   ),
                          //   onTap: ()
                          //   {
                          //     Navigator.of(context).pop();
                          //     //   Navigator.of(context).push(MaterialPageRoute(
                          //     //       builder: (BuildContext context) => ServicesControl()));
                          //   },
                          // ),
                          // const Divider(
                          //   color: Colors.grey,
                          // ),
                          // ListTile(
                          //   title: const Text("التأمينات الاخري"),
                          //   leading: IconButton(
                          //     color: PColor,
                          //     icon: const Icon(Icons.devices_other),
                          //     onPressed: () {
                          //     },
                          //   ),
                          //   onTap: ()
                          //   {
                          //     Navigator.of(context).pop();
                          //     // Navigator.of(context).push(MaterialPageRoute(
                          //     //     builder: (BuildContext context) => StaffControl()));
                          //   },
                          // ),
                          // const Divider(
                          //   color: Colors.grey,
                          // ),
                          // ListTile(
                          //   title: const Text("عن الشركة"),
                          //   leading: IconButton(
                          //     color: PColor,
                          //     icon: const Icon(Icons.info),
                          //     onPressed: () {
                          //     },
                          //   ),
                          //   onTap: ()
                          //   {
                          //     Navigator.of(context).pop();
                          //     // Navigator.of(context).push(MaterialPageRoute(
                          //     //     builder: (BuildContext context) => DepartmentControl()));
                          //   },
                          // ),
                          // const Divider(
                          //   color: Colors.grey,
                          // ),
                          ListTile(
                            title: const Text("عن التطبيق"),
                            leading: IconButton(
                              color: PColor,
                              icon:
                                  const Icon(Icons.add_to_home_screen_outlined),
                              onPressed: () {},
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (BuildContext context) => DepartmentControl()));
                            },
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          ListTile(
                            title: const Text("تواصل معنا"),
                            leading: IconButton(
                              color: PColor,
                              icon: const Icon(Icons.login),
                              onPressed: () {},
                            ),
                            onTap: () {
                              //Navigator.of(context).pop();
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (BuildContext context) => Register()));
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: PColor,

              elevation: 0,

              // bottom: TabBar(
              //    padding: EdgeInsets.all(15),
              //   // labelColor: Colors.white,
              //   unselectedLabelColor: PColor,
              //   labelStyle: const TextStyle(fontFamily: 'cairo',fontWeight: FontWeight.bold),
              //  // unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
              //  //  overlayColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
              //  //    // if (states.contains(MaterialState.pressed)) {
              //  //    //   return Colors.white;
              //  //    // } if (states.contains(MaterialState.focused)) {
              //  //    //   return PColor;
              //  //    // } else if (states.contains(MaterialState.hovered)) {
              //  //    //   return Colors.grey;
              //  //    // }
              //  //
              //  //    return Colors.transparent;
              //  //  }),
              //   indicatorWeight: 10,
              //   // indicatorColor: Colors.black45,
              //   indicatorSize: TabBarIndicatorSize.tab,
              //   indicatorPadding: const EdgeInsets.all(2),
              //   indicator: BoxDecoration(
              //
              //     border: Border.all(color: PColor),
              //     borderRadius: BorderRadius.circular(100),
              //     color: PColor,
              //   ),
              //   isScrollable: true,
              //   physics: BouncingScrollPhysics(),
              //   onTap: (int index) {
              //     print('Tab $index is tapped');
              //   },
              //   enableFeedback: true,
              //   // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
              //   // controller: _tabController,
              //   tabs: _tabs,
              // ),

              title: const Text(
                'تطبيق حجز الطبيب',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),

              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdminDashboard()));
                    },
                    icon: const Icon(Icons.fullscreen_exit_rounded))
              ],
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
