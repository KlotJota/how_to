import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../register/user-register.dart';
import 'package:get/get.dart';

class ProfilePanel extends StatefulWidget {
  @override
  State<ProfilePanel> createState() => _ProfilePanelState();
}

class _ProfilePanelState extends State<ProfilePanel> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String user =
      'https://firebasestorage.googleapis.com/v0/b/howto-60459.appspot.com/o/perfis%2Fpadr%C3%A3o%2Fuser.png?alt=media&token=bb4a0f5c-8839-400d-8fb3-dbaaf07b3117';

  void popUpRegister() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: EdgeInsets.all(5),
            title: Text('Criar conta'),
            backgroundColor: Color.fromARGB(255, 250, 247, 247),
            content: Text(
              'Você pode criar uma conta para ter acesso a sua página de perfil',
            ),
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
                        'Fechar',
                        style: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(UserRegisterPage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.only(top: 5),
                      height: 30,
                      width: 85,
                      child: Text(
                        'Criar conta',
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (auth.currentUser!.displayName == null) {
          popUpRegister();
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: auth.currentUser!.photoURL == null
                        ? CircleAvatar(backgroundImage: NetworkImage(user))
                        : CircleAvatar(
                            backgroundImage: NetworkImage(
                                auth.currentUser!.photoURL.toString()),
                          )),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, bottom: 2),
                        child: Text(
                          'Bem vindo!',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          child: auth.currentUser!.isAnonymous
                              ? Text('Usuário')
                              : Text(auth.currentUser!.displayName.toString(),
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ))),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
