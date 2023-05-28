import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/tutorial-page.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> categorias = <String>[
    'Todos',
    'Cozinha',
    'Tecnologia',
    'Construção',
    'Relacionamentos',
    'Beleza'
  ];

  String? item = 'Todos';

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
                          image: AssetImage('images/how-to-branco.png'))),
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
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ], color: Color.fromARGB(255, 250, 247, 247)),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
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
                            labelText: ' Pesquisar',
                            suffixIcon: Icon(Icons.search),
                            prefixIcon: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          width: 1,
                                          color:
                                              Color.fromARGB(255, 0, 0, 0)))),
                              width: 100,
                              margin: EdgeInsets.only(left: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    alignment: Alignment.center,
                                    borderRadius: BorderRadius.circular(5),
                                    dropdownColor:
                                        Color.fromARGB(255, 233, 233, 233),
                                    onChanged: (String? novoItem) {
                                      setState(() {
                                        item = novoItem!;
                                      });
                                    },
                                    value: item,
                                    items: categorias
                                        .map<DropdownMenuItem<String>>(
                                      (String valor) {
                                        return DropdownMenuItem<String>(
                                          value: valor,
                                          child: Text(valor),
                                        );
                                      },
                                    ).toList()),
                              ),
                            ),
                            hintText: 'Pesquise por tutoriais',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 180,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            var tutorial = snapshots.data!.docs[index]
                                as QueryDocumentSnapshot<Map<String, dynamic>>;

                            if (pesquisa.isEmpty) {
                              return GestureDetector(
                                  onTap: () =>
                                      Get.to(TutorialPage(tutorial.id)),
                                  child: Card(
                                    elevation: 5,
                                    margin: EdgeInsets.all(5),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                tutorial['imagem']),
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 220),
                                        child: Container(
                                            color: Color.fromRGBO(0, 9, 89, 1),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 4,
                                                  left: 8,
                                                  right: 8,
                                                  bottom: 4),
                                              child: Text(
                                                tutorial['titulo'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Color.fromARGB(
                                                        255, 240, 240, 240)),
                                                maxLines: 2,
                                              ),
                                            )),
                                      ),
                                    ),
                                  ));
                            }
                            if (tutorial['titulo']
                                .toString()
                                .toLowerCase()
                                .contains(pesquisa.toLowerCase())) {
                              return GestureDetector(
                                onTap: () => Get.to(TutorialPage(tutorial.id)),
                                child: tutorial['titulo']
                                        .toString()
                                        .toLowerCase()
                                        .contains(pesquisa.toLowerCase())
                                    ? Card(
                                        elevation: 5,
                                        margin: EdgeInsets.all(5),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomLeft:
                                                    Radius.circular(10))),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    tutorial['imagem']),
                                                fit: BoxFit.cover,
                                                alignment: Alignment.topCenter),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 220),
                                            child: Container(
                                                color:
                                                    Color.fromRGBO(0, 9, 89, 1),
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 4,
                                                      left: 8,
                                                      right: 8,
                                                      bottom: 4),
                                                  child: Text(
                                                    tutorial['titulo'],
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: Color.fromARGB(
                                                            255,
                                                            240,
                                                            240,
                                                            240)),
                                                    maxLines: 2,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      )
                                    : Card(
                                        elevation: 5,
                                        margin: EdgeInsets.all(5),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomLeft:
                                                    Radius.circular(10))),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    tutorial['imagem']),
                                                fit: BoxFit.cover,
                                                alignment: Alignment.topCenter),
                                          ),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 220),
                                            child: Container(
                                                color:
                                                    Color.fromRGBO(0, 9, 89, 1),
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 4,
                                                      left: 8,
                                                      right: 8,
                                                      bottom: 4),
                                                  child: Text(
                                                    tutorial['titulo'],
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: Color.fromARGB(
                                                            255,
                                                            240,
                                                            240,
                                                            240)),
                                                    maxLines: 2,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
