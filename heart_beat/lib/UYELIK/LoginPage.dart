import 'package:flutter/material.dart';
import '../InsertToDatabaseCode/USER_DATA_DAO';
import '../InsertToDatabaseCode/USER_DATA';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'SignUpPage.dart';
import '../MainPages/MainMenu.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataListState extends State<UserDataList>{

TextEditingController _userPasswordController = TextEditingController();
TextEditingController _userEmailController = TextEditingController();
TextEditingController _userNameController = TextEditingController();

@override
  Widget build(BuildContext context){
    return Scaffold(
      body: SignUp(),
    );
  }

bool _canSendUserData() => _userNameController.text.length > 0 && _userPasswordController.text.length > 0 && _userEmailController.text.length > 0;

void _sendUserData() {
  if (_canSendUserData()) {
    final userData = USER_DATA(_userNameController.text,_userEmailController.text,_userPasswordController.text);
    widget.userdataDAO.saveUserData(userData);
    _userNameController.clear();
    _userEmailController.clear();
    _userPasswordController.clear();
    setState(() {});
  }
}

}

class UserDataList extends StatefulWidget{
  UserDataList({Key? key}): super(key: key);

  final userdataDAO = USER_DATA_DAO();

  @override
  UserDataListState createState()=> UserDataListState();
}

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  bool seePassword = true;
  bool lockIcon = true;

  String passwordText = "";
  String confirmedPasswordText = "";
  String email = "";

  void Toggle() {
    setState(() {
      seePassword = !seePassword;
    });
  }

  Future<void> _loginUser() async {
    try{
      print("user:  $email");
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: _userPasswordController.text);
      print("user:  $userCredential");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainMenuPage()),
      );
    } on FirebaseAuthException catch (e){
      print("error: $e");
    }catch(e){
      print("error: $e");
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainMenuPage()));
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // This row is for justify the upper space of the Heart Beat
            Row(children: <Widget>[
              const Text(
                '',
                style: TextStyle(
                  fontSize: 100,
                ),
              ),
            ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Heart',
                    style: TextStyle(
                      color: Color.fromARGB(255, 199, 20, 8),
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                  const Text(
                    ' Beat',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  )
                ]),
            Row(children: <Widget>[
              const Text(
                '',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 45, vertical: 8),
              child: TextField(
                onChanged: (value) {
                  email = value;
                }, //bu email
                decoration: InputDecoration(
                  // icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 45, vertical: 8),
              child: TextFormField(
                obscureText: seePassword,
                controller: _userPasswordController,//bu password
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      Toggle();
                      lockIcon = !lockIcon;
                    },
                    icon: lockIcon ? Icon(Icons.lock) : Icon(Icons.lock_open),
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
            ),
            // Sign Up Button
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset('assets/images/sign-in-with-google-icon-3.jpg'),
                      iconSize: 150,
                      onPressed: () {
                        signup(context);},
                    ),ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 5, 115, 218),
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
            textStyle: TextStyle(
              fontSize: 20,
            )),
        child: Text('Login'),
        onPressed: () {
          _loginUser();
          // When tapped, if everything is right, passed to the Main Menu Page. It needs an animation between two pages.
        }),
                  ],
                ),
            ),
            // Sign Up Button
          ],
        ),
      ),
    );
  }
}