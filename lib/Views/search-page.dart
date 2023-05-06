import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/createTutorial-page.dart';
import 'package:how_to/Views/home.dart';
import 'package:how_to/Views/user-profile.dart';
import 'package:how_to/Views/user-register.dart';
import 'package:how_to/Views/tutorial-page.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  List<String> categorias = <String>[
    'Todos',
    'Cozinha',
    'Tecnologia',
    'Construção',
    'Relacionamentos',
    'Beleza'
  ];

  String? item = 'Todos';

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
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        labelText: ' Pesquisar',
                        suffixIcon: Icon(Icons.search),
                        prefixIcon: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 0, 0, 0)))),
                          width: 100,
                          margin: EdgeInsets.only(left: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                isExpanded: true,
                                alignment: Alignment.center,
                                borderRadius: BorderRadius.circular(5),
                                dropdownColor:
                                    Color.fromARGB(255, 233, 233, 233),
                                onChanged: (String? novoItem) {
                                  setState(() {
                                    item = novoItem!;
                                  });
                                },
                                value: item,
                                items: categorias.map<DropdownMenuItem<String>>(
                                  (String valor) {
                                    return DropdownMenuItem<String>(
                                      value: valor,
                                      child: Text(valor),
                                    );
                                  },
                                ).toList()),
                          ),
                        ),
                        hintText: 'Pesquise por tutoriais',
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
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
                                            image:
                                                AssetImage('images/Agua.jpg'),
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 220),
                                        child: Container(
                                            color: Color.fromRGBO(0, 9, 89, 1),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 4,
                                                  left: 8,
                                                  right: 8,
                                                  bottom: 4),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
