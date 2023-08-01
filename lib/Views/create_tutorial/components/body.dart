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
  const Body({super.key});

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
                titlePadding: const EdgeInsets.all(5),
                title: const Text('Sucesso'),
                backgroundColor: const Color.fromARGB(255, 240, 240, 240),
                content: const Text(
                    'Seu novo tutorial foi criado e já pode ser conferido no aplicativo.'),
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
      return const Color.fromRGBO(0, 9, 89, 1);
    }
    return const Color.fromRGBO(0, 9, 89, 1);
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
          titlePadding: const EdgeInsets.all(5),
          title: const Text('Escolher imagem'),
          backgroundColor: const Color.fromARGB(255, 240, 240, 240),
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
            titlePadding: const EdgeInsets.all(5),
            title: const Text('Sucesso'),
            backgroundColor: const Color.fromARGB(255, 250, 247, 247),
            content: const Text(
                'Novo tutorial criado com sucesso! Você já poderá vê-lo no app.'),
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
            titlePadding: const EdgeInsets.all(5),
            title: const Text('Erro'),
            backgroundColor: const Color.fromARGB(255, 250, 247, 247),
            content: const Text(
                'Você precisa preencher todos os campos para adicionar um novo tutorial'),
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
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ], color: const Color.fromARGB(255, 250, 247, 247)),
            child: Form(
              key: formKeyCreate,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: const Text(
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
                            margin: const EdgeInsets.only(bottom: 10),
                            width: MediaQuery.of(context).size.width - 150,
                            height: 45,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 243, 243, 243),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(left: 10, right: 5),
                                    child: const Icon(Icons.image_search)),
                                const Text(
                                  'Adicionar imagem',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width - 150,
                            height: 150,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(255, 112, 112, 112)),
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
                  const CreateForms(),
                  GestureDetector(
                      onTap: () {
                        criarTutorial(context);
                      },
                      child: const CreateButton()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
