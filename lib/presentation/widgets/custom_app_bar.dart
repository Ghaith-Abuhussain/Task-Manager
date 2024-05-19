import 'package:flutter/material.dart';

import '../../utils/constants/Colors.dart';
import '../../utils/constants/strings.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Function onFirstIconClicked;
  final Function onSecondIconClicked;
  final Color firstColor;
  final Color secondColor;
  final bool isSearchExists;
  final bool isToggleDrowerExists;
  final IconData firstIcon;
  final IconData secondIcon;
  final Widget? bottom;

  CustomAppBar({
    required this.title,
    required this.firstColor,
    required this.secondColor,
    required this.isSearchExists,
    required this.isToggleDrowerExists,
    required this.firstIcon,
    required this.secondIcon,
    required this.onFirstIconClicked,
    required this.onSecondIconClicked,
    this.bottom = null,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[firstColor, secondColor],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                if(isToggleDrowerExists)
                  IconButton(
                    icon: Icon(
                      firstIcon,
                      size: 20,
                    ),
                    color: Colors.white,
                    onPressed: () => onFirstIconClicked(),
                  ),
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: railwayFontFamily,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.white),
                ),
                const Spacer(),
                if(isSearchExists)
                  IconButton(
                  icon: Icon(
                    secondIcon,
                    size: 20,
                  ),
                  color: Colors.white,
                  onPressed: () => onSecondIconClicked(),
                ),
              ],
            ),
          ),
          if(bottom != null)
            bottom!,
        ],
      ),
    );
  }
}
