import 'package:flutter/material.dart';
import 'package:playremusica/core/settings/my_colors.dart';

final appThemeData = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.copyWith(),
    bottomNavigationBarTheme: ThemeData.dark().bottomNavigationBarTheme.copyWith(
      selectedItemColor: Colors.white, 
      unselectedItemColor: Colors.green,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold
      ),
      // unselectedLabelStyle: TextStyle(
      //   color: MyColors.secondaryBlue,
      // ),
    )
  );
