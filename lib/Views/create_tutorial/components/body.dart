import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/create_tutorial/components/controllers.singleton.dart';
import 'package:how_to/Views/create_tutorial/components/create_button.dart';
import 'package:how_to/Views/create_tutorial/components/create_category.dart';
import 'package:how_to/Views/create_tutorial/components/create_image.dart';
import 'package:how_to/Views/create_tutorial/components/create_text.dart';
import 'package:how_to/Views/create_tutorial/components/create_title.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var formKeyCreate = GlobalKey<FormState>();

  void criarTutorial(BuildContext context) async {
    if (formKeyCreate.currentState!.validate()) {
      String titulo = ControllersSingleton().tituloController.text;
      String texto = ControllersSingleton().textoController.text;
      String categoria = ControllersSingleton().categoriaController.text;
      try {
        CollectionReference collection =
            FirebaseFirestore.instance.collection('tutoriais');
        Map<String, dynamic> tutoriais = {
          'titulo': titulo,
          'texto': texto,
          'imagem': ControllersSingleton.controllers.imagem,
          'categoria': categoria,
        };
        await collection.add(tutoriais);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                elevation: 10,
                titlePadding: EdgeInsets.all(5),
                title: Text('Sucesso'),
                backgroundColor: Color.fromARGB(255, 240, 240, 240),
                content: Text(
                    'Seu novo tutorial foi criado e já pode ser conferido no aplicativo.'),
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
                            'Fechar',
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
      } catch (e) {
        print('Erro ao adicionar tutorial $e');
      }
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Color.fromRGBO(0, 9, 89, 1);
    }
    return Color.fromRGBO(0, 9, 89, 1);
  }

  void _popUpSucesso(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: EdgeInsets.all(5),
            title: Text('Sucesso'),
            backgroundColor: Color.fromARGB(255, 250, 247, 247),
            content: Text(
                'Novo tutorial criado com sucesso! Você já poderá vê-lo no app.'),
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
                ],
              )
            ],
          );
        });
  }

  void _popUpFalha(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: EdgeInsets.all(5),
            title: Text('Erro'),
            backgroundColor: Color.fromARGB(255, 250, 247, 247),
            content: Text(
                'Você precisa preencher todos os campos para adicionar um novo tutorial'),
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
                ],
              )
            ],
          );
        });
  }

  Future<void> pegaImagem() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      String imagemRef = "imagens/img-${DateTime.now().toString()}.jpg";
      Reference storageRef = FirebaseStorage.instance.ref().child(imagemRef);
      await storageRef.putFile(imageFile);

      // Obter URL da imagem
      String imageUrl = await storageRef.getDownloadURL();

      setState(() {
        ControllersSingleton.controllers.imagem = imageUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Stack(
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
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 8,
                    blurRadius: 10,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ], color: Color.fromARGB(255, 250, 247, 247)),
                child: Form(
                  key: formKeyCreate,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          "Novo Tutorial",
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                      GestureDetector(onTap: pegaImagem, child: CreateImage()),
                      CreateTitle(),
                      CreateCategory(),
                      CreateText(),
                      GestureDetector(
                          onTap: () {
                            criarTutorial(context);
                          },
                          child: CreateButton()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
