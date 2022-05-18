import 'package:flutter/material.dart';

class CommonUI {
  static Widget getlogoWithTextUI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 90,
          width: 90,
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }

  static Widget getTaranaText(double fontSizeCustom) {
    // double _fontSizeCustom ??= 40.0;
    return Text(
      "tarana",
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSizeCustom,
        fontFamily: 'poppins',
      ),
    );
  }

  static Widget setTextAndFont(double fontSizeCustom, String text) {
    // double _fontSizeCustom ??= 40.0;
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSizeCustom,
        fontFamily: 'poppins',
      ),
    );
  }

}
