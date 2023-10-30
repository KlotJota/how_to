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

  void toggleAccessibility() {
    AccessibilitySettings().toggleAccessibility();
    setState(() {
      isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
    });
    Get.offAll(UserLoginPage());
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
                      onTap: () {
                        toggleAccessibility();
                        isAccessibilityEnabled
                            ? ttsService.speak('Modo de acessibilidade ativado')
                            : null;
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
