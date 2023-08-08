import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/changeProfile/changeProfile_page.dart';

import '../../login/user_login.dart';

class DrawerMenuContent extends StatefulWidget {
  const DrawerMenuContent({Key? key}) : super(key: key);

  @override
  State<DrawerMenuContent> createState() => _DrawerMenuContentState();
}

class _DrawerMenuContentState extends State<DrawerMenuContent>
    with SingleTickerProviderStateMixin {
  String user =
      'https://firebasestorage.googleapis.com/v0/b/howto-60459.appspot.com/o/perfis%2Fpadr%C3%A3o%2Fuser.png?alt=media&token=bb4a0f5c-8839-400d-8fb3-dbaaf07b3117';
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
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

    void logOut(BuildContext context) async {
      try {
        await auth.signOut();
        Get.offAll(const UserLoginPage());
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
            titlePadding: const EdgeInsets.all(5),
            title: const Text('Sair'),
            backgroundColor: const Color.fromARGB(255, 240, 240, 240),
            content: const Text('Você realmente deseja sair do aplicativo?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 80,
                      child: const Text(
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
                          color: const Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 80,
                      child: const Text(
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

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            color: const Color.fromRGBO(0, 9, 89, 1),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color.fromARGB(255, 250, 247, 247)),
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: _startAnimation,
                    child: RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                        child: auth.currentUser!.photoURL == null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(user),
                                radius: 50,
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                  auth.currentUser!.photoURL.toString(),
                                ),
                                radius: 50)),
                  ),
                ),
                const Text('olá,',
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color.fromARGB(255, 250, 247, 247))),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: auth.currentUser!.isAnonymous
                      ? Text('Usuário',
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 20,
                              color: Color.fromARGB(255, 250, 247, 247)))
                      : Text(auth.currentUser!.displayName.toString(),
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 20,
                              color: Color.fromARGB(255, 250, 247, 247))),
                ),
                auth.currentUser!.isAnonymous
                    ? Container()
                    : Text(
                        auth.currentUser!.email.toString(),
                        style: const TextStyle(
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
            child: const Padding(
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
          const Divider(height: 10, thickness: 1),
          InkWell(
            onTap: () {
              // _popUpAlteraUser(context);
            },
            child: const Padding(
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
          const Divider(height: 10, thickness: 1),
          auth.currentUser!.isAnonymous
              ? Container()
              : InkWell(
                  onTap: () {
                    Get.to(() => ChangeProfilePage());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Icon(Icons.edit, size: 30),
                        ),
                        Expanded(
                            flex: 3,
                            child: Text(
                              "Alterar perfil",
                              style: TextStyle(fontSize: 16),
                            )),
                      ],
                    ),
                  ),
                ),
          auth.currentUser!.isAnonymous
              ? Container()
              : const Divider(height: 10, thickness: 1),
          InkWell(
            onTap: () => _popUpLogout(context),
            child: const Padding(
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
