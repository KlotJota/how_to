import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/search_page/components/search_form.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/tutorial_page/tutorial-page.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  PesquisaSingleton pesquisa = PesquisaSingleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore.collection('tutoriais').snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 9, 89, 1),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          scale: 19,
                          alignment: Alignment.topCenter,
                          image: AssetImage('images/how-to-branco.png'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 8,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                        color: Color.fromARGB(255, 250, 247, 247),
                      ),
                      child: Column(
                        children: [
                          SearchForm(),
                          Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshots.data!.docs.length,
                              itemBuilder: (context, index) {
                                var tutorial = snapshots.data!.docs[index];

                                if (pesquisa.toString().isNotEmpty &&
                                    !tutorial['titulo']
                                        .toString()
                                        .toLowerCase()
                                        .contains(
                                          pesquisa.toString().toLowerCase(),
                                        ) &&
                                    !tutorial['categoria']
                                        .toString()
                                        .toLowerCase()
                                        .contains(
                                          pesquisa.toString().toLowerCase(),
                                        )) {
                                  return SizedBox.shrink();
                                }

                                return GestureDetector(
                                  onTap: () =>
                                      Get.to(TutorialPage(tutorial.id)),
                                  child: Card(
                                    elevation: 5,
                                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(tutorial['imagem']),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.topCenter,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 220,
                                        ),
                                        child: Container(
                                          color: Color.fromRGBO(0, 9, 89, 1),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              top: 4,
                                              left: 8,
                                              right: 8,
                                              bottom: 4,
                                            ),
                                            child: Text(
                                              tutorial['titulo'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                overflow: TextOverflow.ellipsis,
                                                color: Color.fromARGB(
                                                  255,
                                                  240,
                                                  240,
                                                  240,
                                                ),
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
