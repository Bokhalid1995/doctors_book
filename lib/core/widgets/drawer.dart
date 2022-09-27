import 'package:doctors_book/views/admin/Distribution.dart';
import 'package:doctors_book/views/admin/Hospital_control.dart';
import 'package:doctors_book/views/admin/Login.dart';
import 'package:doctors_book/views/admin/Register.dart';
import 'package:doctors_book/views/admin/Specialize_control.dart';
import 'package:doctors_book/views/admin/admin_dashboard.dart';
import 'package:doctors_book/views/admin/staff_control.dart';
import 'package:doctors_book/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctors_book/core/constants.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({this.popOut});
  final VoidCallback? popOut;
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: PColor,
            ),
            child: Center(
              child: Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "تطبيق احجز طبيبك",
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
          Visibility(
            visible: box.read('UserType') == "Admin" ? true : false,
            child: Column(
              children: [
                ListTile(
                  title: const Text("إدارة المستشفيات"),
                  leading: IconButton(
                    icon: const Icon(Icons.medical_services_outlined),
                    onPressed: () {
                      widget.popOut;
                      Navigator.of(context).pop();
                    },
                  ),
                  onTap: () {
                    widget.popOut;
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const HospitalControl()));
                  },
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  title: const Text("إدارة الإطباء"),
                  leading: IconButton(
                    icon: const Icon(Icons.people_alt_outlined),
                    onPressed: () {},
                  ),
                  onTap: () {
                    widget.popOut;
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const StaffControl()));
                  },
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  title: const Text("التخصصات"),
                  leading: IconButton(
                    icon: const Icon(Icons.people_alt_outlined),
                    onPressed: () {},
                  ),
                  onTap: () {
                    widget.popOut;
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SpecializeControl()));
                  },
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  title: const Text("إدارة المستخدمين"),
                  leading: IconButton(
                    icon: const Icon(Icons.people_rounded),
                    onPressed: () {},
                  ),
                  onTap: () {
                    widget.popOut;
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const RegisterControl()));
                  },
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  title: const Text("توزيع الأطباء"),
                  leading: IconButton(
                    icon: const Icon(Icons.list_rounded),
                    onPressed: () {},
                  ),
                  onTap: () {
                    widget.popOut;
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const DistributionControl()));
                  },
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Visibility(
                  visible: box.read('UserType') == "Admin" ? true : false,
                  child: ListTile(
                    title: const Text("التقارير"),
                    leading: IconButton(
                      icon: const Icon(Icons.read_more),
                      onPressed: () {},
                    ),
                    onTap: () {
                      widget.popOut;
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdminDashboard()));
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("الصفحه الرئيسية"),
            leading: IconButton(
              icon: const Icon(Icons.home_filled),
              onPressed: () {},
            ),
            onTap: () {
              widget.popOut;
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const MainScreen()));
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("تسجيل الخروج"),
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {},
            ),
            onTap: () {
              box.remove('UserName');
              box.remove('HospitalName');
              widget.popOut;
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Login()));
            },
          ),
        ],
      ),
    );
  }
}
