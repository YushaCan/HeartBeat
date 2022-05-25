import 'package:flutter/material.dart';
import 'package:heart_beat/Challenge/receivedChallengeWidget.dart';
import 'ChallengeActions.dart';

class AllReceivedChallenges extends StatefulWidget {
  const AllReceivedChallenges({Key? key}) : super(key: key);

  @override
  State<AllReceivedChallenges> createState() => _AllReceivedChallengesState();
}

class _AllReceivedChallengesState extends State<AllReceivedChallenges> {
  List<ReceivedSentChallenge> challlengesSet = [];
  List<String> senderNames = [];
  String name = "";

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    challlengesSet = await showAllReceivedChallenges();
    for(int i=0; i<challlengesSet.length; i++){
      name = await getUserName(challlengesSet[i].challengeDetails.sender_id);
      senderNames.add(name);
    }
    super.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Challenges List"),
        titleTextStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
      body:
      Column(
        children: <Widget>[
          // LIST PART
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: challlengesSet.length,
            itemBuilder: (BuildContext context, int index) {
              // EVERY ELEMENT OF THE LIST
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                    MaterialPageRoute(
                       builder: (context) => receivedChallengeWidget(receivedSentChallenge: challlengesSet[index]),
                       ));
                },
                //color: Colors.white,
                child: Card(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        // THIS PROFILE PICTURE WILL BE PULL FROM THE DB
                        backgroundImage: AssetImage("assets/profilephoto.jpg"),
                      ),
                      Padding(padding: EdgeInsets.only(top: 40, left: 7)),
                      // User Names
                      Text(
                          "From ${senderNames[index]}"), // Usernames
                      Spacer(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
