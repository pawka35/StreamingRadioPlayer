import 'package:flutter/material.dart';

class Typogaphy {
  /* Name: fontSize + fontWeight + color */
  static TextStyle s50w400cWhite = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 50,
    color: Colors.white,
    fontFamily: 'SF-Pro',
  );

  static TextStyle s25w400cWhite = s50w400cWhite.copyWith(fontSize: 25);
  static TextStyle s16w500cWhite =
      s50w400cWhite.copyWith(fontSize: 16, fontWeight: FontWeight.w500);
  static TextStyle s16w300cWhite =
      s16w500cWhite.copyWith(fontWeight: FontWeight.w300);

  static TextStyle s16w300cBlack50 =
      s16w300cWhite.copyWith(color: UIColors.black50);

  static TextStyle s16w300cRed = s16w300cWhite.copyWith(color: UIColors.red);
  static TextStyle s20w500cRed =
      s16w500cWhite.copyWith(fontSize: 20, color: UIColors.red);
}

class UIColors {
  static Color red = const Color.fromARGB(255, 255, 41, 109);

  static Color black50 = const Color.fromARGB(128, 255, 255, 255);
}
