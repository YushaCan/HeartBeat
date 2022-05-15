import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/models/exercise.dart';
import '../firebasedata/realtimedata.dart';
import '../models/isDoneExercise.dart';
import 'ExerciseVideo.dart';
class ExercisesOfSetPage extends StatefulWidget {
  //const ExercisesOfSetPage({Key? key, required this.exercises}) : super(key: key);
  final List<Exercise> exercises;
  const ExercisesOfSetPage({required this.exercises,});

  @override
  State<ExercisesOfSetPage> createState() => _ExercisesOfSetPageState();
}

class _ExercisesOfSetPageState extends State<ExercisesOfSetPage> {

  String url="https://firebasestorage.googleapis.com/v0/b/heartbeat-cbae0.appspot.com/o/assets%2Ficons%2FDodawnie%20i%20odejmowanie%20do%2010%20by%20beat_tom%20on%20Genially.png?alt=media&token=ff8a8366-0ae7-4dcf-a0c6-ca114c3708a2";
  List<isDoneExercise> isDoneExercises=[];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    isDoneExercises = await showIsDoneExercisesSetData();
    super.setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(
          "Exercises "
        ),
        backgroundColor: Color.fromRGBO(0, 31, 235,0.6),
      ),
      body: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20),
            itemCount: this.widget.exercises.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExerciseVideo(exercises: this.widget.exercises[index],)),
                  );
                },
                child: SizedBox(
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    shadowColor: Colors.lightBlueAccent,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  this.widget.exercises[index].name!,
                                  style: TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontSize: 20),
                                ),
                            ),
                            SizedBox(
                              child: Text(
                                "Duration: ${this.widget.exercises[index].duration!.toString()}",
                                style: TextStyle(color: Colors.blueAccent[200]),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ExerciseVideo(exercises: this.widget.exercises[index],)),
                              );
                            },
                            icon: isDoneExercises[index].isDone.toString()=="0"
                            ? Icon(Icons.play_arrow,color: Colors.green,size: 50)
                            : Icon(Icons.done,color: Colors.green,size: 50),
                        ),
                      ]//Text
                    ), //Center
                  ), //Card
                ), //SizedBox
              );
            }),
    );
  }
}
