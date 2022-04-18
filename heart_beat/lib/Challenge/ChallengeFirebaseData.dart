import 'package:firebase_database/firebase_database.dart';
import 'model.dart';

Future<List<challenge>> showChallengeSetData () async {
  List<challenge> challengeSet = [];
  DatabaseReference ref = FirebaseDatabase.instance.ref("CHALLENGES");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      challenge SingleChallenge = new challenge(id: 0, videoURL: '',);
      element.children.forEach((element) {
        if(element.key.toString() == "videoURL"){
          SingleChallenge.videoURL=element.value.toString();
        }
        else if(element.key.toString()=="id"){
          SingleChallenge.id = element.value as int;
        }
      });
      challengeSet.add(SingleChallenge);
    });
  });
  return challengeSet;
}
