import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.black)
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20,
      backgroundColor: Colors.white
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)
  ),
  fontFamily: 'Tajawal',
);

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: const Color.fromRGBO(39, 38, 39, 1),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(39, 38, 39, 1),
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(39, 38, 39, 1), statusBarIconBrightness: Brightness.light),
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    iconTheme: IconThemeData(color: Colors.white)
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20,
      backgroundColor: const Color.fromRGBO(39, 38, 39, 1)
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white, fontSize: 18)
  ),
  fontFamily: 'Tajawal',
);