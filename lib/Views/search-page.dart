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
                    margin: EdgeInsets.only(top: 10),
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
