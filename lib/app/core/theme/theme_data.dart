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
    textTheme: textTheme
  );
}

ThemeData darkThemeData() {
  return ThemeData.dark();
}