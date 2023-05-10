import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fight_buddy/handlers/user.dart' as fightbuddy;
import '../handlers/user_handler.dart';

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
              appBar: AppBar(),
              body: Center(
                child: FutureBuilder(
                    future: _update(thisUser.uidList),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<fightbuddy.User> userList =
                            snapshot.data as List<fightbuddy.User>;
                        return Center(
                          child: ListView.builder(
                              itemCount: userList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                    height: 310,
                                    child: _userCard(userList[index], context));
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
              backgroundColor: Theme.of(context).colorScheme.background,
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
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              tileColor: Colors.white,
              title: Text(
                user.firstName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              subtitle: Text("${user.age} år  ${user.weight}kg ${user.gender}",
                  style: const TextStyle(
                    color: Colors.black,
                  )),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ));
  }
}

Future<List<fightbuddy.User>> _update(List<String> uidList) async {
  List<fightbuddy.User> userList = [];
  for (String uid in uidList) {
    userList.add(await UserHandler.getUser(uid));
  }
  return userList;
}

Future signOut() async {
  await FirebaseAuth.instance.signOut();
}
