import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Antreman2/models/exercise.dart';
import 'ExerciseVideo.dart';
class ExercisesOfSetPage extends StatelessWidget {
  //const ExercisesOfSetPage({Key? key, required this.exercises}) : super(key: key);
  final List<Exercise> exercises;
  const ExercisesOfSetPage({required this.exercises,});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(
          "Exercises "
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20),
            itemCount: this.exercises.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExerciseVideo(url: this.exercises[index].videoUrl!,duration: int.parse(this.exercises[index].duration!),)),
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
                                  this.exercises[index].name!,
                                  style: TextStyle(color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold,fontSize: 20),
                                ),
                            ),
                            SizedBox(
                              child: Text(
                                "Duration: ${this.exercises[index].duration!.toString()}",
                                style: TextStyle(color: Colors.blueAccent[200]),
                              ),
                            ),
                          ],
                        ),
                        ClipOval( //no need to provide border radius to make circular image
                          child: Image.network(
                            this.exercises[index].iconUrl!.toString(),
                            height: 100.0,
                            width: 100.0,
                            fit:BoxFit.cover, //change image fill type
                          ),
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
