import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class CustomEditText extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData? icon;
  final bool obscureText;
  final TextStyle? textStyle;
  final Function validator;
  final Color? defaultBorderSideColor;
  final Color? focusedBorderSideColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool? readOnly;
  final bool? showSuffixIcon;
  final Function? onTap;
  final TextInputType? textInputType;

  CustomEditText({
    required this.label,
    required this.controller,
    this.icon,
    this.obscureText = false,
    this.textStyle,
    required this.validator,
    this.defaultBorderSideColor,
    this.focusedBorderSideColor,
    this.textInputType,
    this.width,
    this.height,
    this.showSuffixIcon = false,
    this.margin = const EdgeInsets.symmetric(horizontal: 30),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    this.readOnly = false,
    this.onTap,
  });

  @override
  State<CustomEditText> createState() => _CustomEditTextState();
}

class _CustomEditTextState extends State<CustomEditText> {
  bool passwordVisible=true;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding!,
      child: Container(
        margin: widget.margin,
        width: widget.width,
        height: widget.height,
        child: TextFormField(

          onTap: () {
            if(!(widget.onTap == null)){
              widget.onTap!();
            }
          },
          readOnly: widget.readOnly!,
          obscureText: widget.obscureText == false? false: passwordVisible,
          style: widget.textStyle,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: widget.focusedBorderSideColor!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: widget.defaultBorderSideColor!),
            ),

            labelText: widget.label,
            prefixIcon: Icon(widget.icon, ),

            suffixIcon: widget.showSuffixIcon == true ? IconButton(
              icon: Icon(passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: () {
                setState(
                      () {
                    passwordVisible = !passwordVisible;
                  },
                );
              },
            ) : null,
          ),
          validator: (_) => widget.validator(_),
          controller: widget.controller,
          keyboardType: widget.textInputType,
        ),
      ),
    );
  }
}
