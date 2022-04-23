import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:heart_beat/FriendShip/FriendShipActions.dart';
import '../FriendShip/UsersList.dart';
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

Future<List<UID>> showFriendsSetData () async {
  List<UID> friendsSet = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  print(current_uid);
  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${current_uid}/FriendsList");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      UID SingleFriend= new UID(0);
      element.children.forEach((element) {
        if(element.key.toString() == "USER_ID"){
          SingleFriend.USER_ID = element.value;
        }
      });
      friendsSet.add(SingleFriend);
    });
  });
  return friendsSet;
}
