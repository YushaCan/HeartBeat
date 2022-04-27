import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Challenge/summaryWidget.dart';
import '../FriendShip/FriendShipActions.dart';
import 'ChallengeFirebaseData.dart';

void show_SelectFirst(BuildContext context) {
  Flushbar(
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(10),

    backgroundGradient: LinearGradient(
      colors: [
        Colors.red.shade500,
        Colors.red.shade300,
        Colors.red.shade100
      ],
      stops: [0.4, 0.7, 1],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: 'No selection made!',
    message: 'please select the challenge you want.',
    messageSize: 17,
  )..show(context);
}
class challenges extends StatefulWidget {
  final Userz selectedUserData;
  const challenges({Key? key, required this.selectedUserData}) : super(key: key);

  @override
  State<challenges> createState() => _challengesState();
}

class _challengesState extends State<challenges> {
  int selectedIndex = -1;
  int selectedChallengeId =0;

  List<challenge> challengeSet = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    challengeSet = await showChallengeSetData();
    super.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.indigo[900],
      appBar: AppBar(
        title: Text(
            "Challenges "
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  itemCount: challengeSet.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          selectedChallengeId = challengeSet[index].id;
                        });
                      },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                          child: Card(
                            shadowColor: (selectedIndex==index)? Colors.green: null,
                            shape: (selectedIndex==index)
                              ? RoundedRectangleBorder(
                              side: BorderSide(color: Colors.green,style: BorderStyle.solid))
                            : null,
                                child: Image.network(
                                  challengeSet[index].videoURL,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ), //Card
                       //SizedBox
                    );
                  }),
      ),
   floatingActionButton: FloatingActionButton(
     onPressed: () {
       if(selectedIndex==-1){
         show_SelectFirst(context);
       }
       else if(selectedIndex>-1){
         Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => summary(selectedUserData: widget.selectedUserData, selectedChallengeData: challengeSet[selectedIndex],),));
       }
     },
     child: const Icon(
         Icons.navigate_next),
     backgroundColor: Colors.lightBlueAccent,
   ),
    );
  }
}
