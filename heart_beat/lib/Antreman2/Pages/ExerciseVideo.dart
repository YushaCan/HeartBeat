import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/ExerciseCounter/Counter.dart';

import '../models/exercise.dart';

class ExerciseVideo extends StatefulWidget {
  const ExerciseVideo({Key? key, required this.exercises}) : super(key: key);
  final Exercise exercises;
  @override
  _ExerciseVideoState createState() => _ExerciseVideoState();
}

class _ExerciseVideoState extends State<ExerciseVideo> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Exercise"),
       leading: IconButton(icon:Icon(Icons.arrow_back), onPressed: () {  },),
       backgroundColor: Color.fromRGBO(0, 31, 235,0.6),
     ),
       body: Container(
         // height: MediaQuery.of(context).size.height / 1.5,
          color: Colors.white,
           child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(
               child: Image.network(
                 widget.exercises.videoUrl!,
                 height: 300,
                 width: 300,
                 fit: BoxFit.cover,
               ),
             ),
             SizedBox(
               height: 40,
             ),
             SizedBox(
               child: CounterWidget(exercises: widget.exercises,),
             ),
           ],
         ),
    ));
  }
}
//child: Image.network(widget.url, height: 400, width: 400),