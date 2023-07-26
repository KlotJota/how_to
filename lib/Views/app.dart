import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/first_pages/first_page.dart';
import 'package:how_to/Views/first_pages/first_page_anonymous.dart';
import 'package:how_to/Views/settings/settings.dart';
import 'package:how_to/Views/temas/dark_mode.dart';
import 'package:how_to/Views/temas/light_mode.dart';
import 'login/user_login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Lexend'),
      //darkTheme: darkMode,
      getPages: [
        GetPage(name: '/settings', page: () => Settings()),
      ],
      routes: {
        '/first_page': (context) => FirstPage(),
        '/first_page_anonymous': (context) => FirstPageAnonymous(),
      },
      home: UserLoginPage(),
    );
  }
}
