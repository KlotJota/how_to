import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/register/components/register-form.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  XFile? pickedFile;
  String? imageUrl;

  Future<void> pegaImagem() async {
    final ImagePicker picker = ImagePicker();
    try {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void adicionaImagem() async {
    if (pickedFile != null) {
      File imageFile = File(pickedFile!.path);

      String imagemRef =
          "perfis/personalizado/${auth.currentUser?.uid}/img-${DateTime.now().toString()}.jpg";
      Reference storageRef = FirebaseStorage.instance.ref().child(imagemRef);
      await storageRef.putFile(imageFile);

      // Obter URL da imagem
      imageUrl = await storageRef.getDownloadURL();

      await auth.currentUser!.updatePhotoURL(imageUrl);
    }
  }

  void _popUpImagem(context) async {
    await pegaImagem();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          titlePadding: const EdgeInsets.all(5),
          title: const Text('Escolher imagem'),
          backgroundColor: const Color.fromARGB(255, 240, 240, 240),
          content: pickedFile == null
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      pegaImagem();
                    });
                  },
                  child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 243, 243),
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 112, 112, 112)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(child: const Icon(Icons.add)),
                          const Text("Selecione uma imagem"),
                        ],
                      )))
              : SizedBox(
                  width: 200,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(pickedFile!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                      'Fechar',
                      style: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await Future.delayed(Duration.zero)
                        .then((_) => adicionaImagem());
                    Get.back();

                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 9, 89, 1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.only(top: 5),
                    height: 30,
                    width: 80,
                    child: const Text(
                      'Adicionar ',
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color.fromARGB(255, 243, 243, 243),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                  onTap: () {
                    _popUpImagem(context);
                  },
                  child: CircleAvatar(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(96, 0, 0, 0),
                      ),
                      child: Icon(Icons.photo, size: 30),
                    ),
                    backgroundImage:
                        NetworkImage(auth.currentUser!.photoURL.toString()),
                    radius: 50,
                  )),
            ),
            const Divider(height: 10, thickness: 1),
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
          ]),
        ),
      ),
    );
  }
}
