import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/MainPages/MainMenu.dart';
import 'ChallengeFirebaseData.dart';

class challengeWinnerPage extends StatefulWidget {
  final challenge_node_id;
  const challengeWinnerPage({Key? key,required this.challenge_node_id}) : super(key: key);

  @override
  _challengeWinnerPageState createState() => _challengeWinnerPageState();
}

class _challengeWinnerPageState extends State<challengeWinnerPage> {

  challengeList result = new challengeList("","","","","");
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    result = await showChallengeResultList(widget.challenge_node_id);
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
      body: Column(
        children: [
          Text("${result.RECEIVER_NAME}"),
          Text("${result.SENDER_NAME}"),
          Text("${result.RECEIVER_REPEAT}"),
          Text("${result.SENDER_REPEAT}"),
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 30, 30, 0),
            child:SizedBox(
                width: 200,
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      deleteChallenge(result.RECEIVER_CHALLENGE_NODE_ID);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainMenuPage(),
                          ));
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
                          "End Challenge",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),),
                )
            ),
          ),
        ],
      ),
    );
  }
}
