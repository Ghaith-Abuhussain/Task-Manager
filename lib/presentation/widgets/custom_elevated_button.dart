import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? fontSize;
  final Color? shadowColor;
  final double? elevation;
  final BorderSide? side;
  final Color? textColor;

  CustomElevatedButton({
    required this.text,
    required this.onPressed,
    this.height = double.infinity,
    this.width = double.infinity,
    this.color = CustomColors.buttonColor,
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.shadowColor,
    this.elevation,
    this.side,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: color,
          shadowColor: shadowColor,
          side: side,
          elevation: elevation,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
