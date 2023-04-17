import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:how_to/Views/first-page.dart';
import 'package:how_to/Views/user-login.dart';
import 'package:how_to/Views/user-register.dart';
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
      },
      home: FirstPage(),
    );
  }
}
