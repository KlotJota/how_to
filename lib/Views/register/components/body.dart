import 'package:flutter/material.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/register/components/register-form.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

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
                padding: const EdgeInsets.all(30),
                child: GestureDetector(
                  onTap: () {
                    ttsService.speak('Cadastro');
                  },
                  child: const Text(
                    "Cadastro",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
              const RegisterForm()
            ],
          ),
        ),
      ),
    );
  }
}
