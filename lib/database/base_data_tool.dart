import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primarycolor = Color(0xFFCADCED);
List<Color> allcolors = [Color(0xFF94DFFF),Color.fromARGB(255, 161, 225, 253),Color.fromARGB(255, 174, 231, 255)];
List<BoxShadow> CustomShadow = [
  BoxShadow(
      color: Colors.blue[900]!.withOpacity(0.2),
      blurRadius: 50,
      spreadRadius: 2,
      offset: Offset(20, 0)),
  BoxShadow(
      color: Colors.white12,
      blurRadius: 0,
      spreadRadius: -2,
      offset: Offset(0, 0)),
];

ThemeData maintheme() {
  final base = ThemeData.light();
  final mainColor = Color(0xFF94DFFF);
  final iconColor = Colors.white;
  return base.copyWith(
    floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: Colors.white,backgroundColor: Color(0xFFf8b195)),
    inputDecorationTheme: InputDecorationTheme(labelStyle: TextStyle(color: Colors.white),border: InputBorder.none,fillColor:allcolors[1] ,hoverColor: allcolors[2]),
    textTheme: GoogleFonts.courgetteTextTheme(base.textTheme),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
    appBarTheme: AppBarTheme(
      
      titleTextStyle: TextStyle(
          color: Colors.white,
          
          fontWeight: FontWeight.bold,
          fontSize: 26),
      color: mainColor,
      iconTheme: IconThemeData(color: iconColor),
    ),
    colorScheme: ColorScheme.light(
      primary: mainColor,
      onPrimary: iconColor,
    ),
    iconTheme: IconThemeData(
      color: iconColor,
    ),
  );
}
