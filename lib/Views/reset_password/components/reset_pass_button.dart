import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/reset_password/components/singleton.dart';

class ResetPassButton extends StatelessWidget {
  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

  void redefinirSenha(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: SingletonResetPass.controller.emailController.text);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: GestureDetector(
                  onTap: () {
                    if (isAccessibilityEnabled) {
                      ttsService.speak(
                          "Um e-mail de redefinição de senha foi enviado para ${SingletonResetPass.controller.emailController.text}.");
                      HapticFeedback.heavyImpact();
                    }
                  },
                  child: Text(
                      "Um e-mail de redefinição de senha foi enviado para ${SingletonResetPass.controller.emailController.text}."),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        HapticFeedback.heavyImpact();
                      },
                      child: const Text("Ok"))
                ],
              ));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: GestureDetector(
              onTap: () {
                if (isAccessibilityEnabled) {
                  ttsService.speak('Erro ao redefinir senha');
                  HapticFeedback.heavyImpact();
                }
              },
              child: const Text('Erro ao edefinir Senha')),
          content: GestureDetector(
            onTap: () {
              if (isAccessibilityEnabled) {
                ttsService.speak(
                    'Ocorreu um erro ao enviar o e-mail de redefinição de senha. Por favor, verifique o e-mail e tente novamente.');
                HapticFeedback.heavyImpact();
              }
            },
            child: const Text(
                'Ocorreu um erro ao enviar o e-mail de redefinição de senha. Por favor, verifique o e-mail e tente novamente.'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                HapticFeedback.heavyImpact();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        if (isAccessibilityEnabled) {
          redefinirSenha(context);
          HapticFeedback.heavyImpact();
        }
      },
      onTap: () {
        HapticFeedback.heavyImpact();
        isAccessibilityEnabled
            ? ttsService.speak(
                'Dê um duplo clique para enviar instruções para seu email!')
            : redefinirSenha(context);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width - 50,
        height: 40,
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 9, 89, 1),
            borderRadius: BorderRadius.circular(5)),
        child: const Text(
          'Enviar',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 250, 250, 250),
          ),
        ),
      ),
    );
  }
}
