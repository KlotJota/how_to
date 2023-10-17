import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/profile/components/profile.menu.dart';
import 'package:how_to/Views/profile/components/profile_info.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/tutorial_page/tutorial-page.dart';
import 'package:how_to/Views/profile/components/empty_favorites.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesFunctionState();
}

class _FavoritesFunctionState extends State<Favorites> {
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
            ? const EmptyFavorites()
            : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: firestore
                    .collection('tutoriais')
                    .where(FieldPath.documentId, whereIn: favoritos)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // senao tiver dados
                    return const CircularProgressIndicator(); // circulo de carregando
                  }

                  var favoritos = snapshot.data!.docs;

                  return SingleChildScrollView(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              const Card(
                                margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                                elevation: 5,
                                child: Column(
                                  children: [ProfileInfo(), ProfileMenu()],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GridView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 3,
                                    mainAxisSpacing: 12,
                                    mainAxisExtent: 120,
                                  ),
                                  children: favoritos
                                      .map((favorito) => GestureDetector(
                                            onDoubleTap: () {
                                              isAccessibilityEnabled
                                                  ? Get.to(
                                                      TutorialPage(favorito.id))
                                                  : null;
                                            },
                                            onTap: () {
                                              isAccessibilityEnabled
                                                  ? ttsService
                                                      .speak(favorito['titulo'])
                                                  : Get.to(TutorialPage(
                                                      favorito.id));
                                            },
                                            child: Card(
                                              elevation: 3,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5))),
                                              child: Container(
                                                alignment:
                                                    Alignment.bottomRight,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          favorito['imagem']),
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment
                                                          .bottomCenter),
                                                ),
                                                child: GestureDetector(
                                                  onDoubleTap: () {
                                                    if (isAccessibilityEnabled) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              elevation: 10,
                                                              titlePadding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              title: const Text(
                                                                  'Remover favorito'),
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      250,
                                                                      247,
                                                                      247),
                                                              content: const Text(
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
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                5),
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            80,
                                                                        child:
                                                                            const Text(
                                                                          'Não',
                                                                          style:
                                                                              TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        await Future.delayed(Duration.zero).then((_) =>
                                                                            removerFavorito(favorito.id));

                                                                        Get.back();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color: const Color.fromRGBO(
                                                                                0,
                                                                                9,
                                                                                89,
                                                                                1),
                                                                            borderRadius:
                                                                                BorderRadius.circular(5)),
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                5),
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            80,
                                                                        child:
                                                                            const Text(
                                                                          'Sim',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            );
                                                          });
                                                    }
                                                  },
                                                  onTap: () {
                                                    if (!isAccessibilityEnabled) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              elevation: 10,
                                                              titlePadding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              title: const Text(
                                                                  'Remover favorito'),
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      250,
                                                                      247,
                                                                      247),
                                                              content: const Text(
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
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                5),
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            80,
                                                                        child:
                                                                            const Text(
                                                                          'Não',
                                                                          style:
                                                                              TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        await Future.delayed(Duration.zero).then((_) =>
                                                                            removerFavorito(favorito.id));

                                                                        Get.back();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color: const Color.fromRGBO(
                                                                                0,
                                                                                9,
                                                                                89,
                                                                                1),
                                                                            borderRadius:
                                                                                BorderRadius.circular(5)),
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                5),
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            80,
                                                                        child:
                                                                            const Text(
                                                                          'Sim',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            );
                                                          });
                                                    } else {
                                                      ttsService.speak(
                                                          'Remover tutorial');
                                                    }
                                                  },
                                                  child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: Color.fromARGB(
                                                              137, 255, 0, 0),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5))),
                                                      height:
                                                          isAccessibilityEnabled
                                                              ? 40
                                                              : 30,
                                                      width:
                                                          isAccessibilityEnabled
                                                              ? 40
                                                              : 30,
                                                      child: const Icon(
                                                        color: Color.fromARGB(
                                                            255, 250, 250, 250),
                                                        Icons.close_rounded,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ])),
                  );
                }));
  }
}
