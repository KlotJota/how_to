import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/first_pages/first_page.dart';
import 'package:how_to/Views/profile/user_profile.dart';
import 'package:how_to/Views/settings/settings.dart';
import 'login/user_login.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  App({super.key});
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
        GetPage(name: '/settings', page: () => const Settings()),
        GetPage(name: '/', page: () => const FirstPage()),
        GetPage(name: '/userProfile', page: () => const UserProfilePage()),
      ],
      routes: {
        '/first_page': (context) => const FirstPage(),
        '/userProfile': (context) => const UserProfilePage(),
      },
      home: const UserLoginPage(),
    );
  }
}
