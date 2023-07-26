import 'package:flutter/material.dart';
import 'package:how_to/Views/appBar/appBar_home.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text('HowTo',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          centerTitle: true,
          toolbarHeight: 50,
          backgroundColor: Color.fromARGB(255, 250, 247, 247),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Color.fromARGB(255, 250, 247, 247)),
          child: Column(
            children: [
              InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Alterar tema do aplicativo",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ),
              Divider(height: 10, thickness: 1),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Alterar nome de usuário",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ),
              Divider(height: 10, thickness: 1),
            ],
          ),
        )));
  }
}
