import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key});

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> favoritos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarFavorito();
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
                child: const Text(
                  'Tutoriais Salvos',
                  style: TextStyle(fontSize: 20),
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
