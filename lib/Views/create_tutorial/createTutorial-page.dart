import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/create_tutorial/components/body.dart';

class CreateTutorialPage extends StatefulWidget {
  @override
  State<CreateTutorialPage> createState() => _CreateTutorialPage();
}

class _CreateTutorialPage extends State<CreateTutorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body());
  }
}
