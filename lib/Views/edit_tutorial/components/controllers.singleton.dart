import 'package:flutter/material.dart';

class ControllersSingleton {
  static final ControllersSingleton controllers =
      ControllersSingleton._internal();

  TextEditingController _imagem = TextEditingController();

  final TextEditingController _tituloController = TextEditingController();

  final TextEditingController _textoController = TextEditingController();

  final TextEditingController _categoriaController = TextEditingController();

  factory ControllersSingleton() {
    return controllers;
  }

  ControllersSingleton._internal();

  TextEditingController get tituloController => _tituloController;

  TextEditingController get textoController => _textoController;

  TextEditingController get categoriaController => _categoriaController;

  TextEditingController get imagem => _imagem;

  set imagem(TextEditingController value) {
    _imagem = value;
  }
}
