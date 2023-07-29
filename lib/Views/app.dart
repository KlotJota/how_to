import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/first_pages/first_page.dart';
import 'package:how_to/Views/profile/user_profile.dart';
import 'package:how_to/Views/settings/settings.dart';
import 'package:how_to/Views/temas/dark_mode.dart';
import 'package:how_to/Views/temas/light_mode.dart';
import 'login/user_login.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey:
          navigatorKey, // chave global de navegação, para que a navbar seja visivel apos o uso do Get.to()
      navigatorObservers: [GetObserver()],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Lexend'),
      //darkTheme: darkMode,
      getPages: [
        GetPage(name: '/settings', page: () => Settings()),
        GetPage(name: '/', page: () => FirstPage()),
        GetPage(name: '/userProfile', page: () => UserProfilePage()),
      ],
      routes: {
        '/first_page': (context) => FirstPage(),
        '/userProfile': (context) => UserProfilePage(),
      },
      home: UserLoginPage(),
    );
  }
}
