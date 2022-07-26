import 'package:doctors_book/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

Future main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Directionality(
      textDirection: TextDirection.rtl, child: DoctorsBook()));
}

class DoctorsBook extends StatelessWidget {
  const DoctorsBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      textDirection: TextDirection.rtl,
      theme: ThemeData(
        fontFamily: 'Cairo',
      ),
      home: const SplashView(),
    );
  }
}
