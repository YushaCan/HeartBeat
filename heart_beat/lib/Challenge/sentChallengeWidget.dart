import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Challenge/challengeWinnerPage.dart';
import 'ChallengeActions.dart';

class sentChallengeWidget extends StatefulWidget {
  final ReceivedSentChallenge receivedSentChallenge;
  const sentChallengeWidget({Key? key,required this.receivedSentChallenge}) : super(key: key);
  @override
  State<sentChallengeWidget> createState() => _sentChallengeWidgetState();
}

class _sentChallengeWidgetState extends State<sentChallengeWidget> {

  String name = "";
  String url = "";
  ChallengeListDetails challengeListDetails = new ChallengeListDetails();
  ReceivedSentChallenge receivedSentChallenge = new ReceivedSentChallenge();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    receivedSentChallenge = await showSentChallenges(widget.receivedSentChallenge.node_id);

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    final current_uid = user?.uid;

    name = await getUserName(widget.receivedSentChallenge.challengeDetails.sender_id);
    url = await getUrl(widget.receivedSentChallenge.challengeDetails.challenge_id);

    super.setState(() {
      challengeListDetails.receivedSentChallenge = widget.receivedSentChallenge;
      challengeListDetails.receiver_repeat = "100";
      challengeListDetails.receiver_id = current_uid.toString();
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
      body: url==""?
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
                child: Text("To ${name}",
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
                url,
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
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => challengeWinnerPage(challengeListDetails: challengeListDetails),
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
                            "See Result",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),),
                  )
              )
          ),
        ],
      ),
    );
  }
}


