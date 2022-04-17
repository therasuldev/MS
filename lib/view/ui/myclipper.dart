import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    var controlPoint = Offset(40, size.height);
    var controlPoint1 = Offset(size.width - 150, size.height - 30);
    var endPoint = Offset(size.width * .3, size.height - 10);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * .4);
    path.quadraticBezierTo(
        controlPoint1.dx, controlPoint1.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
