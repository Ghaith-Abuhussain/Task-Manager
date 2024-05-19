import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final double? iconSize;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  CustomBackButton({
    required this.icon,
    required this.onPressed,
    this.iconSize,
    this.margin,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: MaterialButton(
        onPressed: () => onPressed(),
        color: color,
        textColor: Colors.white,
        padding: padding,
        shape: const CircleBorder(),
        child: Icon(
          icon,
          size: iconSize,
        ),
      ),
    );
  }
}
