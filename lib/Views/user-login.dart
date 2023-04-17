import 'package:flutter/material.dart';
import 'package:how_to/Views/user-register.dart';
import 'package:get/get.dart';

class UserLoginPage extends StatelessWidget {
  var logo = 'howto_logo1.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color.fromRGBO(0, 9, 89, 1),
          ),
          Positioned(
            top: 70,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 8,
                      blurRadius: 10,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Color.fromARGB(255, 240, 240, 240)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(
                            Icons.arrow_back_outlined,
                            color: Color.fromRGBO(0, 9, 89, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 70),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 200,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (!RegExp(r'^.+@[a-zA-Z]+.{1}[a-zA-Z]+(.{0,1}[a-zA-Z]+)$')
                                .hasMatch(value!) &&
                            value.isNotEmpty) {
                          return ('Por favor, insira um email válido.');
                        } else if (value!.isEmpty) {
                          return ('Por favor, insira um email.');
                        }
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 9, 89, 1),
                                  width: 2)),
                          labelText: "E-mail",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3))),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 200,
                    height: 10,
                    // gambiarra, não mexer
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 200,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ('Por favor, insira uma senha.');
                        }
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 9, 89, 1),
                                  width: 2)),
                          labelText: "Senha",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                          )),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 200,
                    height: 50,
                    // gambiarra, não mexer
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/user_register'),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 200,
                      height: 40,
                      padding: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Entrar',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 200,
                    height: 40,
                    // gambiarra, não mexer
                  ),
                  GestureDetector(
                    onTap: () =>
                        Get.to(UserRegisterPage(), transition: Transition.zoom),
                    child: Container(
                      child: Text(
                        'Criar conta',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 9, 89, 1),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
