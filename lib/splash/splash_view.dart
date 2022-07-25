
import 'package:flutter/material.dart';
import 'package:doctors_book/Splash/splash_body.dart';
import 'package:doctors_book/core/constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
           decoration: const BoxDecoration(
             color: PColor,
             image: DecorationImage(
               image: AssetImage("assets/images/doc_bg.jpg" ),
               fit: BoxFit.cover
             ),

           ),
          child: const SplashBody()),
    );
  }
}
