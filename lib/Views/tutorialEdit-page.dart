import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/first_page.dart';

import 'package:image_picker/image_picker.dart';

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
  String? imagem;

  TextEditingController _tituloController = TextEditingController();
  TextEditingController _textoController = TextEditingController();
  TextEditingController _categoriaController = TextEditingController();

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
        _tituloController.text = tutorialData['titulo'];
        imagem = tutorialData['imagem'];
        _categoriaController.text = tutorialData['categoria'];
        _textoController.text = tutorialData['texto'];
      }
    });
  }

  void editarTutorial(BuildContext context) async {
    try {
      var updateData = <String, dynamic>{};

      if (_tituloController.text.isNotEmpty) {
        updateData['titulo'] = _tituloController.text;
      }

      if (_textoController.text.isNotEmpty) {
        updateData['texto'] = _textoController.text;
      }

      if (imagem!.isNotEmpty) {
        updateData['imagem'] = imagem;
      }

      if (_categoriaController.text.isNotEmpty) {
        updateData['categoria'] = _categoriaController.text;
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
        imagem = imageUrl;
      });
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _textoController.dispose();
    super.dispose();
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
            backgroundColor: Color.fromARGB(255, 240, 240, 240),
            content: Text(
                'Seu tutorial foi atualizado e já pode ser conferido no aplicativo.'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.to(FirstPage()),
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
      body: ListView(
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
                            style: TextStyle(fontSize: 50),
                          ),
                        ),
                        GestureDetector(
                            onTap: pegaImagem,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width - 150,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 243, 243, 243),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                      width: 1, color: Colors.black)),
                              child: Row(
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 5),
                                      child: Icon(Icons.image_search)),
                                  Text(
                                    'Adicionar imagem',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              alignment: Alignment.centerLeft,
                            )),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width - 150,
                          child: TextFormField(
                            controller: _tituloController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.title_sharp,
                              ),
                              labelText: "Titulo",
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          width: MediaQuery.of(context).size.width - 150,
                          child: TextFormField(
                            controller: _categoriaController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.category),
                              labelText: "Categoria",
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width - 150,
                          child: TextFormField(
                            maxLines: 4,
                            controller: _textoController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.text_fields_rounded),
                                labelText: "Texto",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            editarTutorial(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width - 150,
                            height: 40,
                            padding: EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 9, 89, 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Atualizar tutorial',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
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
    );
  }
}
