import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/reset_password/components/singleton.dart';

class SendMailForm extends StatelessWidget {
  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_outlined,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: const Image(
            image: NetworkImage(
              "https://cdn-icons-png.flaticon.com/512/6357/6357048.png",
            ),
            fit: BoxFit.contain,
            width: 200,
            height: 200,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 12),
          child: GestureDetector(
            onTap: () {
              isAccessibilityEnabled
                  ? ttsService.speak('Esqueceu sua senha?')
                  : null;
            },
            child: const Text(
              "Esqueceu sua senha?",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Wrap(children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                isAccessibilityEnabled
                    ? ttsService.speak(
                        'Se você esqueceu sua senha, não se preocupe! Podemos ajudá-lo a recuperar o acesso à sua conta.')
                    : null;
              },
              child: Text(
                "Se você esqueceu sua senha, não se preocupe! Podemos ajudá-lo a recuperar o acesso à sua conta.",
                style: TextStyle(fontSize: isAccessibilityEnabled ? 20 : 13),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ]),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width - 50,
          child: TextFormField(
            onTap: () {
              isAccessibilityEnabled
                  ? ttsService.speak('Insira seu email cadastrado no app')
                  : null;
            },
            controller: SingletonResetPass.controller.emailController,
            decoration: const InputDecoration(
              labelText: 'E-mail',
              prefixIcon: Icon(Icons.email),
            ),
          ),
        ),
      ],
    );
  }
}
