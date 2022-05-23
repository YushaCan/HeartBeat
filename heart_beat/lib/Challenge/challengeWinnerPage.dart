import 'package:flutter/cupertino.dart';
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
    return Container(
      child: Column(
        children: [
          Text("${result.SENDER_NAME}"),
          Text("${result.RECEIVER_NAME}"),
          Text("${result.RECEIVER_REPEAT}"),
          Text("${result.SENDER_REPEAT}"),
        ],
      ),
    );
  }
}
