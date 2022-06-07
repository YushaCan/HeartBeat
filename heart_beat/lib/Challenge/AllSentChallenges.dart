import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Challenge/receivedChallengeWidget.dart';
import 'package:heart_beat/Challenge/sentChallengeWidget.dart';
import '../FriendShip/FriendShipActions.dart';
import 'ChallengeActions.dart';
import 'ChallengeFirebaseData.dart';
import 'challengeWidget.dart';


// silinebilir
class AllSentChallenges extends StatefulWidget {
  const AllSentChallenges({Key? key}) : super(key: key);

  @override
  State<AllSentChallenges> createState() => _AllSentChallengesState();
}

class _AllSentChallengesState extends State<AllSentChallenges> {
  List<ReceivedSentChallenge> challlengesSet = [];
  List<String> receiverNames = [];
  String name = "";

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    challlengesSet = await showAllSentChallenges();
    for(int i=0; i<challlengesSet.length; i++){
      name = await getUserName(challlengesSet[i].challengeDetails.sender_id);
      receiverNames.add(name);
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
      body: Column(
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
                        builder: (context) => sentChallengeWidget(receivedSentChallenge: challlengesSet[index]),
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
                          "To ${receiverNames[index]}"), // Usernames
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
