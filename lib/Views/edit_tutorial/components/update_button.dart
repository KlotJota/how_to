import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: MediaQuery.of(context).size.width - 150,
      height: 40,
      padding: EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 9, 89, 1),
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        'Atualizar tutorial',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
