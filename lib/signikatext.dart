import 'package:flutter/material.dart';

class Signikatext extends StatefulWidget {
  final String text;
  final double fontsize;
  const Signikatext({
    Key? key,
    required this.text,
    required this.fontsize,
  }) : super(key: key);

  @override
  State<Signikatext> createState() => _SignikatextState();
}

class _SignikatextState extends State<Signikatext> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontFamily: 'signika',
        fontSize: widget.fontsize,
      ),
    );
  }
}
