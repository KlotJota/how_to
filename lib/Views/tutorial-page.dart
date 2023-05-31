import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/home.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/user-register.dart';
import 'package:how_to/Views/tutorialEdit-page.dart';

class TutorialPage extends StatefulWidget {
  final String id;
  TutorialPage(this.id);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentSnapshot<Object?>? tutorial;

  @override
  void initState() {
    super.initState();
    buscarTutorial();
  }

  void popUpRegister() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: EdgeInsets.all(5),
            title: Text('Criar conta'),
            backgroundColor: Color.fromARGB(255, 250, 247, 247),
            content: Text(
              'Você deve criar uma conta para poder adicionar tutoriais aos favoritos e consultar sua Área de usuário',
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      height: 30,
                      width: 80,
                      child: Text(
                        'Fechar',
                        style: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(UserRegisterPage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.only(top: 5),
                      height: 30,
                      width: 85,
                      child: Text(
                        'Criar conta',
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
  }

  void buscarTutorial() async {
    final tutorialDoc = await FirebaseFirestore.instance
        .collection('tutoriais')
        .doc(widget.id)
        .get();
    setState(() {
      tutorial = tutorialDoc;
    });
  }

  void deletar(String id) {
    firestore.collection('tutoriais').doc(id).delete();
    Get.to(HomePage());
  }

  bool _favorito = false;

  final user = FirebaseAuth.instance.currentUser;

  bool isLogado() {
    if (user!.uid == "vapEyTsxGoWsOcUObGDywxz4WpC2" ||
        user!.uid == "bP234QxmIsPth7PqwzosZyfNMvk2" ||
        user!.uid == "YTzsr7KMKzezqsCbNxdsHHhSvGc2") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: tutorial == null
            ? CircularProgressIndicator()
            : Stack(children: [
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
                        child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Icon(
                                    Icons.arrow_back_outlined,
                                    color: Color.fromRGBO(0, 9, 89, 1),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.topCenter,
                                child: Text(
                                  tutorial!['titulo'],
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: 200,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Image.network(
                                            tutorial!['imagem'],
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (auth.currentUser!
                                                      .displayName !=
                                                  null) {
                                                _favorito = !_favorito;
                                                print(tutorial!.id);
                                                print(auth.currentUser!.uid);
                                                FirebaseFirestore.instance
                                                    .collection('favoritos')
                                                    .doc(auth.currentUser!.uid)
                                                    .set({
                                                  "Favoritos":
                                                      FieldValue.arrayUnion(
                                                          [tutorial!.id])
                                                }, SetOptions(merge: true));
                                              } else {
                                                popUpRegister();
                                              }
                                            });
                                          },
                                          icon: Icon(
                                            Icons.star,
                                          ),
                                          iconSize: 35,
                                          color: _favorito
                                              ? Color.fromARGB(255, 194, 149, 4)
                                              : const Color.fromARGB(
                                                  255, 179, 179, 179)),
                                      isLogado()
                                          ? IconButton(
                                              onPressed: () {
                                                if (auth.currentUser!
                                                        .displayName !=
                                                    null) {
                                                  Get.to(TutorialEditPage(
                                                      tutorial!.id));
                                                }
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                            )
                                          : Container(),
                                      isLogado()
                                          ? IconButton(
                                              onPressed: () {
                                                if (auth.currentUser!
                                                        .displayName !=
                                                    null) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          elevation: 10,
                                                          titlePadding:
                                                              EdgeInsets.all(5),
                                                          title:
                                                              Text('Excluir'),
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  250,
                                                                  247,
                                                                  247),
                                                          content: Text(
                                                              'Deseja realmente EXCLUIR esse tutorial da base de dados?'),
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
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5),
                                                                    height: 30,
                                                                    width: 80,
                                                                    child: Text(
                                                                      'Não',
                                                                      style: TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              9,
                                                                              89,
                                                                              1)),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    deletar(
                                                                        tutorial!
                                                                            .id);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            9,
                                                                            89,
                                                                            1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5),
                                                                    height: 30,
                                                                    width: 80,
                                                                    child: Text(
                                                                      'Sim',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
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
                                              icon: Icon(
                                                Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 175, 0, 0),
                                              ),
                                              iconSize: 35,
                                              color: const Color.fromARGB(
                                                  255, 179, 179, 179),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    color: Colors.black,
                                    height: 1,
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'How To?',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Container(
                                      child: Text(tutorial!['texto'],
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 70,
                              )
                            ])))
              ]));
  }
}
