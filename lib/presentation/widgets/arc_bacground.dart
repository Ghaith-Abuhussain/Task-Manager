import 'package:flutter/material.dart';

class ArcBackground extends StatelessWidget {
  final double? height;
  final double? originHeigth;
  final Widget? child;

  ArcBackground({required this.child, required this.height, this.originHeigth});
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        width: double.infinity,
        height: height,
        color: Colors.orange,
        child: child,
      ),
      clipper: RoundedClipper(originHeigth),
    );
  }
}

class RoundedClipper extends CustomClipper<Path> {
  final double? originHeigth;
  RoundedClipper(this.originHeigth);
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.quadraticBezierTo(
        size.width / 2,
        size.height - originHeigth!,
        size.width,
        size.height
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}