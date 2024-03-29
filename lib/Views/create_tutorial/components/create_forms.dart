import 'package:flutter/material.dart';

class CreateController {
  static final CreateController createControllers =
      CreateController._internal();

  final TextEditingController _titulo = TextEditingController();
  final TextEditingController _categoria = TextEditingController();
  final TextEditingController _texto = TextEditingController();

  factory CreateController() {
    return createControllers;
  }

  CreateController._internal();

  TextEditingController get titulo => _titulo;

  TextEditingController get texto => _texto;

  TextEditingController get categoria => _categoria;
}

class CreateForms extends StatelessWidget {
  const CreateForms({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width - 150,
          child: TextFormField(
            controller: CreateController.createControllers.titulo,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 2),
              ),
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
          margin: const EdgeInsets.only(bottom: 25),
          width: MediaQuery.of(context).size.width - 150,
          child: TextFormField(
            controller: CreateController.createControllers.categoria,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 2),
              ),
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
          margin: const EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width - 150,
          child: TextFormField(
            maxLines: 4,
            controller: CreateController.createControllers.texto,
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
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
