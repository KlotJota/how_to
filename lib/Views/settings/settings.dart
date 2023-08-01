import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: const Text('HowTo',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          centerTitle: true,
          toolbarHeight: 50,
          backgroundColor: const Color.fromARGB(255, 250, 247, 247),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Color.fromARGB(255, 250, 247, 247)),
          child: Column(
            children: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Alterar tema do aplicativo",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ),
              const Divider(height: 10, thickness: 1),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Alterar nome de usuário",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ),
              const Divider(height: 10, thickness: 1),
            ],
          ),
        )));
  }
}
