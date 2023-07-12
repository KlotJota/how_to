import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/tutorial_page/tutorial-page.dart';
import 'dart:async';

class PopularTutorials extends StatefulWidget {
  @override
  State<PopularTutorials> createState() => _PopularTutorialsState();
}

class _PopularTutorialsState extends State<PopularTutorials> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final int maxTutorials = 10;
  final double itemWidth = 160;

  final Duration autoScrollDuration = Duration(seconds: 3);

  late Timer _timer;
  late ScrollController _scrollController;

  double _progress = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _timer = Timer.periodic(autoScrollDuration, (_) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final newScrollOffset = _scrollController.offset + itemWidth;
        if (newScrollOffset >= maxScroll) {
          _scrollController.animateTo(0,
              duration: autoScrollDuration, curve: Curves.linear);
        } else {
          _scrollController.animateTo(newScrollOffset,
              duration: autoScrollDuration, curve: Curves.ease);
        }
      }
    });
    _scrollController.addListener(() {
      setState(() {
        _progress = _scrollController.hasClients
            ? _scrollController.offset /
                (_scrollController.position.maxScrollExtent -
                    MediaQuery.of(context).size.width +
                    itemWidth)
            : 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection('tutoriais')
            .orderBy('qtdFavoritos', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // senao tiver dados
            return CircularProgressIndicator(); // circulo de carregando
          }

          var tutoriais = snapshot.data!.docs;
          tutoriais = tutoriais.take(maxTutorials).toList();

          return Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 10,
                height: 240,
                child: ListView.builder(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: tutoriais.length,
                  itemBuilder: (context, index) {
                    final tutorial = tutoriais[index];
                    return GestureDetector(
                      onTap: () => Get.to(TutorialPage(tutorial.id)),
                      child: Card(
                        elevation: 3,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15))),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(tutorial['imagem']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 160,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 200),
                            child: Container(
                                color: Color.fromRGBO(0, 9, 89, 0.815),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 4, left: 8, right: 8, bottom: 4),
                                  child: Text(
                                    tutorial['titulo'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        overflow: TextOverflow.ellipsis,
                                        color:
                                            Color.fromARGB(255, 240, 240, 240)),
                                    maxLines: 2,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 5,
                  width: MediaQuery.of(context).size.width - 20,
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Color.fromARGB(0, 202, 202, 202),
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(0, 9, 89, 1)),
                  ))
            ],
          );
        });
  }
}
