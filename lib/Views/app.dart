import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/first_pages/first_page.dart';
import 'package:how_to/Views/first_pages/first_page_anonymous.dart';
import 'login/user_login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Lexend'),
      routes: {
        '/first_page': (context) => FirstPage(),
        '/first_page_anonymous': (context) => FirstPageAnonymous(),
      },
      home: UserLoginPage(),
    );
  }
}
