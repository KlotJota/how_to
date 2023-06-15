import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  @override
  State<SearchForm> createState() => _SearchFormState();
}

// Singleton
class PesquisaSingleton {
  static final PesquisaSingleton pesquisa = PesquisaSingleton._internal();

  TextEditingController _pesquisaController = TextEditingController();

  factory PesquisaSingleton() {
    return pesquisa;
  }

  TextEditingController get pesquisaController => _pesquisaController;

  PesquisaSingleton._internal();
}

class _SearchFormState extends State<SearchForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width - 20,
      child: TextField(
        onChanged: (value) {
          setState(() {
            PesquisaSingleton.pesquisa.pesquisaController.text = value;
            print(PesquisaSingleton.pesquisa.pesquisaController.text);
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          labelText: 'Pesquisar',
          suffixIcon: Icon(Icons.search),
          hintText: 'Pesquise por tutoriais',
        ),
      ),
    );
  }
}
