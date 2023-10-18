import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/first_pages/first_page_anonymous.dart';
import 'package:how_to/Views/reset_password/reset-pass.dart';
import '../../first_pages/first_page.dart';

import '../../register/user-register.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String email = '';
  String password = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  var formKeyLogin = GlobalKey<FormState>();
  bool _passVisible = false;

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

  void login(BuildContext context) async {
    if (formKeyLogin.currentState!.validate()) {
      formKeyLogin.currentState!.save();
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);

        Get.offAll(const FirstPage());
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.message ==
              'The password is invalid or the user does not have a password.') {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    elevation: 10,
                    titlePadding: const EdgeInsets.all(5),
                    title: const Text('Erro'),
                    backgroundColor: const Color.fromARGB(255, 248, 246, 246),
                    content: const Text('Login ou senha inválidos'),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 9, 89, 1),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.only(top: 5),
                              height: 30,
                              width: 80,
                              child: const Text(
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
      Get.offAll(const FirstPageAnonymous());
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 10,
              titlePadding: const EdgeInsets.all(5),
              title: const Text('Erro'),
              backgroundColor: const Color.fromARGB(255, 250, 247, 247),
              content: Text(e.message.toString()),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 9, 89, 1),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.only(top: 5),
                        height: 30,
                        width: 80,
                        child: const Text(
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
                margin: const EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width - 120,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onTap: () {
                    isAccessibilityEnabled
                        ? ttsService.speak('Insira seu email')
                        : null;
                  },
                  onSaved: (value) => email = value!,
                  validator: (value) {
                    if (!RegExp(r'^.+@[a-zA-Z]+.{1}[a-zA-Z]+(.{0,1}[a-zA-Z]+)$')
                            .hasMatch(value!) &&
                        value.isNotEmpty) {
                      return ('Por favor, insira um email válido.');
                    } else if (value.isEmpty) {
                      return ('Por favor, insira um email.');
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(),
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email),
                    hintText: 'email@exemplo.com',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width - 120,
                child: TextFormField(
                  obscureText: !_passVisible,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onTap: () {
                    isAccessibilityEnabled
                        ? ttsService.speak('Insira sua senha')
                        : null;
                  },
                  onSaved: (value) => password = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ('Por favor, insira uma senha.');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 2),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        if (isAccessibilityEnabled) {
                          _passVisible
                              ? ttsService.speak('Senha invisível')
                              : ttsService.speak('Senha visível');
                        }
                        setState(() {
                          _passVisible = !_passVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 15),
                child: GestureDetector(
                    child: Text(
                      "Esqueceu sua senha?",
                      style: TextStyle(
                        fontSize: isAccessibilityEnabled ? 20 : 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onDoubleTap: () {
                      isAccessibilityEnabled
                          ? Get.to(() => resetPassPage())
                          : null;
                    },
                    onTap: () {
                      isAccessibilityEnabled
                          ? ttsService.speak('Esqueceu sua senha?')
                          : Get.to(() => resetPassPage());
                    }),
              ),
              GestureDetector(
                onDoubleTap: () {
                  isAccessibilityEnabled ? login(context) : null;
                },
                onTap: () {
                  isAccessibilityEnabled
                      ? ttsService.speak('Entrar com suas credenciais')
                      : login(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width - 120,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 9, 89, 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '  ou  ',
                              style: TextStyle(
                                  fontSize: isAccessibilityEnabled ? 20 : 14),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onDoubleTap: () {
                  isAccessibilityEnabled ? anonimous(context) : null;
                },
                onTap: () {
                  isAccessibilityEnabled
                      ? ttsService.speak('Entrar como anônimo')
                      : anonimous(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width - 120,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 172, 172, 172),
                      borderRadius: BorderRadius.circular(5)),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle_rounded),
                      Text(
                        ' Entrar como convidado',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      isAccessibilityEnabled
                          ? Get.to(() => const UserRegisterPage(),
                              transition: Transition.rightToLeftWithFade)
                          : null;
                    },
                    onTap: () {
                      isAccessibilityEnabled
                          ? ttsService.speak(
                              'Se deseja criar uma conta no RauTiu, dê um duplo clique')
                          : null;
                    },
                    child: Text(
                      'Primeira vez no How To? ',
                      style:
                          TextStyle(fontSize: isAccessibilityEnabled ? 20 : 14),
                    ),
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      isAccessibilityEnabled
                          ? Get.to(() => const UserRegisterPage(),
                              transition: Transition.rightToLeftWithFade)
                          : null;
                    },
                    onTap: () {
                      isAccessibilityEnabled
                          ? ttsService.speak(
                              'Se desejar criar uma conta no RauTiu, dê um duplo clique')
                          : Get.to(const UserRegisterPage(),
                              transition: Transition.rightToLeftWithFade);
                    },
                    child: Text(
                      'Criar conta',
                      style: TextStyle(
                          fontSize: isAccessibilityEnabled ? 20 : 14,
                          color: isAccessibilityEnabled
                              ? null
                              : Color.fromRGBO(0, 9, 89, 1),
                          decoration: isAccessibilityEnabled
                              ? null
                              : TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
