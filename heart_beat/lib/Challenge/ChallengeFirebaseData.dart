import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:heart_beat/FriendShip/FriendShipActions.dart';
import '../FriendShip/GetUsersFireBase.dart';
import '../FriendShip/UsersList.dart';
import 'model.dart';

class challengeSummary{
  late var USER_ID;
  late String CHALLENGE_ID;
  challengeSummary(this.USER_ID, this.CHALLENGE_ID);

  challengeSummary.fromJson(Map<dynamic, dynamic> json) :
        USER_ID = json['USER_ID'] as String,
        CHALLENGE_ID = json['CHALLENGE_ID'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'USER_ID': USER_ID,
    'CHALLENGE_ID': CHALLENGE_ID,
  };
}

class challengeToViewSummary{
  late var USER_NAME;
  late String CHALLENGE_URL;
  challengeToViewSummary(this.USER_NAME, this.CHALLENGE_URL);

}
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

Future<List<Userz>> showFriendsSetData () async {
  List<UID> friendsSet = [];
  List<Userz> Users = await showUSERS_LIST();
  List<Userz> result = [];
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

  for(int i=0; i<friendsSet.length; i++){
    for(int j=0; j<Users.length; j++){
      if(friendsSet[i].USER_ID==Users[j].uid){
        result.add(Users[j]);
      }
    }
  }
  return result;
}

bool SendChallengeRequest(String uid,String challengeId){
  bool isDone;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  challengeSummary hedef_user = new challengeSummary(uid,challengeId);
  challengeSummary asil_user = new challengeSummary(current_uid,challengeId);
  try
  {
    //**********************SentRequests*******************************
    DatabaseReference ref1 = FirebaseDatabase.instance.ref()
        .child("USERS")
        .child("$current_uid")
        .child("SentChallenges");
    ref1.push().set(hedef_user.toJson());

    //***********************ReceivedRequests**************************
    DatabaseReference ref2 = FirebaseDatabase.instance.ref()
        .child("USERS")
        .child("${hedef_user.USER_ID}")
        .child("ReceivedChallenges");
    ref2.push().set(asil_user.toJson());
    isDone= true;
  }
  catch(e){
    isDone=false;
    print(e);
  }
  return isDone;
}

void AcceptChallenge(String uid,String challengeId){
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  challengeSummary hedef_user = new challengeSummary(uid,challengeId);
  challengeSummary asil_user = new challengeSummary(current_uid,challengeId);

  //**********************SentRequests*******************************
  DatabaseReference ref1 = FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$current_uid")
      .child("ChallengeList");
  ref1.push().set(hedef_user.toJson());

  //***********************ReceivedRequests**************************
  DatabaseReference ref2 = FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("${hedef_user.USER_ID}")
      .child("ChallengeList");
  ref2.push().set(asil_user.toJson());

}




