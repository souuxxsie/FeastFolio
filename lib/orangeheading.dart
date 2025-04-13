import 'package:flutter/material.dart';

class Orangeheading extends StatefulWidget {
  final String text;
  const Orangeheading({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<Orangeheading> createState() => _OrangeheadingState();
}

class _OrangeheadingState extends State<Orangeheading> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        color: Colors.orange,
        fontFamily: 'signika',
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }
}
