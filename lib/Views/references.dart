import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class References extends StatefulWidget {
  const References({super.key});

  @override
  State<References> createState() => _ReferencesState();
}

class _ReferencesState extends State<References> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      scale: 19,
                      alignment: Alignment.topCenter,
                      image: AssetImage('images/how-to-branco.png'))),
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 9, 89, 1),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: 70,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 8,
                  blurRadius: 10,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ], color: Color.fromARGB(255, 240, 240, 240)),
              child: ListView(
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.topCenter,
                      child: const Text(
                        'Referências',
                        style: TextStyle(fontSize: 30),
                      )),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 200,
                    child: Column(
                      children: [
                        Expanded(
                            child: Stack(
                          fit: StackFit.expand,
                          children: [
                            FittedBox(
                                fit: BoxFit.fill,
                                child: Image.asset('images/lucas.jpeg')),
                          ],
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                        'Você provavelmente durante sua vida escolar já precisou cuidar de sua documentação afinal, são tantas que você as vezes até acabar perdido. Por isso, este tutorial irá lhe ensinar desde como escolher a foto perfeita para seus documentos, quanto quais dados levar na hora de fazê-los. '),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                        'Você provavelmente durante sua vida escolar já precisou cuidar de sua documentação afinal, são tantas que você as vezes até acabar perdido. Por isso, este tutorial irá lhe ensinar desde como escolher a foto perfeita para seus documentos, quanto quais dados levar na hora de fazê-los. '),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                        'Você provavelmente durante sua vida escolar já precisou cuidar de sua documentação afinal, são tantas que você as vezes até acabar perdido. Por isso, este tutorial irá lhe ensinar desde como escolher a foto perfeita para seus documentos, quanto quais dados levar na hora de fazê-los. '),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                        'Você provavelmente durante sua vida escolar já precisou cuidar de sua documentação afinal, são tantas que você as vezes até acabar perdido. Por isso, este tutorial irá lhe ensinar desde como escolher a foto perfeita para seus documentos, quanto quais dados levar na hora de fazê-los. '),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                        'Você provavelmente durante sua vida escolar já precisou cuidar de sua documentação afinal, são tantas que você as vezes até acabar perdido. Por isso, este tutorial irá lhe ensinar desde como escolher a foto perfeita para seus documentos, quanto quais dados levar na hora de fazê-los. '),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 150,
          )
        ],
      ),
    );
  }
}
