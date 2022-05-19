import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'GetUsersFireBase.dart';

class UID{
  late var USER_ID;
  UID(this.USER_ID);

  UID.fromJson(Map<dynamic, dynamic> json) : USER_ID = json['USER_ID'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'USER_ID': USER_ID,
  };
}
class Userz{
  late String? uid;
  late String? uname;
  late String? photoURL;

  Userz({this.uid,this.uname,this.photoURL});
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
  //print(uid);
  FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$uid")
      .child("SentRequests")
      .once()
      .then((snapshot){
        snapshot.snapshot.children.forEach((element1) {
          element1.children.forEach((element2) {
              ChildToDelete = element1.key.toString();
              if(ChildToDelete!=""){
                FirebaseDatabase.instance.ref().child("USERS").child("$uid").child("SentRequests").child("$ChildToDelete").remove();
              }
              else{
                print(ChildToDelete);
              }
          });
        });
  });

  FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$current_uid")
      .child("ReceivedRequests")
      .once()
      .then((snapshot){
    snapshot.snapshot.children.forEach((element1) {
      element1.children.forEach((element2) {
          ChildToDelete = element1.key.toString();
          print(ChildToDelete);
          if(ChildToDelete!=""){
            print(ChildToDelete);
            FirebaseDatabase.instance.ref()
                .child("USERS")
                .child("$current_uid")
                .child("ReceivedRequests")
                .child("$ChildToDelete")
                .remove();
          }
          else{
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

  RejectCancelRequest(uid);
}

Future<List<Userz>> showFriendRequestsSetData () async {
  List<UID> friendsSet = [];
  List<Userz> Users = await showUSERS_LIST();
  List<Userz> result = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS/${current_uid}/ReceivedRequests");
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
        print(friendsSet[i].USER_ID);
        result.add(Users[j]);
      }
    }
  }
  return result;
}