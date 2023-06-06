import 'package:flutter/material.dart';

import 'package:how_to/Views/create_tutorial/components/controllers.singleton.dart';

class CreateCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      width: MediaQuery.of(context).size.width - 150,
      child: TextFormField(
        controller: ControllersSingleton().categoriaController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.category),
          labelText: "Categoria",
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Por favor, informe a categoria';
          }
          return null;
        },
      ),
    );
  }
}
