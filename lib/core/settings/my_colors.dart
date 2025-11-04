import 'package:flutter/material.dart';

class MyColors {
  static final red = const Color.fromARGB(255, 220, 40, 110);
  static final blue = const Color.fromARGB(255, 0, 133, 255);
  
  static final primaryBlue = const Color.fromARGB(255, 44, 232, 245);
  static final secondaryBlue = const Color.fromARGB(255, 22, 103, 107);

  static final iconGradient = LinearGradient(
    colors: <Color>[
      red,
      blue
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
