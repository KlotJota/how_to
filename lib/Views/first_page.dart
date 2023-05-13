import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:how_to/Views/createTutorial-page.dart';
import 'package:how_to/Views/home.dart';
import 'package:how_to/Views/search-page.dart';
import 'package:how_to/Views/user-profile.dart';
import 'package:get/get.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int paginaAtual = 0;
  bool isAdm = true;
  late PageController pc;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pc = PageController(initialPage: paginaAtual);
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
          CreateTutorialPage(),
          UserProfilePage(),
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
          if (isAdm)
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Novo Tutorial',
              backgroundColor: Color.fromARGB(255, 0, 9, 89),
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Perfil',
            backgroundColor: Color.fromARGB(255, 0, 9, 89),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Sair',
            backgroundColor: Color.fromARGB(255, 0, 9, 89),
          ),
        ],
        onTap: (pagina) {
          if (pagina != 3) {
            setState(() {
              paginaAtual = pagina;
            });
          } else {
            Get.to(CreateTutorialPage());
          }
          pc.animateToPage(pagina,
              duration: Duration(milliseconds: 450), curve: Curves.ease);
        },
      ),
    );
  }
}
