import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:heart_beat/FriendShip/FriendShipActions.dart';
import '../FriendShip/GetUsersFireBase.dart';

class challenge{
  late int id;
  late String videoURL;
  challenge({required this.id,required this.videoURL});
}

class challengeList{
  String SENDER_NAME;
  String RECEIVER_NAME;
  String SENDER_REPEAT;
  String RECEIVER_REPEAT;
  String RECEIVER_CHALLENGE_NODE_ID;

  challengeList(this.SENDER_NAME,this.RECEIVER_NAME,this.SENDER_REPEAT,this.RECEIVER_REPEAT,this.RECEIVER_CHALLENGE_NODE_ID);
}

Future<challengeList> showChallengeResultList(String CHALLENGE_NODE_ID) async{

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  bool isThisTheChallenge = false;
  challengeList result = new challengeList("", "", "", "", "");
  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${current_uid}/ChallengeList");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      element.children.forEach((element) {
        if(element.key.toString()=="RECEIVER_CHALLENGE_NODE_ID"){
          if(element.value.toString()==CHALLENGE_NODE_ID)
          {
            isThisTheChallenge = true;
            result.RECEIVER_CHALLENGE_NODE_ID=element.value.toString();
          }
        }
        if(isThisTheChallenge==true){
          if(element.key.toString()=="SENDER_NAME"){
            result.SENDER_NAME=element.value.toString();
          }
          else if(element.key.toString()=="RECEIVER_NAME"){
            result.RECEIVER_NAME=element.value.toString();
          }
          else if(element.key.toString()=="SENDER_REPEAT"){
            result.SENDER_REPEAT=element.value.toString();
          }
          else if(element.key.toString()=="RECEIVER_REPEAT"){
            result.RECEIVER_REPEAT=element.value.toString();
          }
        }
      });
    });
  });

  return result;
}

class challengeSummary{
  late var USER_ID;
  late String CHALLENGE_ID;
  late String ACCEPT_TIME;
  late String SENDER_REPEAT;
  late String RECEIVER_REPEAT;
  challengeSummary(this.USER_ID, this.CHALLENGE_ID, this.ACCEPT_TIME, this.SENDER_REPEAT, this.RECEIVER_REPEAT);

  challengeSummary.fromJson(Map<dynamic, dynamic> json) :
        USER_ID = json['USER_ID'] as String,
        CHALLENGE_ID = json['CHALLENGE_ID'] as String,
        ACCEPT_TIME = json['ACCEPT_TIME'] as String,
        SENDER_REPEAT = json['SENDER_REPEAT'] as String,
        RECEIVER_REPEAT = json['RECEIVER_REPEAT'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'USER_ID': USER_ID,
    'CHALLENGE_ID': CHALLENGE_ID,
    'ACCEPT_TIME': ACCEPT_TIME,
    'SENDER_REPEAT': SENDER_REPEAT,
    'RECEIVER_REPEAT': RECEIVER_REPEAT,
  };
}
//bu listeleme için
class challengeSummary2{
  late var LIST_CHALLENGE_NODE_ID;
  late var SENDER_CHALLENGE_NODE_ID;
  late var RECEIVER_CHALLENGE_NODE_ID;
  late var USER_ID;
  late String USER_NAME;

  challengeSummary2(this.USER_NAME,this.LIST_CHALLENGE_NODE_ID,this.USER_ID,this.RECEIVER_CHALLENGE_NODE_ID,this.SENDER_CHALLENGE_NODE_ID);

  challengeSummary2.fromJson(Map<dynamic, dynamic> json) :
        LIST_CHALLENGE_NODE_ID = json['CHALLENGE_NODE_ID'] as String,
        RECEIVER_CHALLENGE_NODE_ID = json['RECEIVER_CHALLENGE_NODE_ID'] as String,
        SENDER_CHALLENGE_NODE_ID = json['SENDER_CHALLENGE_NODE_ID'] as String,
        USER_NAME = json['USER_NAME'] as String,
        USER_ID = json['USER_ID'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'LIST_CHALLENGE_NODE_ID': LIST_CHALLENGE_NODE_ID,
    'RECEIVER_CHALLENGE_NODE_ID': RECEIVER_CHALLENGE_NODE_ID,
    'SENDER_CHALLENGE_NODE_ID': SENDER_CHALLENGE_NODE_ID,
    'USER_NAME': USER_NAME,
    'USER_ID': USER_ID,
  };
}

