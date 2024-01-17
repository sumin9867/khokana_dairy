import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "Poppins");
  }

  static TextStyle whiteboldTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Colors.white,
        fontFamily: "Poppins");
  }

  static TextStyle headerTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold, fontSize: 24, fontFamily: "Poppins");
  }

  static TextStyle LightTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: "Poppins",
        color: Colors.black38);
  }

  static TextStyle SemiBoldTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 17,
      fontFamily: "Poppins",
    );
  }
}
