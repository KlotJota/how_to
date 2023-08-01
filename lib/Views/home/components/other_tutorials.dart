import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/loadingScreens/loading_other_tutorials.dart';
import 'package:how_to/Views/tutorial_page/tutorial-page.dart';

class OtherTutorials extends StatefulWidget {
  const OtherTutorials({super.key});

  @override
  State<OtherTutorials> createState() => _OtherTutorialsState();
}

class _OtherTutorialsState extends State<OtherTutorials> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection('tutoriais')
            .orderBy('titulo', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // senao tiver dados
            return const Column(
              children: [
                LoadingOtherTutorials(),
                LoadingOtherTutorials(),
                LoadingOtherTutorials(),
                LoadingOtherTutorials(),
                LoadingOtherTutorials()
              ],
            ); // circulo de carregando
          }

          var tutoriais = snapshot.data!.docs;

          return SizedBox(
            child: Column(
              children: [
                ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: tutoriais
                        .map((tutorial) => GestureDetector(
                              onTap: () => Get.to(TutorialPage(tutorial
                                  .id)), // colocar tutorial.id como parametro
                              child: Card(
                                color: const Color.fromARGB(255, 250, 247, 247),
                                elevation: 3,
                                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10))),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(tutorial['imagem']),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.bottomCenter),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 200),
                                    child: Container(
                                        color: const Color.fromRGBO(0, 9, 89, 0.815),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 4,
                                              left: 8,
                                              right: 8,
                                              bottom: 4),
                                          child: Text(
                                            tutorial['titulo'],
                                            style: const TextStyle(
                                                fontSize: 12,
                                                overflow: TextOverflow.ellipsis,
                                                color: Color.fromARGB(
                                                    255, 240, 240, 240)),
                                            maxLines: 2,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ))
                        .toList()),
              ],
            ),
          );
        });
  }
}
