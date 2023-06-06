import 'package:flutter/material.dart';
import 'package:how_to/Views/home/components/body.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body());
  }
}
