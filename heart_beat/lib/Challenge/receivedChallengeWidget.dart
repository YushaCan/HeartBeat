import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChallengeFirebaseData.dart';

class receivedChallengeWidget extends StatefulWidget {
  const receivedChallengeWidget({Key? key}) : super(key: key);

  @override
  State<receivedChallengeWidget> createState() => _receivedChallengeWidgetState();
}

class _receivedChallengeWidgetState extends State<receivedChallengeWidget> {

  challengeToViewSummary receivedChallenge = new challengeToViewSummary("","");

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    receivedChallenge = await showReceivedChallenge();
    super.setState(() {});
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
                child: Text("${receivedChallenge.USER_NAME}",
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
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 30, 30, 0),
            child: SizedBox(
                width: 200,
                height: 50,
                child: Text("",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 24,color: Colors.deepPurple
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
