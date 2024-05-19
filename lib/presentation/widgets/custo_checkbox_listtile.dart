import 'package:flutter/material.dart';

class CustomCheckBoxListTile extends StatefulWidget {
  final String label;
  final Function onChange;
  final TextStyle? textStyle;
  bool value;

  CustomCheckBoxListTile(
      {required this.value, required this.label, required this.onChange, this.textStyle,});

  @override
  State<CustomCheckBoxListTile> createState() => _CustomCheckBoxListTileState();
}

class _CustomCheckBoxListTileState extends State<CustomCheckBoxListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: widget.value,
            onChanged: (newValue) {
              setState(() {
                widget.value = newValue!;
                widget.onChange(newValue);
              });

            },
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            widget.label,
            style: widget.textStyle,
          ),
        ],
      ),
    );
  }
}
