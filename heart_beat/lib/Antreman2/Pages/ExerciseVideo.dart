import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/ExerciseCounter/Counter.dart';

class ExerciseVideo extends StatefulWidget {
  const ExerciseVideo({Key? key, required this.url, required this.duration}) : super(key: key);
  final String url;
  final int duration;
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
       backgroundColor: Colors.lightBlueAccent,
     ),
       body: Container(
         // height: MediaQuery.of(context).size.height / 1.5,
          color: Colors.white,
           child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(
               child: Image.network(
                 widget.url,
                 height: 300,
                 width: 300,
                 fit: BoxFit.cover,
               ),
             ),
             SizedBox(
               height: 40,
             ),
             SizedBox(
               child: CounterWidget(exerciseDuration: widget.duration),
             ),
           ],
         ),
    ));
  }
}
//child: Image.network(widget.url, height: 400, width: 400),