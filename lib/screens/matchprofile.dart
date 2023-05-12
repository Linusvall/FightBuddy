import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fight_buddy/handlers/user.dart' as fightbuddy;
import '../assets/theme/colors.dart';

class MatchProfilePage extends StatefulWidget {
  final fightbuddy.User user;
  const MatchProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  MatchProfilePageState createState() => MatchProfilePageState();
}

class MatchProfilePageState extends State<MatchProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fightbuddy.User user = widget.user;
    return Scaffold(
        backgroundColor: fightbuddyGreen,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 4),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(user.profilePicture),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100))),
          child: Column(
            children: [
              Container(
                child: _userCard(user, context),
              ),
              Container(
                width: 350,
                height: 90,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 221, 223, 223),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                      child: Text(user.information,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text("Kampsportsstilar",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )))
            ],
          ),
        ));
  }
}

Widget _userCard(fightbuddy.User user, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.profilePicture),
            ),
            tileColor: Colors.white,
            title: Text(
              "${user.firstName} ${user.lastName}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
                "${user.age}år   ${user.weight}kg   ${user.gender}    ${user.place}",
                style: const TextStyle(
                  color: Colors.black,
                )),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ));
}

Future signOut() async {
  await FirebaseAuth.instance.signOut();
}
