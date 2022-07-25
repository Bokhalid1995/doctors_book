import 'package:doctors_book/core/constants.dart';
import 'package:doctors_book/core/widgets/drawer.dart';

import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PColor,
        title: Text("لوحة التحكم"),
      ),
      drawer: CustomDrawer(),
      

    );
  }
}
