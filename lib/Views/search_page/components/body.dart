import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/face_detector/face_detector_page.dart';
import 'package:how_to/Views/loadingScreens/loading_searched_tutorials.dart';
import 'package:how_to/Views/search_page/components/search.singleton.dart';
import 'package:how_to/Views/tutorial_page/tutorial-page.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var searchKey = GlobalKey<FormState>();

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;

  TtsService ttsService = TtsService();

  @override
  void dispose() {
    ttsService.dispose(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchSingleton pesquisa = SearchSingleton.controller;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore.collection('tutoriais').snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            // senao tiver dados
            return const Column(
              children: [
                LoadingSearchedTutorials(),
                LoadingSearchedTutorials(),
                LoadingSearchedTutorials(),
                LoadingSearchedTutorials(),
                LoadingSearchedTutorials()
              ],
            ); // circulo de carregando
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 50,
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          width: MediaQuery.of(context).size.width - 80,
                          child: TextField(
                            key: searchKey,
                            onTap: () {
                              HapticFeedback.heavyImpact();
                              isAccessibilityEnabled
                                  ? ttsService.speak('Barra de pesquisa')
                                  : null;
                            },
                            onChanged: (value) {
                              setState(() {
                                pesquisa.searchController.text = value;
                              });
                            },
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              labelText: 'Pesquisar',
                              hintText: 'Pesquise por tutoriais',
                            ),
                          ),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            if (isAccessibilityEnabled) {
                              HapticFeedback.heavyImpact();
                              String searchValue =
                                  pesquisa.searchController.text;
                              setState(() {
                                pesquisa.searchController.text = searchValue;
                              });
                            }
                          },
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            if (isAccessibilityEnabled) {
                              ttsService
                                  .speak('Dê um duplo clique para pesquisar');
                            } else {
                              String searchValue =
                                  pesquisa.searchController.text;
                              setState(() {
                                pesquisa.searchController.text = searchValue;
                              });
                            }
                          },
                          child: Container(
                            child: Icon(Icons.search, color: Colors.white),
                            height: 50,
                            width: 50,
                            margin: EdgeInsets.only(right: 10, top: 10),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(0, 9, 89, 1),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        )
                      ],
                    ),
                    pesquisa.searchController.text == ''
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 10),
                            child: GestureDetector(
                              onTap: () {
                                if (isAccessibilityEnabled) {
                                  ttsService
                                      .speak('Abaixo estão todos os tutoriais');
                                  HapticFeedback.heavyImpact();
                                }
                              },
                              child: Text(
                                "Todos os tutoriais",
                                style: TextStyle(
                                    fontSize: isAccessibilityEnabled ? 30 : 20),
                              ),
                            ))
                        : Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 10),
                            child: GestureDetector(
                              onTap: () {
                                if (isAccessibilityEnabled) {
                                  ttsService.speak(
                                    "Abaixo estão os tutoriais encontrados para a sua pesquisa: ${pesquisa.searchController.text}",
                                  );
                                  HapticFeedback.heavyImpact();
                                }
                              },
                              child: Text(
                                "Tutoriais encontrados para: ${pesquisa.searchController.text}",
                                style: TextStyle(
                                    fontSize: isAccessibilityEnabled ? 30 : 20),
                              ),
                            )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 180,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          var tutorial = snapshots.data!.docs[index];

                          if (pesquisa.searchController.text.isNotEmpty &&
                              !tutorial['titulo']
                                  .toString()
                                  .toLowerCase()
                                  .contains(pesquisa.searchController.text
                                      .toLowerCase()) &&
                              !tutorial['categoria']
                                  .toString()
                                  .toLowerCase()
                                  .contains(pesquisa.searchController.text
                                      .toLowerCase()) &&
                              !tutorial['texto']
                                  .toString()
                                  .toLowerCase()
                                  .contains(pesquisa.searchController.text
                                      .toLowerCase())) {
                            return const SizedBox.shrink();
                          }

                          return GestureDetector(
                            onLongPress: () {
                              if (isAccessibilityEnabled) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FaceDetectorPage(tutorial!.id),
                                  ),
                                );
                                HapticFeedback.heavyImpact();
                              }
                            },
                            onDoubleTap: () {
                              if (isAccessibilityEnabled) {
                                Get.to(() => TutorialPage(tutorial.id));
                                HapticFeedback.heavyImpact();
                              }
                            },
                            onTap: () {
                              HapticFeedback.heavyImpact();
                              isAccessibilityEnabled
                                  ? ttsService.speak(tutorial['titulo'])
                                  : Get.to(() => TutorialPage(tutorial.id));
                            },
                            child: Card(
                              elevation: 3,
                              margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              )),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(tutorial['imagem']),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 200),
                                  child: Container(
                                    color:
                                        const Color.fromRGBO(0, 9, 89, 0.815),
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        top: 4,
                                        left: 8,
                                        right: 8,
                                        bottom: 4,
                                      ),
                                      child: Text(
                                        tutorial['titulo'],
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 250, 250, 250),
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
