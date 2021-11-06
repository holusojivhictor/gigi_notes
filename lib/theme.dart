import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    textTheme: textTheme(context),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(secondary: kSecondary),
  );
}

TextTheme textTheme(BuildContext context) {
  return GoogleFonts.latoTextTheme(Theme.of(context).textTheme);
}

class GigiNotesTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.lato(
      fontSize: 14.0,
      fontWeight:FontWeight.w700,
      color: kTextDark,
    ),
    bodyText2: GoogleFonts.lato(
      fontSize: 14.0,
      fontWeight:FontWeight.normal,
      color: kTextDark,
    ),
    headline1: GoogleFonts.lato(
      fontSize: 28.0,
      fontWeight:FontWeight.bold,
      color: kTextDark,
    ),
    headline2: GoogleFonts.lato(
      fontSize: 18.0,
      fontWeight:FontWeight.w700,
      color: kTextDark,
    ),
    headline3: GoogleFonts.lato(
      fontSize: 14.0,
      fontWeight:FontWeight.w600,
      color: kTextDark,
    ),
    headline6: GoogleFonts.lato(
      fontSize: 20.0,
      fontWeight:FontWeight.normal,
      color: kTextDark,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.lato(
      fontSize: 14.0,
      fontWeight:FontWeight.w700,
      color: kTextLight,
    ),
    bodyText2: GoogleFonts.lato(
      fontSize: 14.0,
      fontWeight:FontWeight.normal,
      color: kTextLight,
    ),
    headline1: GoogleFonts.lato(
      fontSize: 28.0,
      fontWeight:FontWeight.bold,
      color: kTextLight,
    ),
    headline2: GoogleFonts.lato(
      fontSize: 18.0,
      fontWeight:FontWeight.w700,
      color: kTextLight,
    ),
    headline3: GoogleFonts.lato(
      fontSize: 14.0,
      fontWeight:FontWeight.w600,
      color: kTextLight,
    ),
    headline6: GoogleFonts.lato(
      fontSize: 20.0,
      fontWeight:FontWeight.normal,
      color: kTextLight,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      cardColor: Colors.white,
      shadowColor: Colors.black,
      indicatorColor: Colors.black,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        titleTextStyle: lightTextTheme.headline2,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      textTheme: lightTextTheme,
    );
  }
  static ThemeData dark() {
    return ThemeData(
      cardColor: Colors.grey.shade900,
      shadowColor: Colors.black,
      indicatorColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black38,
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.indigo),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black45,
        titleTextStyle: darkTextTheme.headline2,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      textTheme: darkTextTheme,
    );
  }
}