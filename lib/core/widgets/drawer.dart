
import 'package:flutter/material.dart';
import 'package:doctors_book/core/constants.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
                    child: Icon(Icons.account_circle, color: Colors.white,size: 40,),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "مستشفي الدروشاب التخصصي",
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
          ListTile(
            title: const Text("إدارة الخدمات"),
            leading: IconButton(
              icon: const Icon(Icons.medical_services_outlined),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            onTap: ()
            {
              Navigator.of(context).pop();
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => ServicesControl()));
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("إدارة الإطباء"),
            leading: IconButton(
              icon: const Icon(Icons.people_alt_outlined),
              onPressed: () {
              },
            ),
            onTap: ()
            {
              Navigator.of(context).pop();
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => StaffControl()));
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("إدارة الأقسام"),
            leading: IconButton(
              icon: const Icon(Icons.dashboard),
              onPressed: () {
              },
            ),
            onTap: ()
            {
              Navigator.of(context).pop();
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => DepartmentControl()));
            },
          )
        ],
      ),
    );
  }
}
