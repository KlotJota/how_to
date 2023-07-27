import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../login/user_login.dart';

class DrawerMenuContent extends StatefulWidget {
  const DrawerMenuContent({Key? key}) : super(key: key);

  @override
  State<DrawerMenuContent> createState() => _DrawerMenuContentState();
}

class _DrawerMenuContentState extends State<DrawerMenuContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });

    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    DateTime dataAtual = DateTime.now();
    String dataFormatada = dataAtual.toString();

    TextEditingController novoNomeController = TextEditingController();

    void logOut(BuildContext context) async {
      try {
        await auth.signOut();
        Get.offAll(UserLoginPage());
      } catch (e) {
        print(e);
      }
    }

    void _popUpLogout(context) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: EdgeInsets.all(5),
            title: Text('Sair'),
            backgroundColor: Color.fromARGB(255, 240, 240, 240),
            content: Text('Você realmente deseja sair do aplicativo?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      height: 30,
                      width: 80,
                      child: Text(
                        'Não',
                        style: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => logOut(context),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.only(top: 5),
                      height: 30,
                      width: 80,
                      child: Text(
                        'Sim',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      );
    }

    void alteraUser(BuildContext context) async {
      await FirebaseFirestore.instance
          .collection('tempoAlteraNome')
          .doc(auth.currentUser!.uid)
          .set({"Tempo": dataFormatada});

      try {
        await auth.currentUser!.updateDisplayName(novoNomeController.text);
        await auth.currentUser!.reload();
      } catch (e) {
        print("deu certo nn kkkk");
      }
    }

    void _popUpAlteraUser(context) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: EdgeInsets.all(5),
            title: Text('Alterar nome'),
            backgroundColor: Color.fromARGB(255, 240, 240, 240),
            content: Text(
                'Você realmente deseja alterar seu nome de usuário? Você só pode realizar essa ação a cada 10 dias'),
            actions: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width - 120,
                    child: TextFormField(
                      controller: novoNomeController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(0, 9, 89, 1), width: 2),
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Novo nome de usuário",
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Você precisa inserir seu novo nome de usuário';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: EdgeInsets.only(top: 5),
                          margin: EdgeInsets.only(top: 10),
                          height: 30,
                          width: 80,
                          child: Text(
                            'Cancelar',
                            style:
                                TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => alteraUser(context),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 9, 89, 1),
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.only(top: 5),
                          margin: EdgeInsets.only(top: 10),
                          height: 30,
                          width: 80,
                          child: Text(
                            'Salvar',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        },
      );
    }

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            color: Color.fromRGBO(0, 9, 89, 1),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: Color.fromARGB(255, 250, 247, 247)),
                  ),
                  margin: EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: _startAnimation,
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          auth.currentUser!.photoURL.toString(),
                        ),
                        radius: 50,
                      ),
                    ),
                  ),
                ),
                Text('olá,',
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color.fromARGB(255, 250, 247, 247))),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(auth.currentUser!.displayName.toString(),
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          color: Color.fromARGB(255, 250, 247, 247))),
                ),
                Text(
                  auth.currentUser!.email.toString(),
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Color.fromARGB(255, 250, 247, 247)),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed('/settings');
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Icon(Icons.settings, size: 30),
                  ),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "Configurações",
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
            ),
          ),
          Divider(height: 10, thickness: 1),
          InkWell(
            onTap: () {
              _popUpAlteraUser(context);
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Icon(Icons.draw, size: 30),
                  ),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "Alterar nome de usuário",
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
            ),
          ),
          Divider(height: 10, thickness: 1),
          InkWell(
            onTap: () => _popUpLogout(context),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Icon(Icons.logout, size: 30),
                  ),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "Sair",
                        style: TextStyle(fontSize: 16),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}