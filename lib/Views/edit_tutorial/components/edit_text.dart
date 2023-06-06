import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/create_tutorial/components/controllers.singleton.dart';

class EditText extends StatefulWidget {
  final String id;
  EditText(this.id);

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
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

        ControllersSingleton.controllers.textoController.text =
            tutorialData['texto'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width - 150,
      child: TextFormField(
        maxLines: 4,
        controller: ControllersSingleton.controllers.textoController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.text_fields_rounded),
            labelText: "Texto",
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
      ),
    );
  }
}
