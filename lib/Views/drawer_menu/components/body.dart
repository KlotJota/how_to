import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:how_to/Themes/themes_service.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/changeProfile/changeProfile_page.dart';
import 'package:how_to/Views/drawer_menu/components/profile_data.dart';

import '../../face_detector/face_detector_page.dart';
import '../../login/user_login.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

  @override
  void dispose() {
    ttsService.dispose(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  void readOptions(int index) async {
    List<String> titles = [
      "Configurações",
      "Alterar tema",
      "Alterar perfil",
      "Sair"
    ];

    await ttsService.speak(titles[index]);
  }

  void logOut(BuildContext context) async {
    try {
      await auth.signOut();
      Get.offAll(const UserLoginPage());
    } catch (e) {
      print(e);
    }
  }

  void _popUpLogout(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 10,
          titlePadding: const EdgeInsets.all(5),
          title: const Text('Sair'),
          backgroundColor: const Color.fromARGB(255, 240, 240, 240),
          content: const Text('Você realmente deseja sair do aplicativo?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: 30,
                    width: 80,
                    child: const Text(
                      'Não',
                      style: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => logOut(context),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 9, 89, 1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.only(top: 5),
                    height: 30,
                    width: 80,
                    child: const Text(
                      'Sim',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfileData(),
            InkWell(
              onDoubleTap: () {
                isAccessibilityEnabled ? Get.toNamed('/settings') : null;
              },
              onTap: () {
                isAccessibilityEnabled
                    ? readOptions(0)
                    : Get.toNamed('/settings');
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(Icons.settings, size: 30),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Configurações",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 10, thickness: 1),
            InkWell(
              onDoubleTap: () {
                isAccessibilityEnabled
                    ? ThemeService().changeThemeMode()
                    : null;
              },
              onTap: () {
                isAccessibilityEnabled
                    ? readOptions(1)
                    : ThemeService().changeThemeMode();
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(Icons.settings, size: 30),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Alterar tema",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 10, thickness: 1),
            auth.currentUser!.isAnonymous
                ? Container()
                : InkWell(
                    onDoubleTap: () {
                      isAccessibilityEnabled
                          ? Get.to(() => ChangeProfilePage())
                          : null;
                    },
                    onTap: () {
                      isAccessibilityEnabled
                          ? readOptions(2)
                          : Get.to(() => ChangeProfilePage());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(Icons.edit, size: 30),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Alterar perfil",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            auth.currentUser!.isAnonymous
                ? Container()
                : const Divider(height: 10, thickness: 1),
            InkWell(
              onDoubleTap: () {
                isAccessibilityEnabled ? _popUpLogout(context) : null;
              },
              onTap: () {
                isAccessibilityEnabled ? readOptions(3) : _popUpLogout(context);
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(Icons.logout, size: 30),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Sair",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
