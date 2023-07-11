import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/reset_password/reset-pass.dart';
import '../../first_pages/first_page.dart';
import '../../first_pages/first_page_anonymous.dart';
import '../../register/user-register.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String email = '';
  String password = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  var formKeyLogin = GlobalKey<FormState>();
  bool _passVisible = false;

  void login(BuildContext context) async {
    if (formKeyLogin.currentState!.validate()) {
      formKeyLogin.currentState!.save();
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);

        Get.offAll(FirstPage());
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
      Get.offAll(FirstPageAnonymous());
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
    return Form(
        key: formKeyLogin,
        child: Positioned(
          top: 70,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width - 120,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value) => email = value!,
                  validator: (value) {
                    if (!RegExp(r'^.+@[a-zA-Z]+.{1}[a-zA-Z]+(.{0,1}[a-zA-Z]+)$')
                            .hasMatch(value!) &&
                        value.isNotEmpty) {
                      return ('Por favor, insira um email válido.');
                    } else if (value.isEmpty) {
                      return ('Por favor, insira um email.');
                    }
                  },
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 9, 89, 1), width: 2),
                    ),
                    labelText: 'E-mail',
                    labelStyle: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Color.fromRGBO(0, 9, 89, 1),
                    hintText: 'email@exemplo.com',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width - 120,
                child: TextFormField(
                  obscureText: !_passVisible,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value) => password = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ('Por favor, insira uma senha.');
                    }
                  },
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 9, 89, 1), width: 2),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor: Color.fromRGBO(0, 9, 89, 1),
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passVisible = !_passVisible;
                        });
                      },
                    ),
                    suffixIconColor: Color.fromRGBO(0, 9, 89, 1),
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
                  width: MediaQuery.of(context).size.width - 120,
                  height: 50,
                  alignment: Alignment.center,
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
                            alignment: Alignment.center, child: Text('  ou  ')),
                        width: MediaQuery.of(context).size.width - 120,
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
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 221, 221, 221),
                      borderRadius: BorderRadius.circular(5)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle_rounded),
                      Text(
                        ' Entrar como convidado',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, color: Color.fromRGBO(0, 9, 89, 1)),
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
        ));
  }
}
