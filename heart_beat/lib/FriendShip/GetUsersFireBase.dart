import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'FriendShipActions.dart';

Future<List<Userz>> showUSERS_LIST () async{

  List<Userz> Users = [];
  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS_TO_VIEW");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      Userz user = new Userz();
      element.children.forEach((element){
          if(element.key=="uid"){
            user.uid = element.value.toString();
          }
          else if(element.key=="name"){
            user.uname = element.value.toString();
          }
      });
      Users.add(user);
      });
    });
  return Users;
}

Future<List<Userz>> FriendShipSentRequests () async{
  List<Userz> Users = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  final current_uid = user?.uid;
  DatabaseReference ref = FirebaseDatabase.instance.ref()
      .child("USERS")
      .child("$current_uid")
      .child("SentRequests");
  await ref.once().then((value){
    value.snapshot.children.forEach((element) {
      Userz user = new Userz();
      element.children.forEach((element){
        print(element.value);
        user.uid = element.value.toString();
      });
      Users.add(user);
    });
  });
  return Users;
}