import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

ColorScheme kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181)
  );
  var kDarkColorScheme =ColorScheme.fromSeed(brightness: Brightness.dark, 
  seedColor: const Color.fromARGB(255, 5, 99, 125),);
void main() {
  runApp( MaterialApp(
    theme: ThemeData(
   textTheme:  ThemeData().textTheme.copyWith(
      titleLarge: TextStyle(
        fontWeight: FontWeight.normal,
        color: kColorScheme.onSecondaryContainer,
        fontSize: 20,
      ),
    ),
  
      colorScheme: kColorScheme,
     appBarTheme: AppBarTheme(
      backgroundColor: kColorScheme.onPrimaryContainer,
    foregroundColor: kColorScheme.primaryContainer,
    ),
    cardTheme: CardThemeData(
      color: kColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.primaryContainer,
        ),
    ),
    ),
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kColorScheme,
    cardTheme: CardThemeData(
      color: kDarkColorScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kDarkColorScheme.onPrimaryContainer,
        foregroundColor: kDarkColorScheme.primaryContainer,
        ),
    ),
    ),
      themeMode: ThemeMode.system,
    home: Expenses()
  ),
  );
}