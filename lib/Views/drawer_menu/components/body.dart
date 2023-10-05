import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:how_to/Themes/themes_service.dart';
import 'package:how_to/Views/changeProfile/changeProfile_page.dart';
import 'package:how_to/Views/drawer_menu/components/profile_data.dart';

import '../../login/user_login.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final FlutterTts flutterTts = FlutterTts();
  bool isReadingSettings = false;
  bool isReadingTheme = false;
  bool isReadingLogout = false;
  bool isReadingChangeProfile = false;

  Future<void> initializeTts() async {
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(1.0);
  }

  @override
  void initState() {
    super.initState();
    initializeTts();

    // Configurar o completionHandler para detectar quando a leitura é concluída
    flutterTts.setCompletionHandler(() {
      setState(() {
        isReadingSettings =
            false; // Definir como false quando a leitura for concluída
        isReadingTheme = false;
        isReadingLogout = false;
        isReadingChangeProfile = false;
      });
    });
  }

  @override
  void dispose() {
    flutterTts.stop(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  void readOptions(int index) async {
    List<String> titles = [
      "Configurações",
      "Alterar tema",
      "Alterar perfil",
      "Sair"
    ];

    await flutterTts.speak(titles[index]);

    setState(() {
      if (index == 0) {
        isReadingSettings = true;
      } else if (index == 1) {
        isReadingTheme = true;
      } else if (index == 2) {
        isReadingChangeProfile = true;
      } else if (index == 3) {
        isReadingLogout = true;
      }
    });
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
              onTap: () {
                Get.toNamed('/settings');
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
                    GestureDetector(
                      onTap: () {
                        if (!isReadingSettings) {
                          readOptions(0);
                        } else {
                          flutterTts.stop();
                        }
                        setState(() {
                          isReadingSettings = !isReadingSettings;
                        });
                      },
                      child: Icon(
                        isReadingSettings
                            ? Icons.mic
                            : Icons.mic_none, // Mude o ícone diretamente aqui
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 10, thickness: 1),
            InkWell(
              onTap: () {
                ThemeService().changeThemeMode();
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
                    GestureDetector(
                      onTap: () {
                        if (!isReadingTheme) {
                          readOptions(1);
                        } else {
                          flutterTts.stop();
                        }
                        setState(() {
                          isReadingTheme = !isReadingTheme;
                        });
                      },
                      child: Container(
                        child: isReadingTheme
                            ? Icon(Icons.mic)
                            : Icon(Icons
                                .mic_none), // Mude o ícone diretamente aqui
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
                    onTap: () {
                      Get.to(() => ChangeProfilePage());
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
                          GestureDetector(
                            onTap: () {
                              if (!isReadingChangeProfile) {
                                readOptions(2);
                              } else {
                                flutterTts.stop();
                              }
                              setState(() {
                                isReadingChangeProfile =
                                    !isReadingChangeProfile;
                              });
                            },
                            child: Icon(
                              isReadingChangeProfile
                                  ? Icons.mic
                                  : Icons
                                      .mic_none, // Mude o ícone diretamente aqui
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
              onTap: () => _popUpLogout(context),
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
                    GestureDetector(
                      onTap: () {
                        if (!isReadingLogout) {
                          readOptions(3);
                        } else {
                          flutterTts.stop();
                        }
                        setState(() {
                          isReadingLogout = !isReadingLogout;
                        });
                      },
                      child: Container(
                        child: isReadingLogout
                            ? Icon(Icons.mic)
                            : Icon(Icons.mic_none),
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
