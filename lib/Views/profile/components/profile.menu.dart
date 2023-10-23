import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key});

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> favoritos = [];

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarFavorito();
  }

  @override
  void dispose() {
    ttsService.dispose(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  void buscarFavorito() async {
    final tutorialDoc = await FirebaseFirestore.instance
        .collection('favoritos')
        .doc(auth.currentUser!.uid)
        .get();

    if (tutorialDoc.exists) {
      List<dynamic> favoritosDocument = tutorialDoc.data()?['Favoritos'] ?? [];
      favoritos =
          favoritosDocument.map((favorito) => favorito.toString()).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Column(children: [
            Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    if (isAccessibilityEnabled) {
                      ttsService.speak('Tutoriais Salvos');
                      HapticFeedback.heavyImpact();
                    }
                  },
                  child: Text(
                    'Tutoriais Salvos',
                    style:
                        TextStyle(fontSize: isAccessibilityEnabled ? 28 : 18),
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Icon(Icons.list_alt))
          ]))
        ],
      ),
    );
  }
}
