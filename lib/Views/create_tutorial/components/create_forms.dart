import 'package:flutter/material.dart';
import 'package:how_to/Views/create_tutorial/components/controllers.singleton.dart';

class CreateController {
  static final CreateController createControllers =
      CreateController._internal();

  TextEditingController _titulo = TextEditingController();
  TextEditingController _categoria = TextEditingController();
  TextEditingController _texto = TextEditingController();

  factory CreateController() {
    return createControllers;
  }

  CreateController._internal();

  TextEditingController get titulo => _titulo;

  TextEditingController get texto => _texto;

  TextEditingController get categoria => _categoria;
}

class CreateForms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width - 150,
          child: TextFormField(
            controller: CreateController.createControllers.titulo,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.title_sharp,
              ),
              labelText: "Titulo",
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, insira o título';
              }
              return null;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 25),
          width: MediaQuery.of(context).size.width - 150,
          child: TextFormField(
            controller: CreateController.createControllers.categoria,
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
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width - 150,
          child: TextFormField(
            maxLines: 4,
            controller: CreateController.createControllers.texto,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.text_fields_rounded),
                labelText: "Texto",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, descreva o tutorial';
              }
              return null;
            },
          ),
        )
      ],
    );
  }
}
