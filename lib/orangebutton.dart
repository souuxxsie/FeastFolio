import 'package:flutter/material.dart';

class Orangebutton extends StatefulWidget {
  final String text;
  const Orangebutton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<Orangebutton> createState() => _OrangebuttonState();
}

class _OrangebuttonState extends State<Orangebutton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5 , horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            colors: [
              Colors.deepOrange,
              Colors.orangeAccent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'signika',
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}
