import 'package:flutter/material.dart';

class CreateImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width - 150,
      height: 45,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 243, 243, 243),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.black)),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 10, right: 5),
              child: Icon(Icons.image_search)),
          Text(
            'Adicionar imagem',
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
      alignment: Alignment.centerLeft,
    );
  }
}
