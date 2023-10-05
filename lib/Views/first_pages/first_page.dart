import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:how_to/Views/create_tutorial/createTutorial-page.dart';
import 'package:how_to/Views/search_page/search-page.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:how_to/views/login/user_login.dart';
import 'package:http/http.dart';
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

  final FlutterTts flutterTts = FlutterTts();

  Future<void> initializeTts() async {
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(1.0);
  }

  @override
  void initState() {
    super.initState();
    initializeTts();
    pc = PageController(initialPage: paginaAtual, keepPage: true);
    _desabilitarAnimacao();
    if (user!.uid == "vapEyTsxGoWsOcUObGDywxz4WpC2" ||
        user!.uid == "bP234QxmIsPth7PqwzosZyfNMvk2" ||
        user!.uid == "YTzsr7KMKzezqsCbNxdsHHhSvGc2") {
      isAdmin = true;
    }

    // Configurar o completionHandler para detectar quando a leitura é concluída
    // flutterTts.setCompletionHandler(() {
    //   setState(() {
    //     isReadingSettings =
    //         false; // Definir como false quando a leitura for concluída
    //     isReadingTheme = false;
    //     isReadingLogout = false;
    //     isReadingChangeProfile = false;
    //   });
    // });
  }

  @override
  void dispose() {
    flutterTts.stop(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  void readOptions(int index) async {
    List<String> titles = [
      "Tela inicial",
      "Tela de pesquisa",
      "Tela de perfil",
    ];

    await flutterTts.speak(titles[index]);

    // setState(() {
    //   if (index == 0) {
    //     isReadingSettings = true;
    //   } else if (index == 1) {
    //     isReadingTheme = true;
    //   } else if (index == 2) {
    //     isReadingChangeProfile = true;
    //   } else if (index == 3) {
    //     isReadingLogout = true;
    //   }
    // });
  }

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
          titlePadding: const EdgeInsets.all(5),
          title: const Text('Sair'),
          backgroundColor: const Color.fromARGB(255, 240, 240, 240),
          content: const Text('Você realmente deseja sair do aplicativo?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.only(top: 5),
                    height: 30,
                    width: 80,
                    child: const Text(
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
                        color: const Color.fromRGBO(0, 9, 89, 1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.only(top: 5),
                    height: 30,
                    width: 80,
                    child: const Text(
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
            const HomePage(),
            const SearchPage(),
            if (isAdmin) const CreateTutorialPage(),
            const UserProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,
        type: BottomNavigationBarType.shifting,
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: Icon(Icons.home),
              onTap: () {
                pc.jumpToPage(0);
                readOptions(0);
              },
            ),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: Icon(Icons.search),
              onTap: () {
                pc.jumpToPage(1);
                readOptions(1);
              },
            ),
            label: 'Pesquisar',
          ),
          if (isAdmin) // Verifica a condição para mostrar o botão
            const BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Novo tutorial',
            ),
          if (user!.displayName != null)
            BottomNavigationBarItem(
              icon: GestureDetector(
                child: Icon(Icons.account_circle_outlined),
                onTap: () {
                  pc.jumpToPage(3);
                  readOptions(2);
                },
              ),
              label: 'Perfil',
            ),
        ],
        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: const Duration(milliseconds: 450), curve: Curves.ease);
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
