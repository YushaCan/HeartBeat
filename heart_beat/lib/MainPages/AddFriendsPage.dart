import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heart_beat/FriendShip/GetUsersFireBase.dart';
import 'package:heart_beat/MainPages/ProfilePage.dart';
import '../Challenge/ChallengeFirebaseData.dart';
import '../FriendShip/FriendShipActions.dart';
import 'MainMenu.dart';

class AddFriends extends StatelessWidget {
  const AddFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Friend',
      home: new WillPopScope(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(0, 31, 235,0.6),
              title: Text("Add Friend"),
              titleTextStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            body: AddFriendPage(),
          ),
        onWillPop: () async{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainMenuPage()),
          );
          return true;
        },),

    );
  }
}

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({Key? key}) : super(key: key);

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  // For search engine
  TextEditingController searchController = TextEditingController();
  List<String> userNames = [];
  List<String> idItems = [];

  // SEARCHING ALGORTIHM
  void FilterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(idItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];

      dummySearchList.asMap().forEach((value, item) {
        if (item.contains(query)) {
          dummyListData.add(item);
          indexOfButtons.add(value);
          print(indexOfButtons);
          print(value);
        }
      });
      setState(() {
        friendsName.clear();
        friendsName.addAll(dummyListData);
        for (int i = 0; i < buttonItems.length; i++) {
          for (int j = 0; j < indexOfButtons.length; j++) {
            if (buttonItems[i] == buttonItems[j]) {
              if (buttonItems[i] && !buttonItems[indexOfButtons[j]]) {
                setState(() {
                  buttonItems[i] = !buttonItems[i];
                });
              } else if (!buttonItems[i] && buttonItems[indexOfButtons[j]]) {
                setState(() {
                  buttonItems[i] = !buttonItems[i];
                });
              }
            }
          }
        }
      });
      return;
    } else {
      setState(() {
        friendsName.clear();
        friendsName.addAll(idItems);
        setState(() {
          for (int i = 0; i < buttonItems.length; i++) {
            for (int j = 0; j < indexOfButtons.length; j++) {
              if ((i - 1) == indexOfButtons[j]) {
                if (!buttonItems[i] && buttonItems[indexOfButtons[j]]) {
                  setState(() {
                    buttonItems[j] = !buttonItems[j];
                  });
                }
              }
            }
          }
        });
        indexOfButtons.clear();
      });
    }
  }

  List<Userz> friendsSet = [];
  List<String> friendsName = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    friendsSet = await showUSERS_LIST();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    final current_uid = user?.uid;
    for (int i = 0; i < friendsSet.length; i++) {
      if(current_uid==friendsSet[i].uid){
        continue;
      }
      else{
        friendsName.add(friendsSet[i].uname.toString());
        //idItems.add(friendsName[i]);
      }
    }
    super.setState(() {});
  }

  // This list for add friend button
  List<bool> buttonItems = [];
  List<int> indexOfButtons = [];
  @override
  void initState() {
    super.initState();
    // This "for" is for buttons
    for (int i = 0; i < 20; i++) {
      buttonItems.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // SEARCH ENGİNE
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                FilterSearchResults(value);
              },
              decoration: InputDecoration(
                labelText: "Find Friend",
                hintText: "Search ...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          // LIST PART
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: friendsName.length,
            itemBuilder: (BuildContext context, int index) {
              // EVERY ELEMENT OF THE LIST
              return Card(
                child: InkWell(
                  onTap: () {
                    // OPEN UP THE PROFILE PAGE OF SELECTED USER
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        // THIS PROFILE PICTURE WILL BE PULL FROM THE DB
                        backgroundImage: AssetImage("assets/profilephoto.jpg"),
                      ),
                      Padding(padding: EdgeInsets.only(top: 40, left: 7)),
                      // User Names
                      //Text("${friendsSet[index].uname}"), // Usernames
                      Text(friendsName[index]),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          // Will change with the icon ...
                          if (indexOfButtons.isNotEmpty &&
                              !buttonItems[indexOfButtons[index]]) {
                            // The functions of Add Friend
                            AddFriend(friendsSet[indexOfButtons[index]]
                                .uid
                                .toString());
                            print(
                                "KULLANICININ ID'SI ======>   ${friendsSet[indexOfButtons[index]].uid.toString()}");
                            setState(() {
                              // To change the button state of the real index of that user
                              buttonItems[indexOfButtons[index]] =
                                  !buttonItems[indexOfButtons[index]];
                              // To change the button state of the temporary button
                              //buttonItems[index] = !buttonItems[index];
                            });
                          } else if (indexOfButtons.isEmpty &&
                              !buttonItems[index]) {
                            // The functions of Add Friend
                            AddFriend(friendsSet[index].uid.toString());
                            print(
                                "KULLANICININ ID'SI ======>   ${friendsSet[index].uid.toString()}");
                            setState(() {
                              buttonItems[index] = !buttonItems[index];
                            });
                            //
                            //print(friendsSet[index].uname);
                          }

                          // Also it will send friend request to the selected user
                          // sendRequest to items[index]

                          ///
                        },
                        icon: buttonItems[index]
                            ? Icon(Icons.more_horiz)
                            : Icon(Icons.person_add, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
