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
              body: Center(
                child: FutureBuilder(
                    future: _update(thisUser.uidList),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<fightbuddy.User> matches =
                            snapshot.data as List<fightbuddy.User>;
                        return Center(
                          child: ListView.builder(
                              itemCount: matches.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                    height: 150,
                                    child: _userCard(matches[index], context));
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
              ),
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

  Widget _userCard(fightbuddy.User user, BuildContext context) {
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
                        icon: const Icon(Icons.message_rounded),
                        onPressed: () {
                          //Implementera att den gå till chatten
                          print("pressed icon message");
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

Future<List<fightbuddy.User>> _update(List<String> uidList) async {
  List<fightbuddy.User> userList = [];
  for (String uid in uidList) {
    userList.add(await UserHandler().getUser(uid));
  }
  return userList;
}

Future signOut() async {
  await FirebaseAuth.instance.signOut();
}
