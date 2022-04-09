import 'package:firebase_database/firebase_database.dart';
import 'UsersList.dart';

Future<List<Userz>> showUSERS_LIST () async{

  List<Userz> Users = [];
  DatabaseReference ref = FirebaseDatabase.instance.ref("USERS_TO_VIEW");
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