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
    headline4: GoogleFonts.lato(
      fontSize: 16.0,
      fontWeight:FontWeight.w500,
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
    headline4: GoogleFonts.lato(
      fontSize: 17.0,
      fontWeight:FontWeight.w500,
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
      chipTheme: ChipThemeData(
        side: const BorderSide(color: Colors.black),
        backgroundColor: Colors.white,
        disabledColor: Colors.white,
        selectedColor: Colors.black,
        secondarySelectedColor: Colors.grey,
        padding: const EdgeInsets.only(left: 10, right: 10),
        labelStyle: GoogleFonts.lato(fontSize: 11.0, fontWeight:FontWeight.normal, color: kTextDark),
        secondaryLabelStyle: GoogleFonts.lato(fontSize: 10.0, fontWeight:FontWeight.normal, color: kTextDark),
        brightness: Brightness.light,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      dividerColor: Colors.black38,
      bottomAppBarColor: Colors.black,
      splashColor: Colors.grey,
      canvasColor: Colors.grey[50],
      cardColor: Colors.white,
      shadowColor: Colors.black,
      indicatorColor: Colors.black,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
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
      chipTheme: ChipThemeData(
        side: const BorderSide(color: Colors.white),
        backgroundColor: Colors.black,
        disabledColor: Colors.black,
        selectedColor: Colors.white,
        secondarySelectedColor: Colors.grey,
        padding: const EdgeInsets.only(left: 10, right: 10),
        labelStyle: GoogleFonts.lato(fontSize: 11.0, fontWeight:FontWeight.normal, color: kTextLight),
        secondaryLabelStyle: GoogleFonts.lato(fontSize: 10.0, fontWeight:FontWeight.normal, color: kTextLight),
        brightness: Brightness.dark,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      dividerColor: Colors.white38,
      bottomAppBarColor: Colors.white,
      splashColor: Colors.grey,
      canvasColor: Colors.black54,
      cardColor: Colors.grey.shade900,
      shadowColor: Colors.black,
      indicatorColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black38,
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
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