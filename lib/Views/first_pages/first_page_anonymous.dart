import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:how_to/Views/search_page/search-page.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import '../home/home.dart';

class FirstPageAnonymous extends StatefulWidget {
  const FirstPageAnonymous({super.key});
  @override
  State<FirstPageAnonymous> createState() => _FirstPageAnonymousState();
}

class _FirstPageAnonymousState extends State<FirstPageAnonymous> {
  void _desabilitarAnimacao() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  bool isAdmin = true;
  int paginaAtual = 0;
  late PageController pc;
  FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    pc = PageController(initialPage: paginaAtual);
    _desabilitarAnimacao();
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          HomePage(),
          SearchPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Color.fromARGB(255, 240, 240, 240),
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
            backgroundColor: Color.fromARGB(255, 0, 9, 89),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pesquisar',
            backgroundColor: Color.fromARGB(255, 0, 9, 89),
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: Icon(Icons.logout),
              onTap: () => _popUp(context),
            ),
            label: 'Sair',
            backgroundColor: Color.fromARGB(255, 0, 9, 89),
          )
        ],
        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: Duration(milliseconds: 450), curve: Curves.ease);
          if (pagina == pc.page!.round()) {
            _desabilitarAnimacao();
          } else {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
                overlays: []);
          }
        },
      ),
    );
  }
}
