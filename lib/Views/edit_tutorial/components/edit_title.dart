import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/create_tutorial/components/controllers.singleton.dart';

class EditTitle extends StatefulWidget {
  final String id;
  EditTitle(this.id);

  @override
  State<EditTitle> createState() => _EditTitleState();
}

class _EditTitleState extends State<EditTitle> {
  DocumentSnapshot<Object?>? tutorial;

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
        ControllersSingleton.controllers.tituloController.text =
            tutorialData['titulo'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width - 150,
      child: TextFormField(
        controller: ControllersSingleton.controllers.tituloController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.title_sharp,
          ),
          labelText: "Titulo",
        ),
      ),
    );
  }
}
