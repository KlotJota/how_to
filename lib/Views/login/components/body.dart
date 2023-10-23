import 'package:flutter/material.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/login/components/login_form.dart';
import 'package:flutter/services.dart';

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
              const LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