class challengeToViewSummary{
  late var USER_NAME;
  late var USER_ID;
  late String CHALLENGE_URL;
  late String ACCEPT_TIME;
  late String SENDER_REPEAT;
  late String RECEIVER_REPEAT;
  challengeToViewSummary(this.USER_NAME, this.USER_ID,this.CHALLENGE_URL,this.ACCEPT_TIME,this.SENDER_REPEAT,this.RECEIVER_REPEAT);

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

Future<challengeToViewSummary> showReceivedChallenge(String CHALLENGE_NODE_ID) async{

  challengeToViewSummary singleChallenge = new challengeToViewSummary("","","","","","");
  challengeSummary receivedChallenge = new challengeSummary("","","","","");
  List<Userz> friends = await showFriendsSetData(); // öncelikle arkadaiları çekeriz
  List<challenge> challenges = await showChallengeSetData(); // bu bize challenge lari döndürüyor
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;

  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${current_uid}/ReceivedChallenges/${CHALLENGE_NODE_ID}");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
        if(element.key.toString()=="CHALLENGE_ID"){
          receivedChallenge.CHALLENGE_ID = element.value.toString();
        }
        else if(element.key.toString() == "USER_ID"){
          receivedChallenge.USER_ID = element.value;
          singleChallenge.USER_ID = receivedChallenge.USER_ID;
        }
        else if(element.key.toString()=="ACCEPT_TIME"){
          receivedChallenge.ACCEPT_TIME = element.value.toString();
          singleChallenge.ACCEPT_TIME = receivedChallenge.ACCEPT_TIME;
        }
        else if(element.key.toString()=="SENDER_REPEAT"){
          receivedChallenge.SENDER_REPEAT = element.value.toString();
          singleChallenge.SENDER_REPEAT = receivedChallenge.SENDER_REPEAT;
        }
        else if(element.key.toString()=="RECEIVER_REPEAT"){
          receivedChallenge.RECEIVER_REPEAT = element.value.toString();
          singleChallenge.RECEIVER_REPEAT = receivedChallenge.RECEIVER_REPEAT;
        }

    });
  });



  for(int i=0; i<friends.length; i++){
    if(friends[i].uid==receivedChallenge.USER_ID){
      singleChallenge.USER_NAME=friends[i].uname;
      break;
    }
  }

  for(int i=0; i<challenges.length; i++){
    if(challenges[i].id.toString()==receivedChallenge.CHALLENGE_ID){
      singleChallenge.CHALLENGE_URL=challenges[i].videoURL;
      break;
    }
  }


  return singleChallenge;
}

Future<List<challengeSummary2>> showAllReceivedChallenge() async{

  List<challengeSummary2> receivedChallenges = [];
  List<Userz> friends = await showFriendsSetData(); // öncelikle arkadaiları çekeriz
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;

  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${current_uid}/ReceivedChallenges");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      challengeSummary2 receivedChallenge = new challengeSummary2("","","","","");
      receivedChallenge.RECEIVER_CHALLENGE_NODE_ID = element.key.toString();
      element.children.forEach((element) {
        if(element.key.toString() == "USER_ID"){
          receivedChallenge.USER_ID = element.value;
        }
      });
      receivedChallenges.add(receivedChallenge);
    });
  });
  for(int i=0; i<friends.length; i++){
    if(friends[i].uid==receivedChallenges[i].USER_ID){
      receivedChallenges[i].USER_NAME=friends[i].uname!;
    }
  }

  return receivedChallenges;
}

bool SendChallengeRequest(String uid,String challengeId,String sender_repeat){
  bool isDone;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  String ACCEPT_TIME = "";
  challengeSummary hedef_user = new challengeSummary(uid,challengeId,ACCEPT_TIME,sender_repeat,"");
  challengeSummary asil_user = new challengeSummary(current_uid,challengeId,ACCEPT_TIME,sender_repeat,"");
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

void AcceptChallenge(String challenge_node_id,String sender_id,String sender_name,String sender_repeat,String receiver_repeat){
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  final receiver_name= user!.displayName;
  //**********************SentRequests*******************************
  DatabaseReference ref1 = FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$current_uid")
      .child("ChallengeList");
  ref1.push().set({
    'SENDER_NAME':sender_name,
    'RECEIVER_NAME':receiver_name,
    'SENDER_REPEAT':sender_repeat,
    'RECEIVER_REPEAT':receiver_repeat,
    'RECEIVER_CHALLENGE_NODE_ID':challenge_node_id
  });

  //***********************ReceivedRequests**************************
  DatabaseReference ref2 = FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("${sender_id}")
      .child("ChallengeList");
  ref2.push().set({
    'SENDER_NAME':sender_name,
    'RECEIVER_NAME':receiver_name,
    'SENDER_REPEAT':sender_repeat,
    'RECEIVER_REPEAT':receiver_repeat,
  });

}

void ChallengeStarted(String ACCEPT_TIME) async{
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  String childToUpdate = "";
  String CHALLENGE_ID = "";
  String USER_ID = "";

  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${current_uid}/ReceivedChallenges");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      element.children.forEach((element) {
        if(element.key.toString()=="CHALLENGE_ID"){
          CHALLENGE_ID = element.value.toString();
        }
        else if(element.key.toString() == "USER_ID"){
          USER_ID = element.value.toString();
        }
      });
    });
  });

  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      childToUpdate = element.key.toString();
      FirebaseDatabase.instance.ref("USERS/${current_uid}/ReceivedChallenges/${childToUpdate}").update({
        'CHALLENGE_ID': CHALLENGE_ID,
        'USER_ID':USER_ID,
        'ACCEPT_TIME': ACCEPT_TIME});
    });
  });
}

void deleteChallenge(String receiver_node_id, String challenge_list_node_id){

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  String ChildToDelete="";
  FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$current_uid")
      .child("ChallengeList")
      .once()
      .then((snapshot){
    snapshot.snapshot.children.forEach((element1) {
      element1.children.forEach((element2) {
        ChildToDelete = element1.key.toString();
        if(element2.key.toString()=="RECEIVER_CHALLENGE_NODE_ID" && element2.value.toString()==receiver_node_id){
          FirebaseDatabase.instance.ref().child("USERS").child("$current_uid").child("ChallengeList").child("$ChildToDelete").remove();
        }
        else{
          print(ChildToDelete);
        }
      });
    });
  });
  FirebaseDatabase.instance.ref().child("USERS").child("$current_uid").child("ReceivedChallenges").child("$receiver_node_id").remove();
}



