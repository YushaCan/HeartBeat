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
      backgroundColor: Colors.indigo[900],
      appBar: AppBar(
        title: Text(
          "Exercises "
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20),
            itemCount: this.exercises.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExerciseVideo(url: this.exercises[index].videoUrl!,)),
                  );
                },
                child: SizedBox(
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    shadowColor: Colors.pinkAccent,
                    color: Colors.grey[100],
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
                                this.exercises[index].duration!.toString(),
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ClipOval( //no need to provide border radius to make circular image
                          child: Image.asset(
                            "assets/jumpinplace.jpg",
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
