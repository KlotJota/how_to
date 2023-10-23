import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
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

  TtsService ttsService = TtsService();

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

  @override
  void dispose() {
    ttsService.dispose(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  void readOptions(int index) async {
    List<String> titles = [
      "Tela inicial",
      "Tela de pesquisa",
      "Tela de perfil",
    ];

    await ttsService.speak(titles[index]);
  }

  void logOut(BuildContext context) async {
    try {
      await auth.signOut();
      Get.offAll(UserLoginPage());
    } catch (e) {
      print(e);
    }
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;

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
                HapticFeedback.heavyImpact();
                pc.jumpToPage(0);
                if (isAccessibilityEnabled) {
                  readOptions(0);
                }
              },
            ),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: Icon(Icons.search),
              onTap: () {
                HapticFeedback.heavyImpact();
                pc.jumpToPage(1);
                if (isAccessibilityEnabled) {
                  readOptions(1);
                }
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
                  HapticFeedback.heavyImpact();
                  pc.jumpToPage(3);
                  if (isAccessibilityEnabled) {
                    readOptions(2);
                  }
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
