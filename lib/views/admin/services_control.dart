import 'package:doctors_book/core/widgets/drawer.dart';
import 'package:flutter/material.dart';

class ServicesControl extends StatelessWidget {
  const ServicesControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إدارة الخدمات"),
      ),
      drawer: CustomDrawer(popOut: () {
        Navigator.of(context).pop();
      }),
    );
  }
}
