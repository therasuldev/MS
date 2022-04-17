import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../mystore.dart';

Future fsnack({
  required BuildContext context,
  required String error,
  required String title,
  required Color snackcolor,
  required FlushbarPosition position,
}) {
  return Flushbar(
    borderRadius: BorderRadius.circular(15),
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    flushbarPosition: position,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    backgroundColor: snackcolor,
    isDismissible: true,
    duration: const Duration(seconds: 5),
    icon: Icon(Icons.info, color: spinkitColor),
    titleText: Text(
      title,
      style: TextStyle(color: spinkitColor, fontSize: 18),
    ),
    messageText: Text(error, style: TextStyle(color: spinkitColor)),
  ).show(context);
}
