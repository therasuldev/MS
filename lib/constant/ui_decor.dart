import 'package:flutter/material.dart';

import '../mystore.dart';
import '../view/ui/myclipper.dart';

class UIdecor extends StatelessWidget {
  const UIdecor({Key? key, this.child, this.alignment}) : super(key: key);
  final Widget? child;
  final AlignmentGeometry? alignment;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: size(context).height * .55,
        width: size(context).width,
        alignment: alignment,
        color: lightBlueColor,
        child: child,
      ),
    );
  }
}
