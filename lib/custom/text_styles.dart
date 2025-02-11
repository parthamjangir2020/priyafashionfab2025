import 'package:active_ecommerce_cms_demo_app/my_theme.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle buildAppBarTexStyle() {
    return TextStyle(
        fontSize: 16,
        color: MyTheme.dark_font_grey,
        fontWeight: FontWeight.w700);
  }

  static TextStyle largeTitleTexStyle() {
    return TextStyle(
        fontSize: 16,
        color: MyTheme.dark_font_grey,
        fontWeight: FontWeight.w700);
  }

  static TextStyle smallTitleTexStyle() {
    return TextStyle(
        fontSize: 13,
        color: MyTheme.dark_font_grey,
        fontWeight: FontWeight.w700);
  }

  static TextStyle verySmallTitleTexStyle() {
    return TextStyle(
        fontSize: 10,
        color: MyTheme.dark_font_grey,
        fontWeight: FontWeight.normal);
  }

  static TextStyle largeBoldAccentTexStyle() {
    return TextStyle(
        fontSize: 16, color: MyTheme.accent_color, fontWeight: FontWeight.w700);
  }

  static TextStyle smallBoldAccentTexStyle() {
    return TextStyle(
        fontSize: 13, color: MyTheme.accent_color, fontWeight: FontWeight.w700);
  }
}
