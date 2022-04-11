import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'UsersList.dart';


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
void RejectRequest(String uid) async{
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  Query query = ref
      .child("USERS")
      .child("$current_uid")
      .child("SentRequests");
      //.orderByChild("USER_ID").equalTo("$uid");
  DataSnapshot event = await query.get();
  event.children.forEach((element) {
    print(element.value);
    element.children.forEach((element) {
      print(element.value);
    });
  });
}

