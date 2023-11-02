import 'package:flutter/material.dart';
import 'package:flutter_rickmorty_application/feature/domain/entities/character.dart';

class MyTheme {
  static const primaryTextColor = Color.fromARGB(255, 255, 255, 243);
  static const secondaryTextColor = Color.fromARGB(255, 158, 158, 158);
  static const scaffoldBackgroundColor = Color.fromARGB(255, 39, 43, 51);
  static const appBarBacgroundColor = Color.fromARGB(255, 32, 35, 41);
  static const cardColor = Color.fromARGB(255, 60, 62, 68);
  static const indicatorColor = Color.fromARGB(255, 68, 75, 89);
  static const thirdyTextColor = Color.fromARGB(255, 107, 107, 107);

  static const statusToColor = {
    Status.Alive: Colors.green,
    Status.Dead: Colors.red,
    Status.unknown: Colors.deepPurple,
  };

  static ThemeData darkTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: appBarBacgroundColor,
        elevation: 0.0,
      ),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      cardTheme: CardTheme(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 3.0,
        clipBehavior: Clip.antiAlias,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: indicatorColor,
      ),
    );
  }
}
