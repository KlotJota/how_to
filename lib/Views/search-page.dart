import 'package:flutter/material.dart';
import 'package:how_to/Views/home.dart';
import 'package:how_to/Views/user-profile.dart';
import 'package:how_to/Views/user-register.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var logo = 'howto_logo1.png';

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
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Pesquisar',
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Pesquise por tutoriais',
                      ),
                    ),
                  ),
                ],
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
