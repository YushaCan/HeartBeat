import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ChallengeFirebaseData.dart';
import 'model.dart';

class challenges extends StatefulWidget {
  const challenges({Key? key}) : super(key: key);

  @override
  State<challenges> createState() => _challengesState();
}

class _challengesState extends State<challenges> {
  int selectedIndex = -1;
  List<challenge> challengeSet = [];
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    challengeSet = await showChallengeSetData();
  }

  @override
  Widget build(BuildContext context) {
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
          itemCount: challengeSet.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
              },
              child: SizedBox(
                height: 300,
                child: Card(
                  child: SizedBox(
                      child: Image.network(
                        challengeSet[index].videoURL,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                ), //Card
              ), //SizedBox
            );
          }),
    );
  }
}
