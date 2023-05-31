import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fight_buddy/assets/theme/colors.dart';
import 'package:fight_buddy/screens/registration/martialarts.dart';
import 'package:fight_buddy/screens/registration/newmartialarts.dart';
import 'package:fight_buddy/screens/registration/prefgender.dart';
import 'package:fight_buddy/screens/registration/preflevel.dart';
import 'package:fight_buddy/screens/registration/prefweight.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fight_buddy/handlers/user.dart' as fightbuddy;

import '../../handlers/user_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChangeProfilePage(),
    );
  }
}

class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({super.key});

  @override
  ChangeProfilePageState createState() => ChangeProfilePageState();
}

class ChangeProfilePageState extends State<ChangeProfilePage> {
  String gender = '';
  var items = [
    const DropdownMenuItem(value: "Man", child: Text("Man")),
    const DropdownMenuItem(value: "Kvinna", child: Text("Kvinna")),
    const DropdownMenuItem(value: "Annat", child: Text("Annat"))
  ];

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
            gender = thisUser.gender;

            return Scaffold(
                appBar: AppBar(
                  iconTheme: const IconThemeData(
                    color: Color.fromRGBO(
                        3, 137, 129, 50), //change your color here
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white10,
                ),
                body: ListView(children: <Widget>[
                  const ListTile(
                    title: Text("Profil inställningar"),
                    textColor: Color.fromRGBO(102, 99, 99, 0.808),
                  ),
                  const Divider(),
                  ListTile(
                      title: const Text("Kön"),
                      trailing: GestureDetector(
                          child: const Icon(Icons.edit),
                          onTap: () {
                            genderPopup();
                          })),
                  const Divider(),
                  ListTile(
                      title: const Text("Vikt & Längd"),
                      trailing: GestureDetector(
                          child: const Icon(Icons.edit),
                          onTap: () {
                            weightAndHeightPopup(
                                thisUser.weight.toString(), thisUser.height);
                          })),
                  const Divider(),
                  ListTile(
                      title: const Text("Fightbuddy preferenser"),
                      trailing: GestureDetector(
                          child: const Icon(Icons.edit),
                          onTap: () {
                            preferencesPopup();
                          })),
                  const Divider(),
                  ListTile(
                      title: const Text("Kampsporter"),
                      trailing: GestureDetector(
                          child: const Icon(Icons.edit),
                          onTap: () {
                            martialArtPopup();
                          })),
                ]));
          }
          return Container();
        });
  }

  preferencesPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Preferenser"),
            content: SingleChildScrollView(
              child: Column(children: [
                ListTile(
                    title: const Text("Kön"),
                    trailing: GestureDetector(
                        child: const Icon(Icons.edit),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PrefGenderPage(
                                        sourceScreen: 'updateProfile',
                                      )));
                        })),
                const Divider(),
                ListTile(
                    title: const Text("Viktklass"),
                    trailing: GestureDetector(
                        child: const Icon(Icons.edit),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PrefWeightPage(
                                        sourceScreen: 'updateProfile',
                                      )));
                        })),
                const Divider(),
                ListTile(
                    title: const Text("Nivå"),
                    trailing: GestureDetector(
                        child: const Icon(Icons.edit),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PrefLevelPage(
                                        sourceScreen: 'updateProfile',
                                      )));
                        }))
              ]),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  UserHandler().updateUserGender(gender);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Uppdatera",
                  style: TextStyle(color: fightbuddyLightgreen),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Avbryt',
                  style: TextStyle(color: fightbuddyLightgreen),
                ),
              ),
            ],
          );
        });
  }

  martialArtPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Kampsporter"),
            content: SingleChildScrollView(
              child: Column(children: [
                ListTile(
                    title: const Text("Kampsporter jag utövar"),
                    trailing: GestureDetector(
                        child: const Icon(Icons.edit),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MartialArtsPage(
                                        sourceScreen: 'updateProfile',
                                      )));
                        })),
                const Divider(),
                ListTile(
                    title: const Text("Kampsporter jag vill prova"),
                    trailing: GestureDetector(
                        child: const Icon(Icons.edit),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NewMartialArtsPage(
                                        sourceScreen: 'updateProfile',
                                      )));
                        })),
              ]),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  UserHandler().updateUserGender(gender);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Uppdatera",
                  style: TextStyle(color: fightbuddyLightgreen),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Avbryt',
                  style: TextStyle(color: fightbuddyLightgreen),
                ),
              ),
            ],
          );
        });
  }

  genderPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Kön"),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<String>(
                  value: gender,
                  onChanged: (String? newValue) {
                    setState(() {
                      gender = newValue!;
                    });
                  },
                  items: items,
                );
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  UserHandler().updateUserGender(gender);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Uppdatera",
                  style: TextStyle(color: fightbuddyLightgreen),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Avbryt',
                  style: TextStyle(color: fightbuddyLightgreen),
                ),
              ),
            ],
          );
        });
  }

  weightAndHeightPopup(String weight, String height) {
    final weightController = TextEditingController();
    final heightController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Vikt & Längd"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  decoration: InputDecoration(
                    hintText: weight,
                    labelText: "Vikt kg",
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: heightController,
                  decoration: InputDecoration(
                    hintText: height,
                    labelText: "Längd cm",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                UserHandler().updateUserHeightAndWeight(
                    heightController.text, int.parse(weightController.text));
                Navigator.of(context).pop();
              },
              child: const Text(
                "Uppdatera",
                style: TextStyle(color: fightbuddyLightgreen),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Avbryt',
                style: TextStyle(color: fightbuddyLightgreen),
              ),
            ),
          ],
        );
      },
    );
  }
}
