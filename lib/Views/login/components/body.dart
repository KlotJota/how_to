import 'package:flutter/material.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/login/components/login_form.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/login/user_login.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;

  TtsService ttsService = TtsService();

  String popUp =
      'Você acaba de ativar as ferramentas de acessibilidade, com isso, todos os botões e objetos clicáveis poderão ser acessados com dois cliques rápidos, enquanto um clique faz com que o narrador diga em voz alta o conteúdo do botão ou card de tutorial. Um clique em qualquer texto fara com que o narrador tabém leia em voz alta, e por fim, um clique segurado nos cards de tutorial abrirão a tela de detecção facial, onde você poderá ouvir o tutorial apenas mantendo seu rosto em frente a câmera.';

  void toggleAccessibility() {
    AccessibilitySettings().toggleAccessibility();
    setState(() {
      isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
    });
    Get.offAll(UserLoginPage());
  }

  void popUpAcessibility() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: const EdgeInsets.all(5),
            title: GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  ttsService.speak('Acessibilidade ativada');
                },
                child: const Text('Acessibilidade ativada')),
            content: GestureDetector(
              onTap: () {
                if (isAccessibilityEnabled) {
                  HapticFeedback.heavyImpact();
                  ttsService.speak(popUp);
                }
              },
              child: Text(
                popUp,
                textAlign: TextAlign.justify,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      if (isAccessibilityEnabled) {
                        Get.back();
                        ttsService.dispose();
                        HapticFeedback.heavyImpact();
                      }
                    },
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      isAccessibilityEnabled
                          ? ttsService.speak('Dê um duplo clique para fechar')
                          : Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 80,
                      child: const Text(
                        'Ok',
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(30, 64, 30, 30),
                child: GestureDetector(
                  onTap: () {
                    if (isAccessibilityEnabled) {
                      ttsService.speak('Login');
                      HapticFeedback.heavyImpact();
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
              const LoginForm(),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        toggleAccessibility();

                        if (isAccessibilityEnabled) {
                          popUpAcessibility();
                          await Future.delayed(Duration(seconds: 1));
                          ttsService.speak('Acessibilidade ativada.$popUp');
                        }
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: isAccessibilityEnabled
                                ? Color.fromRGBO(0, 9, 89, 1)
                                : null,
                            border: Border.all(width: 1, color: Colors.black)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: isAccessibilityEnabled
                          ? GestureDetector(
                              onTap: () {
                                ttsService
                                    .speak('Desativar modo acessibilidade');
                              },
                              child: Text(
                                "Desativar modo acessibilidade",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          : Text(
                              'Ativar modo acessibilidade',
                              style: TextStyle(fontSize: 14),
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
