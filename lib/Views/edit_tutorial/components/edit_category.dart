import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/edit_tutorial/components/controllers.singleton.dart';

class EditCategory extends StatefulWidget {
  final String id;
  EditCategory(this.id);

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
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

        ControllersSingleton.controllers.categoriaController.text =
            tutorialData['categoria'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      width: MediaQuery.of(context).size.width - 150,
      child: TextFormField(
        controller: ControllersSingleton.controllers.categoriaController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.category),
          labelText: "Categoria",
        ),
      ),
    );
  }
}
