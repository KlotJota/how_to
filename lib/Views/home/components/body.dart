import 'package:flutter/material.dart';
import 'package:how_to/Views/home/components/other_tutorials.dart';
import 'package:how_to/Views/home/components/popular_tutorials.dart';
import 'package:how_to/Views/home/components/profile_panel.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
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
            ], color: Color.fromARGB(255, 250, 247, 247)),
            child: ListView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(255, 243, 243, 243),
                          ),
                          height: 60,
                          width: MediaQuery.of(context).size.width - 20,
                          child: ProfilePanel()),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Tutoriais Populares',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 191, 0),
                    )
                  ],
                ),
                PopularTutorials(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Tutoriais Recentes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Icon(Icons.add_box_outlined)
                  ],
                ),
                OtherTutorials(),
                Container(
                  height: 120,
                )
              ],
            ),
          ),
        ),
      ],
    )));
  }
}
