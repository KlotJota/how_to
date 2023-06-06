import 'package:flutter/material.dart';
import 'package:how_to/Views/create_tutorial/components/controllers.singleton.dart';

class CreateText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width - 150,
      child: TextFormField(
        maxLines: 4,
        controller: ControllersSingleton().textoController,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.text_fields_rounded),
            labelText: "Texto",
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor, descreva o tutorial';
          }
          return null;
        },
      ),
    );
  }
}
