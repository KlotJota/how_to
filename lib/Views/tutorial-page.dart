import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/createTutorial-page.dart';
import 'package:how_to/Views/home.dart';
import 'package:how_to/Views/search-page.dart';
import 'package:how_to/Views/user-profile.dart';
import 'package:how_to/Views/user-register.dart';
import 'package:get/get.dart';

class TutorialPage extends StatefulWidget {
  final String id;
  TutorialPage(this.id);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  // final DocumentSnapshot tutorial = FirebaseFirestore.instance
  //     .collection('tutoriais')
  //     .doc('id') as DocumentSnapshot<Object?>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                        '',
                        style: TextStyle(fontSize: 30),
                      )),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 200,
                    child: Column(
                      children: [
                        Expanded(
                            child: Stack(
                          fit: StackFit.expand,
                          children: [
                            FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset('images/lucas.jpeg')),
                          ],
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                        'Você provavelmente durante sua vida escolar já precisou cuidar de sua documentação afinal, são tantas que você as vezes até acabar perdido. Por isso, este tutorial irá lhe ensinar desde como escolher a foto perfeita para seus documentos, quanto quais dados levar na hora de fazê-los. '),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                        'Você provavelmente durante sua vida escolar já precisou cuidar de sua documentação afinal, são tantas que você as vezes até acabar perdido. Por isso, este tutorial irá lhe ensinar desde como escolher a foto perfeita para seus documentos, quanto quais dados levar na hora de fazê-los. '),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                        'Você provavelmente durante sua vida escolar já precisou cuidar de sua documentação afinal, são tantas que você as vezes até acabar perdido. Por isso, este tutorial irá lhe ensinar desde como escolher a foto perfeita para seus documentos, quanto quais dados levar na hora de fazê-los. '),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                        'Você provavelmente durante sua vida escolar já precisou cuidar de sua documentação afinal, são tantas que você as vezes até acabar perdido. Por isso, este tutorial irá lhe ensinar desde como escolher a foto perfeita para seus documentos, quanto quais dados levar na hora de fazê-los. '),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                        'Você provavelmente durante sua vida escolar já precisou cuidar de sua documentação afinal, são tantas que você as vezes até acabar perdido. Por isso, este tutorial irá lhe ensinar desde como escolher a foto perfeita para seus documentos, quanto quais dados levar na hora de fazê-los. '),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 150,
          )
        ],
      ),
    );
  }
}
