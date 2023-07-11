import 'package:flutter/material.dart';
import 'package:how_to/Views/login/components/login_form.dart';

class Body extends StatelessWidget {
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
              offset: Offset(0, 2), // changes position of shadow
            ),
          ], color: Color.fromARGB(255, 250, 247, 247)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(30, 64, 30, 30),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
