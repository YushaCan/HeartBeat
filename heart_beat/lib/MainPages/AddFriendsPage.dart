import 'package:flutter/material.dart';
import '../Challenge/ChallengeFirebaseData.dart';
import '../FriendShip/FriendShipActions.dart';

class AddFriends extends StatelessWidget {
  const AddFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Friend',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text("Add Friend"),
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: AddFriend(),
      ),
    );
  }
}

class AddFriend extends StatefulWidget {
  const AddFriend({Key? key}) : super(key: key);

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  // For search engine
  TextEditingController searchController = TextEditingController();
  List<String> userNames = [];
  var idItems = [];

  // SEARCHING ALGORTIHM
  void FilterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(userNames);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];

      dummySearchList.asMap().forEach((value, item) {
        if (item.contains(query)) {
          dummyListData.add(item);
          print(value);
          indexOfButtons.add(value);
          print(indexOfButtons);
        }
      });
      setState(() {
        idItems.clear();
        idItems.addAll(dummyListData);
        // BU FOR DÖNGÜSÜYTLE UĞRAŞ AGAAAAAAAAAAAAAA
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
        //////////////////////////
      });
      return;
    } else {
      setState(() {
        idItems.clear();
        idItems.addAll(userNames);
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

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    friendsSet = await showFriendsSetData();
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
    for (int i = 0; i < 20; i++) {
      // WILL PULL FROM DATABASE
      userNames.add("User $i");
      idItems.add(userNames[i]);
      ////////////////////////////
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

            /*Card(
              color: Colors.grey,
              elevation: 5,
              child: InkWell(
                onTap: () {
                  // TAP SEARCH BUTTON AND TYPE
                  showSearch(context: context, delegate: )
                },
                child: SizedBox(
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 5)),
                      Icon(Icons.search),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Text(
                        // It will dissapear when user tap on the InkWell
                        "Search ...",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),*/
          ),
          // LIST PART
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: friendsSet.length,
            itemBuilder: (BuildContext context, int index) {
              // EVERY ELEMENT OF THE LIST
              return Card(
                //color: Colors.white,
                child: InkWell(
                  onTap: () {
                    // OPEN UP THE PROFILE PAGE OF SELECTED USER
                  },
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        // THIS PROFILE PICTURE WILL BE PULL FROM THE DB
                        backgroundImage: AssetImage("assets/profilephoto.jpg"),
                      ),
                      Padding(padding: EdgeInsets.only(top: 40, left: 7)),
                      // User Names
                      Text("${friendsSet[index].uname}"), // Usernames
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          // Will change with the icon ...
                          if (indexOfButtons.isNotEmpty &&
                              !buttonItems[indexOfButtons[index]]) {
                            setState(() {
                              // To change the button state of the real index of that user
                              buttonItems[indexOfButtons[index]] =
                                  !buttonItems[indexOfButtons[index]];
                              // To change the button state of the temporary button
                              buttonItems[index] = !buttonItems[index];
                            });
                          } else if (indexOfButtons.isEmpty &&
                              !buttonItems[index]) {
                            setState(() {
                              buttonItems[index] = !buttonItems[index];
                            });
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
