import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';

import '../../changeProfile/changeProfile_page.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => ProfileInfoState();
}

class ProfileInfoState extends State<ProfileInfo> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

  @override
  void dispose() {
    ttsService.dispose(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 10),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(auth.currentUser!.photoURL.toString()),
                radius: 50,
              )),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              child: auth.currentUser!.displayName == null
                  ? GestureDetector(
                      onTap: () {
                        if (isAccessibilityEnabled) {
                          ttsService.speak('Usuario anonimo');
                          HapticFeedback.heavyImpact();
                        }
                      },
                      child: const Text(
                        'Usuário',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (isAccessibilityEnabled) {
                          ttsService.speak(
                            auth.currentUser!.displayName.toString(),
                          );
                          HapticFeedback.heavyImpact();
                        }
                      },
                      child: Text(
                        auth.currentUser!.displayName.toString(),
                        style: TextStyle(
                            fontSize: isAccessibilityEnabled ? 28 : 18),
                      ),
                    )),
          GestureDetector(
            onDoubleTap: () {
              if (isAccessibilityEnabled) {
                Get.to(() => ChangeProfilePage());
                HapticFeedback.heavyImpact();
              }
            },
            onTap: () {
              HapticFeedback.heavyImpact();
              isAccessibilityEnabled
                  ? ttsService
                      .speak('Dê um duplo clique para alterar seu Perfil')
                  : Get.to(() => ChangeProfilePage());
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
              ),
              child: Text(
                'Alterar perfil',
                style: TextStyle(fontSize: isAccessibilityEnabled ? 20 : 14),
              ),
            ),
          )
        ],
      ),
    );
  }
}
