import 'package:flutter/material.dart';
import 'package:how_to/Views/first_page.dart';
import 'package:how_to/Views/first_page_anonymous.dart';
import 'package:how_to/Views/reset-pass.dart';
import 'package:how_to/Views/user-register.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLoginPage extends StatelessWidget {
  var logo = 'howto_logo1.png';

  String email = '';
  String password = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  var formKeyLogin = GlobalKey<FormState>();

  void login(BuildContext context) async {
    if (formKeyLogin.currentState!.validate()) {
      formKeyLogin.currentState!.save();
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);

        Get.to(FirstPage());
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.message ==
              'The password is invalid or the user does not have a password.') {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    elevation: 10,
                    titlePadding: EdgeInsets.all(5),
                    title: Text('Erro'),
                    backgroundColor: Color.fromARGB(255, 248, 246, 246),
                    content: Text('Login ou senha inválidos'),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 9, 89, 1),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.only(top: 5),
                              height: 30,
                              width: 80,
                              child: Text(
                                'Ok',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                });
          }
        }
      }
    }
  }

  void anonimous(BuildContext context) async {
    try {
      await auth.signInAnonymously();
      Get.to(FirstPageAnonymous());
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 10,
              titlePadding: EdgeInsets.all(5),
              title: Text('Erro'),
              backgroundColor: Color.fromARGB(255, 250, 247, 247),
              content: Text(e.message.toString()),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 9, 89, 1),
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.only(top: 5),
                        height: 30,
                        width: 80,
                        child: Text(
                          'Ok',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKeyLogin,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        scale: 19,
                        alignment: Alignment.topCenter,
                        image: AssetImage('images/how-to-branco.png'))),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 9, 89, 1),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                    color: Color.fromARGB(255, 250, 247, 247)),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 64, 30, 30),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 60),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width - 200,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (value) => email = value!,
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
                          labelText: 'E-mail',
                          prefixIcon: Icon(Icons.email),
                          hintText: 'email@exemplo.com',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width - 200,
                      child: TextFormField(
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (value) => password = value!,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('Por favor, insira uma senha.');
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Senha',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, top: 15),
                      child: GestureDetector(
                          child: Text(
                            "Esqueceu sua senha?",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 9, 89, 1)),
                          ),
                          onTap: () {
                            Get.to(resetPassPage());
                          }),
                    ),
                    GestureDetector(
                      onTap: () => login(context),
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
                        Stack(
                          children: [
                            Container(
                              child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  alignment: Alignment.center,
                                  child: Text('  ou  ')),
                              width: MediaQuery.of(context).size.width - 200,
                              decoration: BoxDecoration(
                                  border: BorderDirectional(
                                      top: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 223, 223, 223)))),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => anonimous(context),
                      child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        width: MediaQuery.of(context).size.width - 120,
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
                            Get.to(UserRegisterPage(),
                                transition: Transition.rightToLeftWithFade);
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
      ),
    );
  }
}
