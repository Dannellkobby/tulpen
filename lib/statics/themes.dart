import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tulpen/statics/colours.dart';

class Themes {
  Themes._();

  static String prokyon = "DTLProkyonST";

  static TextTheme quickSand = GoogleFonts.quicksandTextTheme();
  static TextTheme numans = GoogleFonts.numansTextTheme();
  static final TextTheme lightText = TextTheme(
    headline1: quickSand.headline1?.copyWith(fontWeight: FontWeight.bold, color: Colours.dark),
    headline2: quickSand.headline2?.copyWith(fontWeight: FontWeight.bold, color: Colours.dark),
    headline3: quickSand.headline3?.copyWith(fontWeight: FontWeight.bold, color: Colours.dark),
    headline4: quickSand.headline4?.copyWith(fontWeight: FontWeight.bold, color: Colours.dark),
    headline5: quickSand.headline5?.copyWith(fontWeight: FontWeight.bold, color: Colours.dark),
    headline6: quickSand.headline6?.copyWith(fontWeight: FontWeight.bold, color: Colours.dark, letterSpacing: 1),
    bodyText1: quickSand.bodyText1?.copyWith(color: Colors.grey.shade800),
    bodyText2: numans.bodyText2?.copyWith(color: Colors.grey.shade700),
    subtitle1: quickSand.subtitle1?.copyWith(color: Colors.grey.shade800, fontWeight: FontWeight.bold),
    subtitle2: numans.subtitle2?.copyWith(color: Colors.grey.shade700),
    button: quickSand.button!.copyWith(color: Colors.white),
    caption: numans.caption?.copyWith(fontSize: 12, letterSpacing: -0.5, color: Colors.grey),
    overline: numans.overline,
  );
  static final ThemeData light = ThemeData.light().copyWith(
    textTheme: lightText,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      // color: Colours.green,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colours.dark),
      textTheme: lightText,
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red, accentColor: Colors.orange),
    dividerColor: Colours.light,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,

    /*
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100)))),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 24)),
            elevation: MaterialStateProperty.all(4))),
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        // buttonColor: Colours.orangeAccent,
        textTheme: ButtonTextTheme.primary),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),

    colorScheme: ColorScheme.light(
      primary: primaryColor,
      primaryVariant: primaryColor1,
      secondary: primaryColor0,
    ),
    iconTheme: IconThemeData(
      color: Colours.DARK2,
    ),
    popupMenuTheme: PopupMenuThemeData(color: Colours.WHITE),
    unselectedWidgetColor: primaryColor,
 */
  );
}
