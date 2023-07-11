import 'package:flutter/material.dart';
import 'package:how_to/Views/register/components/register-form.dart';
import 'package:get/get.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10, top: 10),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back_outlined,
                    color: Color.fromRGBO(0, 9, 89, 1),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Cadastro",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              RegisterForm()
            ],
          ),
        ),
      ),
    );
  }
}
