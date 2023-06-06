import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/create_tutorial/components/controllers.singleton.dart';

class EditImage extends StatefulWidget {
  final String id;
  EditImage(this.id);

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
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
