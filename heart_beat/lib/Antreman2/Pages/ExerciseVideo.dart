import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseVideo extends StatefulWidget {
  const ExerciseVideo({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  _ExerciseVideoState createState() => _ExerciseVideoState();
}

class _ExerciseVideoState extends State<ExerciseVideo> {

/**/  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Image.network(widget.url, height: 400, width: 400,),
    );/*  */
  }
}
