import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberEditText extends StatelessWidget {
  final String label;
  final String initialCountryCode;
  final TextStyle? textStyle;
  final Color? focusedBorderSideColor;
  final Color? defaultBorderSideColor;
  final TextEditingController controller;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Function onChange;

  PhoneNumberEditText({
    required this.label,
    required this.initialCountryCode,
    required this.onChange,
    this.textStyle,
    this.focusedBorderSideColor,
    this.defaultBorderSideColor,
    required this.controller,
    this.width,
    this.height,
    this.margin = const EdgeInsets.symmetric(horizontal: 30),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      margin: margin,
      child: IntlPhoneField(

        style: textStyle,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: focusedBorderSideColor!,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: defaultBorderSideColor!),
          ),
          labelText: label,
        ),
        onChanged: (phone) => onChange(phone),
        controller: controller,
        initialCountryCode: initialCountryCode,

      ),
    );
  }
}
