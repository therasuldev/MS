import 'package:flutter/material.dart';

// constant Size
Size size(BuildContext context) {
  return MediaQuery.of(context).size;
}

//==================
EdgeInsets defaultPadding(BuildContext context) {
  return EdgeInsets.only(left: size(context).width * .025);
}

RegExp regExp() {
  return RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
}

// Screen page
String get screenTitle => 'Paltar magazam';
String get screenSubtitle =>
    'Magazada olan ve getirilen son\n mallardan xeberdar olun...';
// Login page
String get pLoginTitle => 'Programa';
String get pLoginSubtitle => 'Xos geldiniz';
//GIF
String get onb1 => 'assets/lottie/onb_1.json';
String get onb2 => 'assets/lottie/onb_2.json';
String get onb3 => 'assets/lottie/onb_3.json';
//Colors
Color get lightBlueColor => const Color.fromARGB(255, 174, 208, 248);
Color get darkBlueColor => const Color.fromARGB(255, 155, 190, 231);
Color get spinkitColor => const Color(0xFFFFFFFF);
Color get snackErrorColor => const Color(0xFF750A0A);
Color get snackSuccessColor => const Color(0xFF278A34);
Color get kBackgroundColor => const Color.fromARGB(255, 132, 168, 209);
Color get blackAccent => Colors.black.withOpacity(.5);
Color get greyAccent => const Color.fromARGB(255, 180, 180, 180);
//Images
const String googleImage = 'assets/img/google.png';
const String facebookImage = 'assets/img/facebook.png';
