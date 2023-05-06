import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/createTutorial-page.dart';
import 'package:how_to/Views/search-page.dart';
import 'package:how_to/Views/tutorial-page.dart';
import 'package:how_to/Views/tutorial_content.dart';
import 'package:how_to/Views/user-login.dart';
import 'package:how_to/Views/user-profile.dart';
import 'package:how_to/Views/user-register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

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

  void logOut(BuildContext context) async {
    try {
      await auth.signOut();

      Navigator.of(context).pushNamed('/');
    } catch (e) {
      print(e);
    }
  }

  void _popUp(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: EdgeInsets.all(5),
            title: Text('Sair'),
            backgroundColor: Color.fromARGB(255, 240, 240, 240),
            content: Text('Você realmente deseja sair do aplicativo?'),
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
                        'Não',
                        style: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => logOut(context),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.only(top: 5),
                      height: 30,
                      width: 80,
                      child: Text(
                        'Sim',
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
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(255, 233, 233, 233),
                          ),
                          height: 60,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      child: CircleAvatar(
                                        backgroundImage:
                                            AssetImage('images/mateus.png'),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Bom dia!',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: auth.currentUser!.email ==
                                                      null
                                                  ? Text('Usuário')
                                                  : Text(auth.currentUser!.email
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
                        child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => Get.to(TutorialContentPage()),
                                  child: Card(
                                    elevation: 5,
                                    margin: EdgeInsets.only(left: 10),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('images/lucas.jpeg'),
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter),
                                      ),
                                      width: 160,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 220),
                                        child: Container(
                                            color: Color.fromRGBO(0, 9, 89, 1),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 4, left: 8, right: 8),
                                              child: Text(
                                                'Como fazer sua documentação escolar',
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
                                  ),
                                )),
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
                        child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => Card(
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
                                          image: AssetImage('images/Agua.jpg'),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.topCenter),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 220),
                                      child: Container(
                                          color: Color.fromRGBO(0, 9, 89, 1),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 4, left: 8, right: 8),
                                            child: Text(
                                              'Como beber água',
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
                                )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF000959),
        onPressed: () {
          Get.to(CreateTutorialPage());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
