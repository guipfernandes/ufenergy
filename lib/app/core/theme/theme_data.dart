import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightThemeData() {
  const Color primaryColor = Color(0xFF6AB4F7);
  const Color secondaryColor = Color(0xFFFDD82E);
  const Color backgroundColor = Color(0xFFFEFEFE);
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    primaryVariant: Color(0xFF0E8BCE),
    secondary: secondaryColor,
    secondaryVariant: Color(0xFFEEC233),
  );

  final TextTheme textTheme = TextTheme(
    headline6: GoogleFonts.josefinSans(
      color: primaryColor,
      fontSize: 22.0,
      fontWeight: FontWeight.bold
    ),
    subtitle1: GoogleFonts.josefinSans(
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
    ),
    subtitle2: GoogleFonts.josefinSans(
      color: Colors.grey,
      fontSize: 15.0,
    ),
    bodyText2: GoogleFonts.josefinSans(
      color: Colors.black54,
      fontSize: 14.0,
    ),
    bodyText1: GoogleFonts.josefinSans(
      color: Colors.black87,
      fontSize: 14.0,
    ),
  );

  return ThemeData.light().copyWith(
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    backgroundColor: backgroundColor,
    colorScheme: colorScheme,
    iconTheme: IconThemeData(
      color: primaryColor
    ),
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      backwardsCompatibility: false,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: textTheme.headline6,
    ),
    textTheme: textTheme,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.roboto(color: Colors.black38, fontSize: 16.0),
      hintStyle: GoogleFonts.roboto(color: Colors.grey.withOpacity(0.7), fontSize: 16.0),
      helperStyle: GoogleFonts.roboto(color: Colors.grey.withOpacity(0.7), fontSize: 12.0),
      border: InputBorder.none,
      alignLabelWithHint: true,
      filled: false,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide(color: Colors.black26),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide(color: Colors.black26),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    ),
  );
}

ThemeData darkThemeData() {
  return ThemeData.dark();
}