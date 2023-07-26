import 'package:flutter/material.dart';
import 'package:how_to/Views/home/components/other_tutorials.dart';
import 'package:how_to/Views/home/components/popular_tutorials.dart';
import 'package:how_to/Views/home/components/profile_panel.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Color.fromARGB(255, 250, 247, 247)),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 250, 247, 247),
                        ),
                        height: 60,
                        width: MediaQuery.of(context).size.width - 20,
                        child: ProfilePanel()),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Tutoriais populares',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    PopularTutorials(),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Outros tutoriais',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    OtherTutorials(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
