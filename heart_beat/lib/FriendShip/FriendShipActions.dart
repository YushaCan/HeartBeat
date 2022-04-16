import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UID{
  final  USER_ID;
  UID(this.USER_ID);

  UID.fromJson(Map<dynamic, dynamic> json) : USER_ID = json['USER_ID'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'USER_ID': USER_ID,
  };
}

void AddFriend(String uid){
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  UID hedef_user = new UID(uid);
  UID asil_user = new UID(current_uid);

  //**********************SentRequests*******************************
  DatabaseReference ref1 = FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$current_uid")
      .child("SentRequests");
  ref1.push().set(hedef_user.toJson());

  //***********************ReceivedRequests**************************
  DatabaseReference ref2 = FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("${hedef_user.USER_ID}")
      .child("ReceivedRequests");
  ref2.push().set(asil_user.toJson());

}
void RejectCancelRequest(String uid) async{

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  String ChildToDelete;
  /**/
  FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$current_uid")
      .child("SentRequests")
      .once()
      .then((snapshot){
        snapshot.snapshot.children.forEach((element1) {
          element1.children.forEach((element2) {
            if(element2.value.toString()==uid){
              ChildToDelete = element1.key.toString();
              if(ChildToDelete!=""){
                FirebaseDatabase.instance.ref().child("USERS").child("$current_uid").child("SentRequests").child("$ChildToDelete").remove();
              }
              else{
              }
            }
          });
        });
  });

  FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$uid")
      .child("ReceivedRequests")
      .once()
      .then((snapshot){
    snapshot.snapshot.children.forEach((element1) {
      element1.children.forEach((element2) {
        if(element2.value.toString()==current_uid){
          ChildToDelete = element1.key.toString();
          print(ChildToDelete);
          if(ChildToDelete!=""){
            FirebaseDatabase.instance.ref().child("USERS").child("$uid").child("ReceivedRequests").child("$ChildToDelete").remove();
          }
          else{
          }
        }
      });
    });
  });
}


void AcceptFriend(String uid){
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  UID hedef_user = new UID(uid);
  UID asil_user = new UID(current_uid);

  //**********************SentRequests*******************************
  DatabaseReference ref1 = FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$current_uid")
      .child("FriendsList");
  ref1.push().set(hedef_user.toJson());

  //***********************ReceivedRequests**************************
  DatabaseReference ref2 = FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("${hedef_user.USER_ID}")
      .child("FriendsList");
  ref2.push().set(asil_user.toJson());

}