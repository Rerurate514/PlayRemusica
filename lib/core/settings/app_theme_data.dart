import 'package:flutter/material.dart';

final appThemeData = ThemeData.dark().copyWith(
  textTheme: ThemeData.dark().textTheme.copyWith(),
  bottomNavigationBarTheme: ThemeData.dark().bottomNavigationBarTheme.copyWith(
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
    // unselectedLabelStyle: TextStyle(
    //   color: MyColors.secondaryBlue,
    // ),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: Colors.purpleAccent.shade100,
    inactiveTrackColor: Colors.white12,
    thumbColor: Colors.white,
    overlayColor: Colors.transparent,
    trackHeight: 3.0,
  ),
);
