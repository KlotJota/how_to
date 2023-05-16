import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/user-login.dart';

class CreateTutorialPage extends StatefulWidget {
  @override
  State<CreateTutorialPage> createState() => _CreateTutorialPage();
}

class _CreateTutorialPage extends State<CreateTutorialPage> {
  var formKey = GlobalKey<FormState>();

  TextEditingController _tituloController = TextEditingController();
  TextEditingController _textoController = TextEditingController();
  TextEditingController _imagemController = TextEditingController();
  TextEditingController _categoriaController = TextEditingController();

  void criarTutorial(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      String titulo = _tituloController.text;
      String texto = _textoController.text;
      String imagem = _imagemController.text;
      String categoria = _categoriaController.text;
      try {
        CollectionReference collection =
            FirebaseFirestore.instance.collection('tutoriais');
        Map<String, dynamic> tutoriais = {
          'titulo': titulo,
          'texto': texto,
          'imagem': imagem,
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
            backgroundColor: Color.fromARGB(255, 248, 246, 246),
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
            backgroundColor: Color.fromARGB(255, 248, 246, 246),
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
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 8,
                          blurRadius: 10,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Color.fromARGB(255, 248, 246, 246)),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            "Novo Tutorial",
                            style: TextStyle(fontSize: 50),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width - 200,
                          child: TextFormField(
                            controller: _tituloController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.title_sharp,
                              ),
                              labelText: "Titulo",
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, insira o título';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width - 200,
                          child: TextFormField(
                            controller: _imagemController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.image),
                              labelText: "Imagem",
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, insira uma imagem';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          width: MediaQuery.of(context).size.width - 200,
                          child: TextFormField(
                            controller: _categoriaController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.category),
                              labelText: "Categoria",
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, informe a categoria';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: MediaQuery.of(context).size.width - 200,
                          child: TextFormField(
                            maxLines: 4,
                            controller: _textoController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.text_fields_rounded),
                                labelText: "Texto",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15)),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor, descreva o tutorial';
                              }
                              return null;
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            criarTutorial(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width - 190,
                            height: 40,
                            padding: EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 9, 89, 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              'Criar novo tutorial',
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
