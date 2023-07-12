import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/edit_tutorial/components/controllers.singleton.dart';
import 'package:how_to/Views/create_tutorial/components/create_button.dart';
import 'package:how_to/Views/create_tutorial/components/create_forms.dart';
import 'package:image_picker/image_picker.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var formKeyCreate = GlobalKey<FormState>();
  XFile? pickedFile;

  void criarTutorial(BuildContext context) async {
    if (formKeyCreate.currentState!.validate()) {
      String titulo = CreateController().titulo.text;
      String texto = CreateController().texto.text;
      String categoria = CreateController().categoria.text;
      try {
        if (pickedFile != null) {
          File imageFile = File(pickedFile!.path);

          String imagemRef = "imagens/img-${DateTime.now().toString()}.jpg";
          Reference storageRef =
              FirebaseStorage.instance.ref().child(imagemRef);
          await storageRef.putFile(imageFile);

          // Obter URL da imagem
          String imageUrl = await storageRef.getDownloadURL();

          setState(() {
            if (imageUrl.isNotEmpty) {
              ControllersSingleton.controllers.imagem.text = imageUrl;
            }
          });
        }

        CollectionReference collection =
            FirebaseFirestore.instance.collection('tutoriais');
        Map<String, dynamic> tutoriais = {
          'titulo': titulo,
          'texto': texto,
          'imagem': ControllersSingleton.controllers.imagem.text,
          'categoria': categoria,
          'criação': DateTime.now().toString(),
          'qtdFavoritos': 1
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

  Future<void> pegaImagem() async {
    final ImagePicker picker = ImagePicker();
    try {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void _popUpImagem(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 10,
          titlePadding: EdgeInsets.all(5),
          title: Text('Escolher imagem'),
          backgroundColor: Color.fromARGB(255, 240, 240, 240),
          content: pickedFile == null
              ? GestureDetector(
                  onTap: () {
                    pegaImagem();
                    Get.back();
                  },
                  child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 243, 243),
                          border: Border.all(
                              width: 1,
                              color: Color.fromARGB(255, 112, 112, 112)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(child: Icon(Icons.add)),
                          Text("Selecione uma imagem"),
                        ],
                      )))
              : Container(
                  width: 200,
                  height: 150,
                  child: GestureDetector(
                    onTap: () {
                      pegaImagem();
                      Get.back();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(pickedFile!.path),
                        fit: BoxFit.cover,
                      ),
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
      },
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _popUpImagem(context);
                    },
                    child: pickedFile == null
                        ? Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: MediaQuery.of(context).size.width - 150,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 243, 243, 243),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: 10, right: 5),
                                    child: Icon(Icons.image_search)),
                                Text(
                                  'Adicionar imagem',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            alignment: Alignment.centerLeft,
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width - 150,
                            height: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: Color.fromARGB(255, 112, 112, 112)),
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(pickedFile!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  CreateForms(),
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
      ),
    );
  }
}
