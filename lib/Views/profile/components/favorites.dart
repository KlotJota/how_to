import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/profile/components/profile.menu.dart';
import 'package:how_to/Views/profile/components/profile_info.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/tutorial_page/tutorial-page.dart';
import 'package:how_to/Views/profile/components/empty_favorites.dart';

class Favorites extends StatefulWidget {
  @override
  State<Favorites> createState() => _FavoritesFunctionState();
}

class _FavoritesFunctionState extends State<Favorites> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> favoritos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarFavorito();
  }

  void removerFavorito(String tutorialId) async {
    // Remove o tutorial da lista de favoritos
    favoritos.removeWhere((favorito) => favorito == tutorialId);

    // Atualiza a coleção "favoritos" no Firestore
    await FirebaseFirestore.instance
        .collection('favoritos')
        .doc(auth.currentUser!.uid)
        .update({'Favoritos': favoritos});

    // Atualiza o estado para refletir a remoção do tutorial
    setState(() {
      favoritos.length;
    });
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
    return Scaffold(
        body: favoritos.isEmpty
            ? EmptyFavorites()
            : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: firestore
                    .collection('tutoriais')
                    .where(FieldPath.documentId, whereIn: favoritos)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // senao tiver dados
                    return CircularProgressIndicator(); // circulo de carregando
                  }

                  var favoritos = snapshot.data!.docs;

                  return Stack(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  scale: 19,
                                  alignment: Alignment.topCenter,
                                  image:
                                      AssetImage('images/how-to-branco.png'))),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 9, 89, 1),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      Positioned(
                          top: 70,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 8,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ], color: Color.fromARGB(255, 243, 243, 243)),
                              child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    Card(
                                      shadowColor: Colors.black,
                                      margin:
                                          EdgeInsets.fromLTRB(15, 10, 15, 0),
                                      color: Color.fromARGB(255, 250, 247, 247),
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          ProfileInfo(),
                                          ProfileMenu()
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GridView(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 3,
                                          mainAxisSpacing: 12,
                                          mainAxisExtent: 130,
                                        ),
                                        children: favoritos
                                            .map((favorito) => GestureDetector(
                                                  onTap: () => Get.to(
                                                      TutorialPage(
                                                          favorito.id)),
                                                  child: Card(
                                                    elevation: 5,
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5))),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  elevation: 10,
                                                                  titlePadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  title: Text(
                                                                      'Remover favorito'),
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          250,
                                                                          247,
                                                                          247),
                                                                  content: Text(
                                                                      'Deseja realmente remover o tutorial dos favoritos?'),
                                                                  actions: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap: () =>
                                                                              Get.back(),
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.only(top: 5),
                                                                            height:
                                                                                30,
                                                                            width:
                                                                                80,
                                                                            child:
                                                                                Text(
                                                                              'Não',
                                                                              style: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            await Future.delayed(Duration.zero).then((_) =>
                                                                                removerFavorito(favorito.id));

                                                                            FirebaseFirestore.instance.collection('tutoriais').doc(favorito!.id).update({
                                                                              "qtdFavoritos": FieldValue.increment(-1),
                                                                            });

                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: Color.fromRGBO(0, 9, 89, 1), borderRadius: BorderRadius.circular(5)),
                                                                            padding:
                                                                                EdgeInsets.only(top: 5),
                                                                            height:
                                                                                30,
                                                                            width:
                                                                                80,
                                                                            child:
                                                                                Text(
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
                                                              });
                                                        },
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        137,
                                                                        255,
                                                                        0,
                                                                        0),
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5))),
                                                            height: 30,
                                                            width: 30,
                                                            child: Icon(
                                                              Icons
                                                                  .close_rounded,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 5,
                                                            blurRadius: 10,
                                                            offset: Offset(0,
                                                                2), // changes position of shadow
                                                          ),
                                                        ],
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                favorito[
                                                                    'imagem']),
                                                            fit: BoxFit.cover,
                                                            alignment: Alignment
                                                                .bottomCenter),
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ]))),
                      Container(height: 120)
                    ],
                  );
                }));
  }
}
