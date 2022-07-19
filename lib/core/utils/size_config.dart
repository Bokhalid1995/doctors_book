import 'package:flutter/material.dart';

class SizeConfig {
  static double? screenWidth;
  static double? screenheight;
  static double? defualtSize;
  static Orientation? orientation;

  void init(BuildContext context){
    screenheight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    orientation = MediaQuery.of(context).orientation;

    defualtSize = orientation == Orientation.landscape ? screenheight! * .024 : screenWidth! * .024;
  }



}