import 'package:flutter/material.dart';

class Orangeroundedtag extends StatefulWidget {
  final String text;
  const Orangeroundedtag({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<Orangeroundedtag> createState() => _OrangeroundedtagState();
}

class _OrangeroundedtagState extends State<Orangeroundedtag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3 , horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
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
          fontSize: 12,
        ),
      ),
    );
  }
}
