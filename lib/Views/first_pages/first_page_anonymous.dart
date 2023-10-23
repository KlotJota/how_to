import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/login/user_login.dart';
import 'package:how_to/Views/search_page/search-page.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../home/home.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  TtsService ttsService = TtsService();

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
    _desabilitarAnimacao();
  }

  @override
  void dispose() {
    ttsService.dispose(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  void readOptions(int index) async {
    List<String> titles = ["Tela inicial", "Tela de pesquisa", "Botão de sair"];

    await ttsService.speak(titles[index]);
  }

  void logOut(BuildContext context) async {
    try {
      await auth.signOut();

      Get.offAll(const UserLoginPage());
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
            title: GestureDetector(
                onTap: () {
                  if (isAccessibilityEnabled) {
                    ttsService.speak('Sair');
                    HapticFeedback.heavyImpact();
                  }
                },
                child: const Text('Sair')),
            backgroundColor: const Color.fromARGB(255, 240, 240, 240),
            content: GestureDetector(
                onTap: () {
                  if (isAccessibilityEnabled) {
                    ttsService
                        .speak('Você realmente deseja sair do aplicativo?');
                    HapticFeedback.heavyImpact();
                  }
                },
                child: const Text('Você realmente deseja sair do aplicativo?')),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      if (isAccessibilityEnabled) {
                        Get.back();
                        HapticFeedback.heavyImpact();
                      }
                    },
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      isAccessibilityEnabled
                          ? ttsService
                              .speak('Dê um duplo clique para continuar no app')
                          : Get.back();
                    },
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
                    onDoubleTap: () {
                      if (isAccessibilityEnabled) {
                        logOut(context);
                        HapticFeedback.heavyImpact();
                      }
                    },
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      isAccessibilityEnabled
                          ? ttsService.speak('Dê um duplo clique para sair')
                          : logOut(context);
                    },
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
        });
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
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const [
          HomePage(),
          SearchPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
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
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: const Icon(Icons.logout),
              onTap: () {
                _popUp(context);
                HapticFeedback.heavyImpact();
                if (isAccessibilityEnabled) {
                  readOptions(2);
                }
              },
            ),
            label: 'Sair',
          )
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
