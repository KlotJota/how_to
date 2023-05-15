import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/createTutorial-page.dart';
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

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  int _selectedIndex = 0;

  void _OnSelectedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Get.to(HomePage());
        break;
      case 1:
        Get.to(SearchPage());
        break;
      case 2:
        Get.to(UserProfilePage());
        break;
    }
  }

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
                    ], color: Color.fromARGB(255, 240, 240, 240)),
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
                                  color: Color.fromARGB(255, 233, 233, 233),
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
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'images/mateus.png'),
                                            ),
                                          ),
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
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          tutorial['imagem']),
                                                      fit: BoxFit.cover,
                                                      alignment:
                                                          Alignment.topCenter),
                                                ),
                                                width: 160,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 220),
                                                  child: Container(
                                                      color: Color.fromRGBO(
                                                          0, 9, 89, 1),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 4,
                                                                left: 8,
                                                                right: 8),
                                                        child: Text(
                                                          tutorial['titulo'],
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 500,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: tutoriais
                                .map((tutorial) => Card(
                                      elevation: 5,
                                      margin: EdgeInsets.all(10),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10))),
                                      child: Container(
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
                                                    top: 4, left: 8, right: 8),
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
                                    ))
                                .toList(),
                          ),
                        ),
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
