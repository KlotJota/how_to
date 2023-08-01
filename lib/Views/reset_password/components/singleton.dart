import 'package:flutter/material.dart';

class SingletonResetPass {
  static final SingletonResetPass controller = SingletonResetPass._internal();

  final TextEditingController _emailController = TextEditingController();

  factory SingletonResetPass() {
    return controller;
  }

  SingletonResetPass._internal();

  TextEditingController get emailController => _emailController;
}
