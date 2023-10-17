import 'package:flutter/material.dart';
import 'package:how_to/Views/appBar/appBar_home.dart';
import 'package:how_to/Views/appBar/appBar_profile.dart';
import 'package:how_to/Views/create_tutorial/components/body.dart';

class CreateTutorialPage extends StatefulWidget {
  const CreateTutorialPage({super.key});

  @override
  State<CreateTutorialPage> createState() => _CreateTutorialPage();
}

class _CreateTutorialPage extends State<CreateTutorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: MyAppBarProfile(), body: Body());
  }
}
