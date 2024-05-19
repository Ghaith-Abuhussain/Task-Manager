import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  final TextStyle? textStyle;
  final String label;
  final Color? focusedBorderSideColor;
  final Color? defaultBorderSideColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final List<String>? valuesList;
  final Function onChange;

  CustomDropDownMenu({
    this.textStyle,
    required this.label,
    this.focusedBorderSideColor,
    this.defaultBorderSideColor,
    this.width,
    this.height,
    this.margin = const EdgeInsets.symmetric(horizontal: 30),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    this.valuesList,
    required this.onChange,
  });

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      child: DropdownButtonFormField(
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
        ),
        style: widget.textStyle,
        value: widget.valuesList!.elementAt(0),
        onChanged: (newValue) {
          setState(() {
            widget.onChange(newValue);
          });
        },
        items: widget.valuesList!.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: Text(valueItem),
          );
        }).toList(),
      ),
    );
  }
}
