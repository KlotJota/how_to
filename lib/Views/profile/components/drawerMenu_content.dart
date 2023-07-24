import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../login/user_login.dart';

class DrawerMenuContent extends StatelessWidget {
  const DrawerMenuContent({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    void logOut(BuildContext context) async {
      try {
        await auth.signOut();
        Get.offAll(UserLoginPage());
      } catch (e) {
        print(e);
      }
    }

    void _popUp(context) {
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

    return SafeArea(
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
                        Border.all(color: Color.fromARGB(255, 250, 247, 247))),
                margin: EdgeInsets.only(bottom: 10),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(auth.currentUser!.photoURL.toString()),
                  radius: 50,
                ),
              ),
              Text(auth.currentUser!.displayName.toString(),
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                      color: Color.fromARGB(255, 250, 247, 247))),
              Text(
                auth.currentUser!.email.toString(),
                style: TextStyle(color: Color.fromARGB(255, 250, 247, 247)),
              ),
            ],
          ),
        ),
        InkWell(
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
          onTap: () => _popUp(context),
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
    ));
  }
}
