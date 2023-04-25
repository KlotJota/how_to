import 'package:flutter/material.dart';
import 'package:how_to/Views/createTutorial-page.dart';
import 'package:how_to/Views/home.dart';
import 'package:how_to/Views/search-page.dart';
import 'package:how_to/Views/user-profile.dart';
import 'package:how_to/Views/user-register.dart';
import 'package:get/get.dart';

class TutorialPage extends StatefulWidget {
  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
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
                      child: const Text(
                        'Como fazer sua documentação',
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF000959),
        onPressed: () {
          Get.to(CreateTutorialPage());
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color(0xFF000959),
        child: IconTheme(
          data: IconThemeData(color: Color.fromARGB(255, 240, 240, 240)),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () =>
                      Get.to(HomePage(), transition: Transition.noTransition),
                  icon: Icon(Icons.home),
                ),
                IconButton(
                  onPressed: () =>
                      Get.to(SearchPage(), transition: Transition.noTransition),
                  icon: Icon(Icons.search),
                ),
                SizedBox(
                  width: 24,
                ),
                IconButton(
                  onPressed: () => Get.to(UserProfilePage(),
                      transition: Transition.noTransition),
                  icon: Icon(Icons.account_box_sharp),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
