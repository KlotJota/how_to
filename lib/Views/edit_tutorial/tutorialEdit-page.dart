import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/edit_tutorial/components/controllers.singleton.dart';
import 'package:how_to/Views/edit_tutorial/components/edit_category.dart';
import 'package:how_to/Views/edit_tutorial/components/edit_text.dart';
import 'package:how_to/Views/edit_tutorial/components/edit_title.dart';
import 'package:how_to/Views/edit_tutorial/components/update_button.dart';

import 'package:image_picker/image_picker.dart';

import '../first_pages/first_page.dart';

class TutorialEditPage extends StatefulWidget {
  final String id;
  TutorialEditPage(this.id);

  @override
  State<TutorialEditPage> createState() => _TutorialEditPage();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class _TutorialEditPage extends State<TutorialEditPage> {
  var formKeyEdit = GlobalKey<FormState>();
  DocumentSnapshot<Object?>? tutorial;

  String titulo = ControllersSingleton.controllers.tituloController.text;
  String texto = ControllersSingleton.controllers.textoController.text;
  String categoria = ControllersSingleton.controllers.categoriaController.text;
  String? imagem = ControllersSingleton.controllers.imagem.text;
  XFile? pickedFile;

  @override
  void initState() {
    super.initState();
    buscarTutorial();
  }

  void buscarTutorial() async {
    final tutorialDoc = await FirebaseFirestore.instance
        .collection('tutoriais')
        .doc(widget.id)
        .get();
    setState(() {
      tutorial = tutorialDoc;

      if (tutorial != null) {
        final tutorialData = tutorial!.data() as Map<String, dynamic>;
        setState(() {
          imagem = tutorialData['imagem'];
        });
        titulo = tutorialData['titulo'];
        categoria = tutorialData['categoria'];
        texto = tutorialData['texto'];
      }
    });
  }

  void editarTutorial(BuildContext context) async {
    try {
      var updateData = <String, dynamic>{};

      if (pickedFile != null) {
        File imageFile = File(pickedFile!.path);

        String imagemRef = "imagens/img-${DateTime.now().toString()}.jpg";
        Reference storageRef = FirebaseStorage.instance.ref().child(imagemRef);
        await storageRef.putFile(imageFile);

        // Obter URL da imagem
        String imageUrl = await storageRef.getDownloadURL();

        setState(() {
          if (imageUrl.isNotEmpty) {
            ControllersSingleton.controllers.imagem.text = imageUrl;
          }
        });
      }

      if (ControllersSingleton.controllers.tituloController.text.isNotEmpty) {
        updateData['titulo'] =
            ControllersSingleton.controllers.tituloController.text;
      }

      if (ControllersSingleton.controllers.textoController.text.isNotEmpty) {
        updateData['texto'] =
            ControllersSingleton.controllers.textoController.text;
      }

      if (ControllersSingleton.controllers.imagem!.text.isNotEmpty) {
        updateData['imagem'] = ControllersSingleton.controllers.imagem.text;
      }

      if (ControllersSingleton
          .controllers.categoriaController.text.isNotEmpty) {
        updateData['categoria'] =
            ControllersSingleton.controllers.categoriaController.text;
      }

      if (updateData.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('tutoriais')
            .doc(tutorial!.id)
            .update(updateData);
      }
      _popUpSucesso(context);
    } catch (e) {
      print('Erro ao atualizar tutorial $e');
    }
  }

  Future<void> pegaImagem() async {
    final ImagePicker picker = ImagePicker();
    try {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() => pickedFile);
      }
    } catch (e) {
      print(e);
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
            backgroundColor: Color.fromARGB(255, 240, 240, 240),
            content: Text(
                'Seu tutorial foi atualizado e já pode ser conferido no aplicativo.'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.offAll(FirstPage()),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
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
                    key: formKeyEdit,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: GestureDetector(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.arrow_back_outlined,
                              color: Color.fromRGBO(0, 9, 89, 1),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                          child: Text(
                            "Atualizar Tutorial",
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                        GestureDetector(
                            onTap: () => _popUpImagem(context),
                            child: Container(
                              width: MediaQuery.of(context).size.width - 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 112, 112, 112)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(imagem.toString(),
                                    fit: BoxFit.cover),
                              ),
                            )),
                        EditTitle(widget.id),
                        EditCategory(widget.id),
                        EditText(widget.id),
                        GestureDetector(
                          onTap: () {
                            editarTutorial(context);
                          },
                          child: UpdateButton(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
