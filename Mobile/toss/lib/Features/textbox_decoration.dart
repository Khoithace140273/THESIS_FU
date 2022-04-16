import 'package:flutter/material.dart';

import 'color.dart';

bool _isObscure = true;

buildInputDecoration(
    IconData iconData, String hintText, Color focusColor, String label) {
  return InputDecoration(
    filled: true,
    fillColor: BackgroundTextFormField(),
    hintText: hintText,
    prefixIcon: Icon(iconData, color: focusColor),
    label: Text(label, style: TextStyle(color: ThemeColor(), fontSize: 15)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ThemeColor(), width: 1.5),
    ),
    // border: OutlineInputBorder(
    //   borderSide: BorderSide(
    //     color: Color(0xFF039D78),
    //     width: 1.5,
    //   ),
    // ),
    // enabledBorder: OutlineInputBorder(
    //   borderSide: BorderSide(
    //     color: Color(0xFF039D78),
    //     width: 1.5,
    //   ),
    // ),
  );
}

buildVerifyInputDecoration(Color focusColor) {
  return InputDecoration(
    filled: true,
    fillColor: BackgroundTextFormField(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ThemeColor(), width: 1.5),
    ),
    isCollapsed: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 12.7),
  );
}

buildVerifiedTextStyle() {
  return TextStyle(
      color: ThemeColor(), fontSize: 23, fontWeight: FontWeight.w500);
}

buildItemsOnScreenPadding() {
  return const EdgeInsets.only(bottom: 15, left: 40, right: 40);
}
