import 'package:flutter/material.dart';
import 'package:how_to/Views/home.dart';
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
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 70),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
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
                          label: Text('E-mail'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
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
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 340,
                        decoration: BoxDecoration(
                            border: BorderDirectional(
                                top: BorderSide(
                                    width: 1,
                                    color:
                                        Color.fromARGB(255, 223, 223, 223)))),
                      ),
                      Container(child: Text('  ou  ')),
                      Container(
                        width: MediaQuery.of(context).size.width - 340,
                        decoration: BoxDecoration(
                            border: BorderDirectional(
                                top: BorderSide(
                                    width: 1,
                                    color:
                                        Color.fromARGB(255, 223, 223, 223)))),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.to(HomePage()),
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      width: MediaQuery.of(context).size.width - 200,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 221, 221, 221),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.account_circle_rounded),
                          Text(
                            ' Entrar como convidado',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(0, 9, 89, 1)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Primeira vez no How To? ',
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(UserRegisterPage());
                        },
                        child: Text(
                          'Criar conta',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 9, 89, 1),
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
