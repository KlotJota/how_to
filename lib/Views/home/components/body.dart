import 'package:flutter/material.dart';
import 'package:how_to/Views/home/components/other_tutorials.dart';
import 'package:how_to/Views/home/components/popular_tutorials.dart';
import 'package:how_to/Views/home/components/profile_panel.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        height: 60,
                        width: MediaQuery.of(context).size.width - 20,
                        child: const ProfilePanel()),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Tutoriais populares',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const PopularTutorials(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Outros tutoriais',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const OtherTutorials(),
                  ],
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
