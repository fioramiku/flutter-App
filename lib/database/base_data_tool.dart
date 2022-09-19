import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primarycolor = const Color(0xFFCADCED);
List<Color> allcolors = const [
  Color(0xFF94DFFF),
  Color.fromARGB(255, 161, 225, 253),
  Color.fromARGB(255, 174, 231, 255)
];
List<BoxShadow> CustomShadow = [
  BoxShadow(
      color: Colors.blue[900]!.withOpacity(0.2),
      blurRadius: 50,
      spreadRadius: 2,
      offset: const Offset(20, 0)),
  const BoxShadow(
      color: Colors.white12,
      blurRadius: 0,
      spreadRadius: -2,
      offset: Offset(0, 0)),
];
ThemeData darkTheme() {
  var base = ThemeData.dark();
  return base.copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle( shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      
      borderRadius: BorderRadius.circular(18.0),
      
    )))),
    textTheme: GoogleFonts.robotoSlabTextTheme(base.textTheme),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(selectedItemColor: Colors.white));
}

ThemeData maintheme() {
  var base = ThemeData.light();
  const mainColor = Color(0xFF94DFFF);
  const iconColor = Colors.white;
  return base.copyWith(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white, backgroundColor: Color(0xFFf8b195)),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: Colors.white),
        border: InputBorder.none,
        fillColor: allcolors[1],
        hoverColor: allcolors[2]),
    textTheme: GoogleFonts.courgetteTextTheme().copyWith(),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
          color: iconColor, fontWeight: FontWeight.bold, fontSize: 26),
      color: mainColor,
      iconTheme: IconThemeData(color: iconColor),
    ),
    colorScheme: const ColorScheme.light(
      primary: mainColor,
      onPrimary: iconColor,
    ),
    iconTheme: const IconThemeData(
      color: iconColor,
    ),
  );
}
