import 'package:flutter/material.dart';
import 'package:how_to/Views/home.dart';
import 'package:how_to/Views/search-page.dart';
import 'package:how_to/Views/user-register.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFF000959),
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
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 40,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      'Matheus Soldera',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    color: Color.fromARGB(255, 233, 233, 233),
                    margin: EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            children: [
                              Container(child: Text('Tutoriais criados')),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  '5',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Container(child: Text('Tutoriais Salvos')),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  '10',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            children: [
                              Container(child: Text('Mais algo aqui')),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  '8',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
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
        onPressed: () {},
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
