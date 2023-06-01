import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fight_buddy/handlers/user.dart' as fightbuddy;
import '../assets/theme/colors.dart';
import '../handlers/user_handler.dart';
import 'matchprofile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isFirstButtonPressed = true;
  bool isSecondButtonPressed = false;

  List<fightbuddy.User> matches = [];
  List<fightbuddy.User> savedUsers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        //Realtime updates of changes to users information
        stream: UserHandler.getUserStream(
            FirebaseAuth.instance.currentUser!.uid, FirebaseFirestore.instance),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            fightbuddy.User thisUser = fightbuddy.User.fromMap(
                ((snapshot.data) as DocumentSnapshot).data()
                    as Map<String, dynamic>);
            return Scaffold(
              appBar: AppBar(
                  backgroundColor: fightbuddyLightgreen,
                  centerTitle: true,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          UserHandler().updateMatches();
                        },
                        child: const Icon(Icons.refresh),
                      ),
                      const SizedBox(width: 40),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isFirstButtonPressed = true;
                                isSecondButtonPressed = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: isFirstButtonPressed
                                  ? fightbuddySuperLightGreen
                                  : Colors.white,
                              fixedSize: const Size(135, 30),
                            ),
                            child: const Text("Matchningar",
                                style: TextStyle(color: Colors.black)),
                          )),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isFirstButtonPressed = false;
                            isSecondButtonPressed = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: isSecondButtonPressed
                              ? fightbuddySuperLightGreen
                              : Colors.white,
                          fixedSize: const Size(135, 30),
                        ),
                        child: const Text(
                          "Sparade",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  )),
              body: FutureBuilder(
                  future: _update(thisUser.matches, thisUser.savedUsers),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<List<fightbuddy.User>> data =
                          snapshot.data as List<List<fightbuddy.User>>;
                      matches = data[0];
                      savedUsers = data[1];
                      List<fightbuddy.User> displayedUsers =
                          isFirstButtonPressed ? matches : savedUsers;
                      return Center(
                        child: ListView.builder(
                            itemCount: displayedUsers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                  height: 165,
                                  child: _userCard(displayedUsers[index],
                                      isSecondButtonPressed, context));
                            }),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        'Delivery error: ${snapshot.error.toString()}',
                        style: const TextStyle(color: Colors.black),
                      );
                    } else {
                      return Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: const Color.fromRGBO(3, 137, 129, 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [Text("Updating...")],
                          ));
                    }
                  }),
              backgroundColor: fightbuddyLightgreen,
            );
          } else {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color.fromRGBO(3, 137, 129, 50),
            );
          }
        });
  }

  Widget _userCard(fightbuddy.User user, bool isSaved, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.profilePicture),
                ),
                tileColor: Colors.white,
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${user.firstName} ${user.lastName}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: isSaved
                            ? const Icon(Icons.bookmark)
                            : const Icon(Icons.bookmark_outline),
                        onPressed: () {
                          isSaved
                              ? UserHandler().removeUserFromSaved(user.uid)
                              : UserHandler().addUserToSaved(user.uid);
                        },
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${user.age}år   ${user.weight}kg   ${user.gender}    ${user.place}",
                        style: const TextStyle(
                          color: Colors.black,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 30,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: user.martialArts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                width: 85,
                                height: 150,
                                margin: const EdgeInsets.only(right: 7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                    child: Text(user.martialArts[index],
                                        style: const TextStyle(
                                            color: Colors.black))));
                          },
                        ))
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MatchProfilePage(user: user)));
                }),
          ],
        ));
  }
}

Future<List<List<fightbuddy.User>>> _update(
    List<String> matchesList, List<String> savedList) async {
  List<fightbuddy.User> matches = [];
  List<fightbuddy.User> savedUsers = [];

  for (String uid in matchesList) {
    matches.add(await UserHandler().getUser(uid));
  }

  for (String uid in savedList) {
    savedUsers.add(await UserHandler().getUser(uid));
  }

  return [matches, savedUsers];
}
