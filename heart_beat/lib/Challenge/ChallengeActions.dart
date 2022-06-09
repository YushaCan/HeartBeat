import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChallengeDetails{
  late String challenge_id;
  late String sender_name;
  late String sender_id;
  late String sender_repeat;
  late String accept_time;

  ChallengeDetails(this.challenge_id,this.sender_id,this.sender_repeat,this.accept_time);

  ChallengeDetails.fromJson(Map<dynamic, dynamic> json) :
        challenge_id = json['challenge_id'] as String,
        sender_id = json['sender_id'] as String,
        sender_repeat = json['sender_repeat'] as String,
        accept_time = json['accept_time'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'challenge_id': challenge_id,
    'sender_id': sender_id,
    'sender_repeat': sender_repeat,
    'accept_time': accept_time,
  };
}

class ReceivedSentChallenge{
  late String node_id;
  ChallengeDetails challengeDetails = new ChallengeDetails("","","","");
}

class ChallengeListDetails{

  ReceivedSentChallenge receivedSentChallenge = new ReceivedSentChallenge();
  late String receiver_id;
  late String receiver_repeat;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'challenge_id': receivedSentChallenge.challengeDetails.challenge_id,
    'sender_id': receivedSentChallenge.challengeDetails.sender_id,
    'receiver_id': receiver_id,
    'sender_repeat': receivedSentChallenge.challengeDetails.sender_repeat,
    'receiver_repeat': receiver_repeat,
    'receiver_node_id': receivedSentChallenge.node_id,
    'receiver_accept_time': receivedSentChallenge.challengeDetails.accept_time,
  };
}

bool SendChallengeRequest(String sender_id,String challenge_id,String sender_repeat){
  bool isDone;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  String ACCEPT_TIME = "";
  ChallengeDetails receiver = new ChallengeDetails(challenge_id,current_uid.toString(),sender_repeat,ACCEPT_TIME);
  ChallengeDetails sender = new ChallengeDetails(challenge_id,sender_id,sender_repeat,ACCEPT_TIME);
  try
  {
    //**********************SentRequests*******************************
    DatabaseReference ref1 = FirebaseDatabase.instance.ref()
        .child("USERS")
        .child("$current_uid")
        .child("SentChallenges");
    ref1.push().set(sender.toJson());

    //***********************ReceivedRequests**************************
    DatabaseReference ref2 = FirebaseDatabase.instance.ref()
        .child("USERS")
        .child("${sender_id}")
        .child("ReceivedChallenges");
    ref2.push().set(receiver.toJson());
    isDone= true;
  }
  catch(e){
    isDone=false;
    print(e);
  }
  return isDone;
}

Future<ChallengeListDetails> showResult(ChallengeListDetails challengeListDetails)async{

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;

  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${current_uid}/ChallengeList");

  ChallengeListDetails result = new ChallengeListDetails();

  print(current_uid);
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      element.children.forEach((element) {
        if(element.key.toString()=="challenge_id" && challengeListDetails.receivedSentChallenge.challengeDetails.challenge_id==element.value.toString()){
          result.receivedSentChallenge.challengeDetails.challenge_id = element.value.toString();
        }
        else if(element.key.toString()=="sender_id"){
          result.receivedSentChallenge.challengeDetails.sender_id = element.value.toString();
        }
        else if(element.key.toString()=="sender_repeat"){
          result.receivedSentChallenge.challengeDetails.sender_repeat = element.value.toString();
        }
        else if(element.key.toString()=="receiver_id"){
          result.receiver_id = element.value.toString();
        }
        else if(element.key.toString()=="receiver_repeat" ){
          print(element.value);
          result.receiver_repeat = element.value.toString();
        }
        else if(element.key.toString()=="receiver_node_id" ){
          result.receivedSentChallenge.node_id = element.value.toString();
        }
        else if(element.key.toString()=="receiver_accept_time" ){
          result.receivedSentChallenge.challengeDetails.accept_time = element.value.toString();
        }
      });
    });
  });
  return result;
}

Future<List<ReceivedSentChallenge>> showAllReceivedChallenges()async{

  List<ReceivedSentChallenge> allChallenges = [];

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;

  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${current_uid}/ReceivedChallenges");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      ReceivedSentChallenge receivedSentChallenge = new ReceivedSentChallenge();
      receivedSentChallenge.node_id = element.key.toString();
      element.children.forEach((element) {
        if(element.key.toString()=="challenge_id"){
          receivedSentChallenge.challengeDetails.challenge_id = element.value.toString();
        }
        else if(element.key.toString()=="sender_id"){
          receivedSentChallenge.challengeDetails.sender_id = element.value.toString();
        }
        else if(element.key.toString()=="sender_repeat"){
          receivedSentChallenge.challengeDetails.sender_repeat = element.value.toString();
        }
        else if(element.key.toString()=="accept_time"){
          receivedSentChallenge.challengeDetails.accept_time = element.value.toString();
        }
      });
      allChallenges.add(receivedSentChallenge);
    });
  });

  return allChallenges;
}

