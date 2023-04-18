import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/user-login.dart';
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
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/pesquisar');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile');
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
          Container(
              alignment: Alignment.bottomCenter,
              child: BottomNavigationBar(
                selectedItemColor: Color.fromRGBO(0, 9, 89, 1),
                unselectedItemColor: Color.fromARGB(255, 59, 59, 59),
                backgroundColor: Color.fromARGB(255, 233, 233, 233),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Pesquisar',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_box_rounded),
                    label: 'Perfil',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _OnSelectedItem,
              ))
        ],
      ),
    );
  }
}
