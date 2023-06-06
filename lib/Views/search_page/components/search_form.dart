import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  @override
  State<SearchForm> createState() => _SearchFormState();
}

// Singleton
class PesquisaSingleton {
  static final PesquisaSingleton pesquisa = PesquisaSingleton._internal();

  String? valor;

  factory PesquisaSingleton() {
    return pesquisa;
  }

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
            PesquisaSingleton.pesquisa.valor = value;
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
