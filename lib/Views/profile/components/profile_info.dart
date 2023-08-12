import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../changeProfile/changeProfile_page.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => ProfileInfoState();
}

class ProfileInfoState extends State<ProfileInfo> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 10),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(auth.currentUser!.photoURL.toString()),
                radius: 50,
              )),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              child: auth.currentUser!.displayName == null
                  ? const Text(
                      'Usuário',
                      style: TextStyle(fontSize: 18),
                    )
                  : Text(
                      auth.currentUser!.displayName.toString(),
                      style: const TextStyle(fontSize: 18),
                    )),
          GestureDetector(
            onTap: () => Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width - 250,
              height: MediaQuery.of(context).size.width - 330,
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(2)),
              child: Text('Alterar perfil'),
            ),
          )
        ],
      ),
    );
  }
}
