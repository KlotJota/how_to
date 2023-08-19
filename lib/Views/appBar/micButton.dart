import 'package:flutter/material.dart';

class MicButton extends StatefulWidget {
  @override
  _MicButtonState createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _isPressed = true;
        });
      },
      onLongPressEnd: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      child: _isPressed ? _buildContainer() : _buildFAB(),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.mic),
    );
  }

  Widget _buildContainer() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width - 30,
      child: Text(
        "Teste",
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
