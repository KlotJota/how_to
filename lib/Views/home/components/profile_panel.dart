import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';

import '../../register/user-register.dart';
import 'package:get/get.dart';

class ProfilePanel extends StatefulWidget {
  const ProfilePanel({super.key});

  @override
  State<ProfilePanel> createState() => _ProfilePanelState();
}

class _ProfilePanelState extends State<ProfilePanel> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String user =
      'https://firebasestorage.googleapis.com/v0/b/howto-60459.appspot.com/o/perfis%2Fpadr%C3%A3o%2Fuser.png?alt=media&token=bb4a0f5c-8839-400d-8fb3-dbaaf07b3117';

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

  @override
  void dispose() {
    ttsService.dispose(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  void popUpRegister() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: const EdgeInsets.all(5),
            title: const Text('Criar conta'),
            backgroundColor: const Color.fromARGB(255, 250, 247, 247),
            content: GestureDetector(
              onTap: () {
                if (isAccessibilityEnabled) {
                  ttsService.speak(
                      'Você pode criar uma conta para ter acesso a sua página de perfil');
                  HapticFeedback.heavyImpact();
                }
              },
              child: const Text(
                'Você pode criar uma conta para ter acesso a sua página de perfil',
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      if (isAccessibilityEnabled) {
                        Get.back();
                        HapticFeedback.heavyImpact();
                      }
                    },
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      isAccessibilityEnabled
                          ? ttsService.speak('Fechar')
                          : Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 80,
                      child: const Text(
                        'Fechar',
                        style: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      if (isAccessibilityEnabled) {
                        Get.to(() => const UserRegisterPage());
                        HapticFeedback.heavyImpact();
                      }
                    },
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      isAccessibilityEnabled
                          ? ttsService.speak('Criar conta')
                          : Get.to(() => const UserRegisterPage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 85,
                      child: const Text(
                        'Criar conta',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        if (isAccessibilityEnabled && auth.currentUser!.displayName == null) {
          popUpRegister();
        }
      },
      onTap: () {
        if (auth.currentUser!.isAnonymous) {
          HapticFeedback.heavyImpact();
          isAccessibilityEnabled
              ? ttsService.speak(
                  'Seja bem vindo! Dê um duplo clique para criar uma conta')
              : popUpRegister();
        } else {
          if (isAccessibilityEnabled) {
            ttsService.speak(
                'Seja bem vindo' + auth.currentUser!.displayName.toString());
            HapticFeedback.heavyImpact();
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: auth.currentUser!.photoURL == null
                        ? CircleAvatar(backgroundImage: NetworkImage(user))
                        : CircleAvatar(
                            backgroundImage: NetworkImage(
                                auth.currentUser!.photoURL.toString()),
                          )),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, bottom: 2),
                        child: const Text(
                          'Bem vindo!',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: auth.currentUser!.isAnonymous
                              ? const Text('Usuário')
                              : Text(auth.currentUser!.displayName.toString(),
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ))),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
