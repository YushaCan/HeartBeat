import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ChallengeFirebaseData.dart';
import 'model.dart';

class challenges extends StatefulWidget {
  final selectedUserId;
  const challenges({Key? key, this.selectedUserId}) : super(key: key);

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
      //backgroundColor: Colors.indigo[900],
      appBar: AppBar(
        title: Text(
            "Exercises "
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        width: 200,
        child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  itemCount: challengeSet.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: () => setState(() => selectedIndex=index),
                        child: Card(
                          shadowColor: (selectedIndex==index)? Colors.green: null,
                          shape: (selectedIndex==index)
                            ? RoundedRectangleBorder(
                            side: BorderSide(color: Colors.green))
                          : null,
                              child: Image.network(
                                challengeSet[index].videoURL,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                        ), //Card
                       //SizedBox
                    );
                  }),
      ),
   floatingActionButton: FloatingActionButton(
     onPressed: () {

     },
     child: const Icon(Icons.navigate_next),
   ),
    );
  }
}
