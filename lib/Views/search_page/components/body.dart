import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/tutorial_page/tutorial-page.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String pesquisa = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore.collection('tutoriais').snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            // senao tiver dados
            return CircularProgressIndicator(); // circulo de carregando
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 8,
                    blurRadius: 10,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ], color: Color.fromARGB(255, 250, 247, 247)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            pesquisa = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          labelText: 'Pesquisar',
                          suffixIcon: Icon(Icons.search),
                          hintText: 'Pesquise por tutoriais',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 180,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          var tutorial = snapshots.data!.docs[index];

                          if (pesquisa.isNotEmpty &&
                              !tutorial['titulo']
                                  .toString()
                                  .toLowerCase()
                                  .contains(pesquisa.toLowerCase()) &&
                              !tutorial['categoria']
                                  .toString()
                                  .toLowerCase()
                                  .contains(pesquisa.toLowerCase()) &&
                              !tutorial['texto']
                                  .toString()
                                  .toLowerCase()
                                  .contains(pesquisa.toLowerCase())) {
                            return SizedBox.shrink();
                          }

                          return GestureDetector(
                            onTap: () => Get.to(TutorialPage(tutorial.id)),
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
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(tutorial['imagem']),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 220),
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
                                              255, 240, 240, 240),
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
