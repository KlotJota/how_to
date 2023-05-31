import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/first_page.dart';
import 'package:how_to/Views/home.dart';

class TutorialEditPage extends StatefulWidget {
  final String id;
  TutorialEditPage(this.id);

  @override
  State<TutorialEditPage> createState() => _TutorialEditPage();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class _TutorialEditPage extends State<TutorialEditPage> {
  var formKey = GlobalKey<FormState>();
  DocumentSnapshot<Object?>? tutorial;

  TextEditingController _tituloController = TextEditingController();
  TextEditingController _textoController = TextEditingController();
  TextEditingController _imagemController = TextEditingController();
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
        _imagemController.text = tutorialData['imagem'];
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

      if (_imagemController.text.isNotEmpty) {
        updateData['imagem'] = _imagemController.text;
      }

      if (_categoriaController.text.isNotEmpty) {
        updateData['categoria'] = _categoriaController.text;
      }

      // Adicione os demais campos que deseja atualizar

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
                    key: formKey,
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
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            editarTutorial(context);
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
