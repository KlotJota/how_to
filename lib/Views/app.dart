import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:how_to/Views/createTutorial-page.dart';
import 'package:how_to/Views/home.dart';
import 'package:how_to/Views/tutorial-page.dart';
import 'package:how_to/Views/user-login.dart';
import 'package:how_to/Views/user-profile.dart';
import 'package:how_to/Views/user-register.dart';
import 'package:how_to/Views/search-page.dart';
import 'package:how_to/Views/tutorial-page.dart';
import 'package:how_to/Views/createTutorial-page.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Lexend'),
      routes: {
        '/user_login': (context) => UserLoginPage(),
        '/user_register': (context) => UserRegisterPage(),
        '/home': (context) => HomePage(),
        '/search_page': (context) => SearchPage(),
        '/user_profile': (context) => UserProfilePage(),
        '/tutorial_page': (context) => TutorialPage(),
        '/create_tutorial': (context) => CreateTutorialPage(),
      },
      home: UserLoginPage(),
    );
  }
}
