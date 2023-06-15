import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:how_to/Views/create_tutorial/createTutorial-page.dart';
import 'package:how_to/Views/search_page/search-page.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:how_to/views/login/user_login.dart';
import '../home/home.dart';
import '../profile/user_profile.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void _desabilitarAnimacao() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  bool isAdmin = false;
  int paginaAtual = 0;
  late PageController pc;
  FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  void logOut(BuildContext context) async {
    try {
      await auth.signOut();
      Get.offAll(UserLoginPage());
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
      },
    );
  }

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual, keepPage: true);
    _desabilitarAnimacao();
    if (user!.uid == "vapEyTsxGoWsOcUObGDywxz4WpC2" ||
        user!.uid == "bP234QxmIsPth7PqwzosZyfNMvk2" ||
        user!.uid == "YTzsr7KMKzezqsCbNxdsHHhSvGc2") {
      isAdmin = true;
    }
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (!isAdmin && paginaAtual == 2) {
            // Bloqueia o deslizamento para a CreateTutorialPage para usuários comuns
            if (details.delta.dx < 0) {
              pc.jumpToPage(3);
            }
          } else if (paginaAtual == 3) {
            if (details.delta.dx > 0) {
              pc.jumpToPage(1);
            }
          }
        },
        child: PageView(
          controller: pc,
          onPageChanged: (pagina) {
            setPaginaAtual(pagina);
            if (!isAdmin && pagina == 2) {
              if (paginaAtual == 1) {
                pc.jumpToPage(
                    3); // Redireciona para UserProfilePage se o usuário estiver no SearchPage
              } else if (paginaAtual == 3) {
                pc.jumpToPage(
                    1); // Redireciona para SearchPage se o usuário estiver no UserProfilePage
              }
            }
          },
          children: [
            HomePage(),
            SearchPage(),
            if (isAdmin) CreateTutorialPage(),
            UserProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
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
          if (isAdmin) // Verifica a condição para mostrar o botão
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Novo tutorial',
              backgroundColor: Color.fromARGB(255, 0, 9, 89),
            ),
          if (user!.displayName != null)
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Perfil',
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
