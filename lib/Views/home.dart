import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/createTutorial-page.dart';
import 'package:how_to/Views/first_page.dart';
import 'package:how_to/Views/search-page.dart';
import 'package:how_to/Views/tutorial-page.dart';
import 'package:how_to/Views/user-login.dart';
import 'package:how_to/Views/user-profile.dart';
import 'package:how_to/Views/user-register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

bool _favorito = false;

class _HomePageState extends State<HomePage> {
  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore.collection('tutoriais').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // senao tiver dados
              return CircularProgressIndicator(); // circulo de carregando
            }

            var tutoriais = snapshot.data!.docs;

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
                    child: ListView(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color.fromARGB(255, 243, 243, 243),
                                ),
                                height: 60,
                                width: MediaQuery.of(context).size.width - 20,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                              child: auth.currentUser!
                                                          .photoURL ==
                                                      null
                                                  ? CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          'https://firebasestorage.googleapis.com/v0/b/howto-60459.appspot.com/o/perfis%2Fpadrão%2Fuser.png?alt=media&token=bb4a0f5c-8839-400d-8fb3-dbaaf07b3117'),
                                                    )
                                                  : CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(''),
                                                    )),
                                          Container(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10, bottom: 2),
                                                  child: Text(
                                                    'Bem vindo!',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: auth.currentUser!
                                                                .displayName ==
                                                            null
                                                        ? Text('Usuário')
                                                        : Text(auth.currentUser!
                                                            .displayName
                                                            .toString())),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Tutoriais Populares',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 255, 191, 0),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 260,
                              child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  children: tutoriais
                                      .map((tutorial) => GestureDetector(
                                            onTap: () => Get.to(TutorialPage(
                                                tutorial
                                                    .id)), // colocar tutorial.id como parametro
                                            child: Card(
                                              elevation: 5,
                                              margin: EdgeInsets.only(left: 10),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10))),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (auth.currentUser!
                                                                  .displayName !=
                                                              null) {
                                                            _favorito =
                                                                !_favorito;
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'favoritos')
                                                                .add({
                                                              'titulo':
                                                                  tutorial[
                                                                      'titulo'],
                                                              'texto': tutorial[
                                                                  'texto'],
                                                              'imagem':
                                                                  tutorial[
                                                                      'imagem'],
                                                              'categoria':
                                                                  tutorial[
                                                                      'categoria'],
                                                              'favorito':
                                                                  _favorito,
                                                              'uid': auth
                                                                  .currentUser!
                                                                  .uid
                                                            });
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              color: _favorito
                                                                  ? Color.fromARGB(
                                                                      255,
                                                                      255,
                                                                      191,
                                                                      0)
                                                                  : Color.fromARGB(
                                                                      255,
                                                                      243,
                                                                      243,
                                                                      243)),
                                                          width: 160,
                                                          child: Icon(Icons.star,
                                                              color: _favorito
                                                                  ? Color.fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255)
                                                                  : Color.fromRGBO(
                                                                      0,
                                                                      9,
                                                                      89,
                                                                      1)))),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.3),
                                                          spreadRadius: 5,
                                                          blurRadius: 10,
                                                          offset: Offset(0,
                                                              2), // changes position of shadow
                                                        ),
                                                      ],
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              tutorial[
                                                                  'imagem']),
                                                          fit: BoxFit.cover,
                                                          alignment: Alignment
                                                              .bottomCenter),
                                                    ),
                                                    width: 160,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 194),
                                                      child: Container(
                                                          height: 36,
                                                          color: Color.fromRGBO(
                                                              0, 9, 89, 1),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4,
                                                                    left: 8,
                                                                    right: 8),
                                                            child: Text(
                                                              tutorial[
                                                                  'titulo'],
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          240,
                                                                          240,
                                                                          240)),
                                                              maxLines: 2,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                      .toList()),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Outros Tutoriais',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Icon(Icons.add_box_outlined)
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: tutoriais
                                      .map((tutorial) => GestureDetector(
                                            onTap: () => Get.to(TutorialPage(
                                                tutorial
                                                    .id)), // colocar tutorial.id como parametro
                                            child: Card(
                                              color: Color.fromARGB(
                                                  255, 250, 247, 247),
                                              elevation: 5,
                                              margin: EdgeInsets.all(5),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10))),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (auth.currentUser!
                                                                  .displayName !=
                                                              null) {
                                                            _favorito =
                                                                !_favorito;
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'favoritos')
                                                                .add({
                                                              'titulo':
                                                                  tutorial[
                                                                      'titulo'],
                                                              'texto': tutorial[
                                                                  'texto'],
                                                              'imagem':
                                                                  tutorial[
                                                                      'imagem'],
                                                              'categoria':
                                                                  tutorial[
                                                                      'categoria'],
                                                              'favorito':
                                                                  _favorito,
                                                              'uid': auth
                                                                  .currentUser!
                                                                  .uid
                                                            });
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              color: _favorito
                                                                  ? Color.fromARGB(
                                                                      255, 255, 191, 0)
                                                                  : Color.fromARGB(
                                                                      255,
                                                                      243,
                                                                      243,
                                                                      243)),
                                                          width: MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                          child: Icon(Icons.star,
                                                              color: _favorito
                                                                  ? Color.fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255)
                                                                  : Color.fromRGBO(
                                                                      0, 9, 89, 1)))),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.3),
                                                          spreadRadius: 5,
                                                          blurRadius: 10,
                                                          offset: Offset(0,
                                                              2), // changes position of shadow
                                                        ),
                                                      ],
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              tutorial[
                                                                  'imagem']),
                                                          fit: BoxFit.cover,
                                                          alignment: Alignment
                                                              .bottomCenter),
                                                    ),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 194),
                                                      child: Container(
                                                          height: 36,
                                                          color: Color.fromRGBO(
                                                              0, 9, 89, 1),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4,
                                                                    left: 8,
                                                                    right: 8),
                                                            child: Text(
                                                              tutorial[
                                                                  'titulo'],
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          240,
                                                                          240,
                                                                          240)),
                                                              maxLines: 2,
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                      .toList()),
                            )
                          ],
                        ),
                        Container(
                          height: 120,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
