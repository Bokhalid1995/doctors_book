import 'package:flutter/material.dart';

class DecorationContainer extends StatelessWidget {
   const DecorationContainer(this.value, {Key? key}) : super(key: key);
  final double? value;

  @override
  Widget build(BuildContext context) {
     return Container(
       child: CircleAvatar(),
     );
  }
}