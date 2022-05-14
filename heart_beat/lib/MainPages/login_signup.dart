import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../UYELIK/LoginPage.dart';

class loginSignup extends StatelessWidget {
  const loginSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserDataList()),
                );
              },
              child: Text("Login")
          ),
          TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text("Sign Up"))
        ],
      ),
    );
  }
}
