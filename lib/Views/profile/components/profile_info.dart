import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class ProfileInfo extends StatefulWidget {
  @override
  State<ProfileInfo> createState() => ProfileInfoState();
}

class ProfileInfoState extends State<ProfileInfo> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  XFile? perfil;

  Future<void> pegaImagem() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      String imagemRef =
          "perfis/personalizado/${auth.currentUser?.uid}/img-${DateTime.now().toString()}.jpg";
      Reference storageRef = FirebaseStorage.instance.ref().child(imagemRef);
      await storageRef.putFile(imageFile);

      // Obter URL da imagem
      String imageUrl = await storageRef.getDownloadURL();

      await auth.currentUser!.updatePhotoURL(imageUrl);
    }
  }

  void popUpImagem() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: EdgeInsets.all(5),
            title: Text('Imagem de perfil'),
            backgroundColor: Color.fromARGB(255, 250, 247, 247),
            content: Text('Deseja Adicionar/alterar sua imagem de perfil?'),
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
                    onTap: () {
                      pegaImagem();
                      Get.back();
                    },
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 40),
            child: GestureDetector(
              onTap: () {
                popUpImagem();
              },
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(auth.currentUser!.photoURL.toString()),
                radius: 40,
              ),
            )),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10),
            child: auth.currentUser!.displayName == null
                ? Text(
                    'Usuário',
                    style: TextStyle(fontSize: 18),
                  )
                : Text(
                    auth.currentUser!.displayName.toString(),
                    style: TextStyle(fontSize: 18),
                  )),
      ],
    );
  }
}
