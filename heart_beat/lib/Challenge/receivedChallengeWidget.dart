import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Challenge/challengeWinnerPage.dart';
import 'ChallengeActions.dart';

class receivedChallengeWidget extends StatefulWidget {
  final ReceivedSentChallenge receivedSentChallenge;
  const receivedChallengeWidget({Key? key,required this.receivedSentChallenge}) : super(key: key);
  @override
  State<receivedChallengeWidget> createState() => _receivedChallengeWidgetState();
}
FirebaseAuth auth = FirebaseAuth.instance;
User? user = auth.currentUser;
final current_uid = user?.uid;

class _receivedChallengeWidgetState extends State<receivedChallengeWidget> {

  String receiver_repeat = "";
  bool acceptButtonClicked = false;
  late DateTime  remainedTime ;
  late Duration? diff ;
  String name = "";
  String url = "";

  ChallengeListDetails challengeListDetails = new ChallengeListDetails();


  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    //receivedSentChallenge = await showReceivedChallenges(widget.receivedSentChallenge.node_id);
    if(widget.receivedSentChallenge.challengeDetails.accept_time==""){
      acceptButtonClicked = false;
    }
    else if(widget.receivedSentChallenge.challengeDetails.accept_time!=""){
    remainedTime =  DateTime.parse(widget.receivedSentChallenge.challengeDetails.accept_time);
    remainedTime = remainedTime.add(Duration(hours: 24));
    DateTime today = DateTime.now();
    diff = remainedTime.difference(today);
    acceptButtonClicked = true;
    }
    name = await getUserName(widget.receivedSentChallenge.challengeDetails.sender_id);
    url = await getUrl(widget.receivedSentChallenge.challengeDetails.challenge_id);



    super.setState(() {
      challengeListDetails.receivedSentChallenge = widget.receivedSentChallenge;
      challengeListDetails.receiver_repeat = receiver_repeat;
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
          Center(child: CircularProgressIndicator())
      :SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 20, 50, 0),
              child: SizedBox(
                  width: 200,
                  height: 50,
                  child: Text("From ${name}",
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
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 15, 30, 0),
              child: SizedBox(
                  width: 100,
                  height: 50,
                  child: acceptButtonClicked?
                  TextField(
                    onChanged: (value) {
                      receiver_repeat = value;
                      challengeListDetails.receiver_repeat = receiver_repeat;
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
                  width: 250,
                  height: 100,
                  child: acceptButtonClicked?
                  Text("Time remained for the challenge to finish is ${diff?.inHours}:${(diff?.inMinutes)!-(diff!.inHours*60)} H",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 18,color: Colors.deepPurple
                    ),
                    textAlign: TextAlign.center, ):
                  Text("",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 12,color: Colors.deepPurple
                    ),
                    textAlign: TextAlign.center, )
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 30, 0),
                child: acceptButtonClicked? SizedBox(
                    width: 100,
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        onPressed: () {
                          AcceptChallenge(challengeListDetails);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => challengeWinnerPage(challengeListDetails: challengeListDetails),
                                ));
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0x37AABEFF), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            constraints:
                            BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Done",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),),
                    )
                )
                    : null
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 0, 30, 0),
              child:
              acceptButtonClicked? null
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
                        widget.receivedSentChallenge.challengeDetails.accept_time=accepted_time.toString();
                        ChallengeStarted(widget.receivedSentChallenge);

                        setState(() {
                          acceptButtonClicked = true;
                          if(widget.receivedSentChallenge.challengeDetails.accept_time==""){
                            acceptButtonClicked = false;
                          }
                          else if(widget.receivedSentChallenge.challengeDetails.accept_time!=""){
                            remainedTime =  DateTime.parse(widget.receivedSentChallenge.challengeDetails.accept_time);
                            remainedTime = remainedTime.add(Duration(hours: 24));
                            DateTime today = DateTime.now();
                            diff = remainedTime.difference(today);
                            acceptButtonClicked = true;
                            challengeListDetails.receiver_repeat = receiver_repeat;
                          }
                          challengeListDetails.receivedSentChallenge = widget.receivedSentChallenge;
                          challengeListDetails.receiver_repeat = receiver_repeat;
                          challengeListDetails.receiver_id = current_uid.toString();
                          //ChallengeStarted(widget.receivedSentChallenge);
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
          ],
        ),
      ),
    );
  }
}


