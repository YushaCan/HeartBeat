import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Challenge/challengeWinnerPage.dart';
import 'ChallengeFirebaseData.dart';

class receivedChallengeWidget extends StatefulWidget {
  final challenge_node_id;
  const receivedChallengeWidget({Key? key,required this.challenge_node_id}) : super(key: key);
  @override
  State<receivedChallengeWidget> createState() => _receivedChallengeWidgetState();
}

class _receivedChallengeWidgetState extends State<receivedChallengeWidget> {

  challengeToViewSummary receivedChallenge = new challengeToViewSummary("", "", "", "", "", "");
  String receiver_repeat = "";
  bool acceptButtonClicked = false;
  late DateTime  remainedTime ;
  late Duration diff;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    receivedChallenge = await showReceivedChallenge(widget.challenge_node_id);
    if(receivedChallenge.ACCEPT_TIME==""){
      acceptButtonClicked = false;
    }
    else{
    remainedTime =  DateTime.parse(receivedChallenge.ACCEPT_TIME);
    remainedTime = remainedTime.add(Duration(hours: 24));
    DateTime today = DateTime.now();
    diff = remainedTime.difference(today);
    acceptButtonClicked = true;
    }
    super.setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Summary Of Challenge"
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: receivedChallenge.USER_NAME==""?
      CircularProgressIndicator()
      :Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 50, 50, 0),
            child: SizedBox(
                width: 200,
                height: 50,
                child: Text("From ${receivedChallenge.USER_NAME}",
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
                receivedChallenge.CHALLENGE_URL,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 30, 30, 0),
            child: SizedBox(
              width: 100,
              height: 50,
              child: acceptButtonClicked?
              TextField(
                onChanged: (value) {
                  receiver_repeat = value;
                }, //bu email
                decoration: InputDecoration(
                  // icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  hintText: 'Repeat',
                ),
              )
              :null
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 30, 30, 0),
            child: SizedBox(
                width: 200,
                height: 140,
                child: acceptButtonClicked?
                Text("Time remained for the challenge to finish is ${diff.inHours}:${(diff.inMinutes)-(diff.inHours*60)} H",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 24,color: Colors.deepPurple
                  ),
                  textAlign: TextAlign.center, ):
                Text("",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 24,color: Colors.deepPurple
                  ),
                  textAlign: TextAlign.center, )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 30, 30, 0),
            child: acceptButtonClicked? null
            :
            SizedBox(
                width: 200,
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      var accepted_time = new DateTime.now();
                      ChallengeStarted(accepted_time.toString());
                      setState(() {
                        acceptButtonClicked = true;
                        ChallengeStarted(accepted_time.toString());
                      });
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
                          "Accept Challenge",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 30, 30, 0),
            child: acceptButtonClicked? SizedBox(
                width: 50,
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      setState(() {
                        AcceptChallenge(widget.challenge_node_id,receivedChallenge.USER_ID,receivedChallenge.USER_NAME,receivedChallenge.SENDER_REPEAT,receiver_repeat);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => challengeWinnerPage(challenge_node_id: widget.challenge_node_id,),
                            ));
                      });
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
                          "done",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),),
                )
            )
                : null
          ),
        ],
      ),
    );
  }
}