Future<List<ReceivedSentChallenge>> showAllSentChallenges()async{

  List<ReceivedSentChallenge> allChallenges = [];

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;

  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${current_uid}/SentChallenges");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      ReceivedSentChallenge receivedSentChallenge = new ReceivedSentChallenge();
      receivedSentChallenge.node_id = element.key.toString();
      element.children.forEach((element) {
        if(element.key.toString()=="challenge_id"){
          receivedSentChallenge.challengeDetails.challenge_id = element.value.toString();
        }
        else if(element.key.toString()=="sender_id"){
          receivedSentChallenge.challengeDetails.sender_id = element.value.toString();
        }
        else if(element.key.toString()=="sender_repeat"){
          receivedSentChallenge.challengeDetails.sender_repeat = element.value.toString();
        }
        else if(element.key.toString()=="accept_time"){
          receivedSentChallenge.challengeDetails.accept_time = element.value.toString();
        }
      });
      allChallenges.add(receivedSentChallenge);
    });
  });

  return allChallenges;
}

Future<ReceivedSentChallenge> showReceivedChallenges(String receiver_node_id)async{

  ReceivedSentChallenge receivedSentChallenge = new ReceivedSentChallenge();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;

  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${current_uid}/ReceivedChallenges/${receiver_node_id}");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      receivedSentChallenge.node_id = element.key.toString();
        if(element.key.toString()=="challenge_id"){
          receivedSentChallenge.challengeDetails.challenge_id = element.value.toString();
        }
        else if(element.key.toString()=="sender_id"){
          receivedSentChallenge.challengeDetails.sender_id = element.value.toString();
        }
        else if(element.key.toString()=="sender_repeat"){
          receivedSentChallenge.challengeDetails.sender_repeat = element.value.toString();
        }
        else if(element.key.toString()=="accept_time"){
          receivedSentChallenge.challengeDetails.accept_time = element.value.toString();
        }
    });
  });
  return receivedSentChallenge;
}

Future<ReceivedSentChallenge> showSentChallenges(String sent_node_id)async{

  ReceivedSentChallenge receivedSentChallenge = new ReceivedSentChallenge();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;

  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${current_uid}/SentChallenges/${sent_node_id}");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      receivedSentChallenge.node_id = element.key.toString();
      if(element.key.toString()=="challenge_id"){
        receivedSentChallenge.challengeDetails.challenge_id = element.value.toString();
      }
      else if(element.key.toString()=="sender_id"){
        receivedSentChallenge.challengeDetails.sender_id = element.value.toString();
      }
      else if(element.key.toString()=="sender_repeat"){
        receivedSentChallenge.challengeDetails.sender_repeat = element.value.toString();
      }
      else if(element.key.toString()=="accept_time"){
        receivedSentChallenge.challengeDetails.accept_time = element.value.toString();
      }
    });
  });
  return receivedSentChallenge;
}

void ChallengeStarted(ReceivedSentChallenge receivedSentChallenge) async{

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  FirebaseDatabase.instance
      .ref("USERS/${current_uid}/ReceivedChallenges/${receivedSentChallenge.node_id}")
      .update({
        'challenge_id': receivedSentChallenge.challengeDetails.challenge_id,
        'sender_id':receivedSentChallenge.challengeDetails.sender_id,
        'sender_repeat':receivedSentChallenge.challengeDetails.sender_repeat,
        'accept_time': receivedSentChallenge.challengeDetails.accept_time});
}

void AcceptChallenge(ChallengeListDetails challengeListDetails){

  print(challengeListDetails.receivedSentChallenge.challengeDetails.sender_id);
  DatabaseReference ref1 = FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("${challengeListDetails.receiver_id}")
      .child("ChallengeList");
  ref1.push().set(challengeListDetails.toJson());

  DatabaseReference ref2 = FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("${challengeListDetails.receivedSentChallenge.challengeDetails.sender_id}")
      .child("ChallengeList");
  ref2.push().set(challengeListDetails.toJson());
}

Future<String> getUserName(String uid) async{

  String name = "";
  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${uid}/UserInfo");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      if(element.key.toString()=="name"){
        name = element.value.toString();
      }
    });
  });

  return name;
}

Future<String> getUrl(String challenge_id)async{
  String url = "";
  if(challenge_id=="1"){
    challenge_id="ONE";
  }
  else if(challenge_id=="2"){
    challenge_id="TWO";
  }
  else if(challenge_id=="3"){
    challenge_id="THREE";
  }
  DatabaseReference ref = FirebaseDatabase.instance.ref("CHALLENGES/${challenge_id}");
  await ref.once().then((value) {
    value.snapshot.children.forEach((element) {
      if(element.key.toString()=="videoURL"){
        url = element.value.toString();
      }
    });
  });
  return url;
}

void deleteChallenge(String node_id){

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
        if(element2.key.toString()=="receiver_node_id" && element2.value.toString()==node_id){
          FirebaseDatabase.instance.ref().child("USERS").child("$current_uid").child("ChallengeList").child("$ChildToDelete").remove();
        }
        else{
          print(ChildToDelete);
        }
      });
    });
  });
  FirebaseDatabase.instance.ref().child("USERS").child("$current_uid").child("ReceivedChallenges").child("$node_id").remove();
}

