import 'package:flutter/material.dart';

class Yellowbutton extends StatefulWidget {

  final String text;
  const Yellowbutton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<Yellowbutton> createState() => _YellowbuttonState();
}

class _YellowbuttonState extends State<Yellowbutton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15 , horizontal: 20),
      margin: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.orangeAccent[100],
      ),
      child: Text(
        textAlign: TextAlign.center,
        widget.text,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'signika',
          fontWeight: FontWeight.bold,
          fontSize: 19,
        ),
      ),
    );
  }
}
