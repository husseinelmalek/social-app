
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/shared/styles/colors.dart';

ThemeData darkTheme= ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  //floatingActionButtonTheme: FloatingActionButtonThemeData(
  // backgroundColor: Colors.deepOrange,
  //),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,

    ),
    backgroundColor:HexColor('333739'),
    elevation: 0.0,

  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
    elevation: 20.0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,

    ),
    subtitle1:  TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,

    ),
  ),
);


ThemeData lightTheme= ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  //floatingActionButtonTheme: FloatingActionButtonThemeData(
    //backgroundColor: Colors.deepOrange,
  //),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    backwardsCompatibility: false,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.light,

    ),
    backgroundColor: Colors.white,
    elevation: 0.0,

  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,

  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    subtitle1:  TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,

    ),
  ),
);