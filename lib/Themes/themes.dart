import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
      primaryColor: const Color.fromARGB(255, 250, 247, 247),
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Color.fromARGB(255, 27, 27, 27)),
          actionsIconTheme:
              IconThemeData(color: Color.fromARGB(255, 27, 27, 27)),
          color: Color.fromARGB(255, 250, 250, 250),
          titleTextStyle: TextStyle(color: Color.fromARGB(255, 27, 27, 27))),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 250, 247, 247),
        selectedItemColor: Color.fromRGBO(0, 9, 89, 1),
        unselectedItemColor: Color.fromRGBO(68, 72, 109, 1),
      ));
  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: const Color.fromARGB(255, 27, 27, 27),
    drawerTheme: DrawerThemeData(
      backgroundColor: Color.fromARGB(255, 48, 48, 48),
    ),
    appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 48, 48, 48),
        titleTextStyle: TextStyle(color: Color.fromARGB(255, 250, 247, 247))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 250, 247, 247),
      selectedItemColor: Color.fromARGB(255, 243, 243, 243),
      unselectedItemColor: Color.fromARGB(255, 250, 247, 247),
    ),
  );
}
