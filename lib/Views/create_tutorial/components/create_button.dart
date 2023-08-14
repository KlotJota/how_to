import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: MediaQuery.of(context).size.width - 150,
      height: 40,
      padding: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 9, 89, 1),
          borderRadius: BorderRadius.circular(5)),
      child: const Text(
        'Criar novo tutorial',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromARGB(255, 250, 250, 250),
          fontSize: 20,
        ),
      ),
    );
  }
}
