import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/user-login.dart';
import 'package:how_to/Views/user-register.dart';

class FirstPage extends StatelessWidget {
  var logo = 'howto_logo1.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color.fromRGBO(0, 9, 89, 1),
          ),
          Positioned(
            top: 70,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //   begin: Alignment.topRight,
                  //   end: Alignment.bottomLeft,
                  //   colors: [
                  //     Colors.blue,
                  //     Colors.red,
                  //   ],
                  // ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 8,
                      blurRadius: 10,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Color.fromARGB(255, 240, 240, 240)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30, bottom: 80),
                    child: Text(
                      "Seja bem-vindo(a)",
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Get.to(UserLoginPage(), transition: Transition.zoom),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 200,
                      height: 50,
                      padding: EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Já tenho uma conta',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 35),
                    height: 60,
                    child: Text('É novo(a) por aqui?'),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Get.to(UserRegisterPage(), transition: Transition.zoom),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 200,
                      height: 40,
                      padding: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 9, 89, 0.712),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Criar uma conta',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    height: 40,
                    child: Text('ou'),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width - 200,
                      child: Text(
                        'Entrar como convidado',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(0, 9, 89, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
