
import 'package:doctors_book/core/utils/size_config.dart';
import 'package:flutter/material.dart';


class GeneralButton extends StatelessWidget {
  const GeneralButton({Key? key, this.customText, this.onTap, this.color, this.raduis}) : super(key: key);
  final VoidCallback? onTap;
  final String? customText;
  final Color? color;
  final double? raduis;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: SizeConfig.screenWidth! / 3,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(raduis!),
        ),
        child: Center(
          child: Text(
            customText!
            ,style: const TextStyle(color: Colors.white ,fontSize: 17.0,letterSpacing: 0.0),
          ),
        ),
      ),
    );
  }
}
