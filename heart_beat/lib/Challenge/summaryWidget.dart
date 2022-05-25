import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../FriendShip/FriendShipActions.dart';
import 'ChallengeActions.dart';
import 'ChallengeFirebaseData.dart';


void show_True(BuildContext context) {
  Flushbar(
    duration: Duration(seconds: 3),
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(10),

    backgroundGradient: LinearGradient(
      colors: [
        Colors.pink.shade500,
        Colors.pink.shade300,
        Colors.pink.shade100
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
    title: 'Challenge is sent',
    message: 'The Challenge is successfully send.',
    messageSize: 17,
  )..show(context);
}

void show_False(BuildContext context) {
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
    title: 'Oops!',
    message: 'Something went wrong please try again.',
    messageSize: 17,
  )..show(context);
}

class summary extends StatefulWidget {
  final Userz selectedUserData;
  final challenge selectedChallengeData;
  const summary({Key? key, required this.selectedUserData, required this.selectedChallengeData}) : super(key: key);

  @override
  State<summary> createState() => _summaryState();
}

class _summaryState extends State<summary> {
  String sender_repeat = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Summary Of Challenge"
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 50, 50, 0),
              child: SizedBox(
                  width: 200,
                  height: 50,
                  child: Text("To ${widget.selectedUserData.uname}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 24,color: Colors.deepPurple
                  ),
                  textAlign: TextAlign.center, )
              ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 0, 30, 0),
            child: Card(
              child: Image.network(
                widget.selectedChallengeData.videoURL,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 30, 30, 0),
            child: SizedBox(
              width: 100,
              height: 50,
              child: TextField(
                onChanged: (value) {
                  sender_repeat = value;
                }, //bu email
                decoration: InputDecoration(
                  // icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  hintText: 'Repeat',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 30, 30, 0),
            child: SizedBox(
                width: 200,
                height: 90,
                child: Text("The challenge will be available for 24 hours when ${widget.selectedUserData.uname} accepts it!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 20,color: Colors.deepPurple
                  ),
                  textAlign: TextAlign.center, )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 30, 30, 0),
            child: SizedBox(
              width: 200,
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    var isDone = SendChallengeRequest(widget.selectedUserData.uid.toString(),widget.selectedChallengeData.id.toString(),sender_repeat);
                    if(isDone){
                      show_True(context);
                    }
                    else if(!isDone){
                      show_False(context);
                    }
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                      BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Send Challenge",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),),
              )
            ),
          )
        ],
      ),
    );
  }
}
