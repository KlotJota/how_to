import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/search-page.dart';
import 'package:how_to/Views/user-login.dart';
import 'package:how_to/Views/user-profile.dart';
import 'package:how_to/Views/user-register.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            color: Color.fromRGBO(0, 9, 89, 1),
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
              child: GestureDetector(
                onTap: () => Get.to(UserProfilePage()),
                child: Container(
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
                                      backgroundColor: Colors.amber,
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
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text('Matheus Soldera'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Text('Ver meu perfil'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                  onPressed: () => Get.to(
                    HomePage(),
                    transition: Transition.noTransition,
                  ),
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
