import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/profile/components/favorites.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> favoritos = [];

  FirebaseAuth auth = FirebaseAuth.instance;

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

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Favorites()));
  }
}
