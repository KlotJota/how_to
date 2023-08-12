import 'package:flutter/material.dart';
import 'package:how_to/Views/login/components/login_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

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
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 50),
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
