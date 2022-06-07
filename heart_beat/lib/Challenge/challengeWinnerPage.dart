import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/MainPages/MainMenu.dart';
import 'ChallengeActions.dart';

class challengeWinnerPage extends StatefulWidget {
  final ChallengeListDetails challengeListDetails;
  const challengeWinnerPage({Key? key,required this.challengeListDetails}) : super(key: key);

  @override
  _challengeWinnerPageState createState() => _challengeWinnerPageState();
}

class _challengeWinnerPageState extends State<challengeWinnerPage> {

  String sender_name="";
  String receiver_name="";
  String sender_id = "";
  String receiver_id = "";
  int sender_points=0;
  int receiver_points=0;
  String the_winner="";

  late ChallengeListDetails win;

  @override
  void didChangeDependencies() async {

    super.didChangeDependencies();

    win = await showResult(widget.challengeListDetails);

    sender_id = win.receivedSentChallenge.challengeDetails.sender_id;

    print(sender_id);
    receiver_id = win.receiver_id;

    sender_name = await getUserName(sender_id);

    receiver_name = await getUserName(receiver_id);

    sender_points = int.parse(win.receivedSentChallenge.challengeDetails.sender_repeat);
    print(sender_points);
    receiver_points = int.parse(win.receiver_repeat);

    super.setState(() {
      if(sender_points>receiver_points){
        the_winner=sender_name;
      }
      else if(sender_points<receiver_points){
        the_winner=receiver_name;
      }
      else if(sender_points==receiver_points){
        the_winner=receiver_name+sender_name;
      }
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 100, 0, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("${sender_name}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepPurple
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("${widget.challengeListDetails.receivedSentChallenge.challengeDetails.sender_repeat}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepPurple
                          ),)
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 100, 50, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("VS")
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 100, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("${receiver_name}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepPurple
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("${widget.challengeListDetails.receiver_repeat}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepPurple
                          ),)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(120, 30, 0, 0),
            child: Row(
              children: [
                Text("THE WINNER IS $the_winner"
                  ,style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepPurple
            ),)
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(80, 50, 100, 0),
            child:SizedBox(
                width: 200,
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      deleteChallenge(widget.challengeListDetails.receivedSentChallenge.node_id);
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
