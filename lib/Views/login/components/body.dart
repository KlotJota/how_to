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
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 8,
              blurRadius: 10,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ], color: const Color.fromARGB(255, 250, 247, 247)),
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
