
import 'package:flutter/material.dart';
import 'package:flutterplayer/Widgets/colors.dart';

var lightTheme = ThemeData(
  useMaterial3: true,

  //  ❤️  Color style Define
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: backgroudColor,
    secondary: secondryColor,
    onSecondary: backgroudColor,
    error: Colors.red,
    onError: fontColor,
    background: backgroudColor,
    onBackground: fontColor,
    surface: backgroudColor,
    onSurface: fontColor,
    onPrimaryContainer: secondLebelColor,
  ),

  // ❤️  Text Style Define
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: "Poppins",
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontFamily: "Poppins",
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontFamily: "Poppins",
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontFamily: "Poppins",
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontFamily: "Poppins",
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: labelColor),
    labelMedium: TextStyle(
        fontFamily: "Poppins",
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: labelColor),
    labelSmall: TextStyle(
        fontFamily: "Poppins",
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: labelColor),
  ),
);



// const kPrimaryColor = Color(0xFFFF1031);
const kPrimaryColor = Colors.deepPurple;
const kWhite = Colors.white;
const kTextColor = Color(0xFF707070);
const kTextLightColor = Color(0xFF949098);

const kDefaultPadding = 25.0;