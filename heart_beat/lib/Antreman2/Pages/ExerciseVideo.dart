import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/ExerciseCounter/Counter.dart';

class ExerciseVideo extends StatefulWidget {
  const ExerciseVideo({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  _ExerciseVideoState createState() => _ExerciseVideoState();
}

class _ExerciseVideoState extends State<ExerciseVideo> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("page"),
       leading: IconButton(icon:Icon(Icons.arrow_back), onPressed: () {  },),
     ),
       body: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          color: Colors.white,
           child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(
               child: Container(
                 height: 100,
                 width: 200,
                 color: Colors.transparent,
                 child: Container(
                   decoration: BoxDecoration(
                     color: Colors.blueAccent,
                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   ),
                   child: Center(
                     child: Text("Learn First Then start the exercise!",
                     style: TextStyle(
                         color: Colors.white, fontSize: 15),
                     textAlign: TextAlign.center),
                   ),
                 ),
               ),
             ),
              ClipOval(
                  child: Image.network(
                    widget.url,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
              ),
             SizedBox(
               child: ElevatedButton(
                 onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => CounterWidget()),
                   );
                 },
                 child: Text("Go And Crush it!"),
               ),
             )
           ],
         ),
    ));
  }
}
//child: Image.network(widget.url, height: 400, width: 400),