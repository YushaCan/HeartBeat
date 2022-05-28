import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/Challenge/AllSentChallenges.dart';
import 'friendsWidget.dart';

class senderReviewPage extends StatelessWidget {
  const senderReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
              onPressed: ()
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllSentChallenges(),
                    )
                );
              },
              child: Text("Sent Challenges")),
          TextButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Friends(),
                    )
                );
              },
              child: Text("Send a new challenge"))
        ],
      ),
    );
  }
}
