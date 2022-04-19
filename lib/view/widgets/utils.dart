import 'package:flutter/material.dart';
import 'package:ms/constant/constant.dart';

class ViewUtils {
  static nonBorderDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      hintStyle: TextStyle(color: greyAccent),
    );
  }

  static formDecoration() {
    return BoxDecoration(
      color: const Color.fromARGB(255, 222, 237, 245),
      borderRadius: BorderRadius.circular(15),
    );
  }

  // showSnack shows easy-modifiable snack bar.
  static showSnack(
    BuildContext context, {
    required String title,
    bool isFloating = false,
    required Color color,
    int sec = 4,
  }) async {
    final snack = SnackBar(
      content: Text(title, style: const TextStyle(color: Colors.white)),
      duration: Duration(seconds: sec),
      margin: isFloating ? const EdgeInsets.all(8) : null,
      behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: isFloating
            ? BorderRadius.circular(8)
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
      ),
      backgroundColor: color,
    );

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
