import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatefulWidget {
  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class QuantiaFavoritos {
  static final QuantiaFavoritos quantiaFavoritos = QuantiaFavoritos._internal();

  String? quantia;

  factory QuantiaFavoritos() {
    return quantiaFavoritos;
  }

  QuantiaFavoritos._internal();
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

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Tutoriais Salvos',
                      style: TextStyle(fontSize: 25),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: favoritos.length == 0
                      ? Text('0', style: TextStyle(fontSize: 23))
                      : Text(
                          QuantiaFavoritos.quantiaFavoritos.quantia.toString(),
                          style: TextStyle(fontSize: 23)),
                )
              ]))
        ],
      ),
    );
  }
}
