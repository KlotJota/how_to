import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/tutorial_page/tutorial-page.dart';

class OtherTutorials extends StatefulWidget {
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
            return CircularProgressIndicator(); // circulo de carregando
          }

          var tutoriais = snapshot.data!.docs;

          return SizedBox(
            child: Column(
              children: [
                ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: tutoriais
                        .map((tutorial) => GestureDetector(
                              onTap: () => Get.to(TutorialPage(tutorial
                                  .id)), // colocar tutorial.id como parametro
                              child: Card(
                                color: Color.fromARGB(255, 250, 247, 247),
                                elevation: 5,
                                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    image: DecorationImage(
                                        image: NetworkImage(tutorial['imagem']),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.bottomCenter),
                                  ),
                                  width: MediaQuery.of(context).size.height,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 220),
                                    child: Container(
                                        height: 36,
                                        color: Color.fromRGBO(0, 9, 89, 1),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 4, left: 8, right: 8),
                                          child: Text(
                                            tutorial['titulo'],
                                            style: TextStyle(
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
