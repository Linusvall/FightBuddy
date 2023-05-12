import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:core';
import 'package:fight_buddy/handlers/user.dart' as fightbuddy;

import '../handlers/user_handler.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ProfilePageState extends State<ProfilePage> {
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

            return DataTable(
              columns: <DataColumn>[
                DataColumn(
                    label: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        image: NetworkImage(thisUser.profilePicture)),
                  ),
                )),
                const DataColumn(
                  label: Text(
                    '',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(cells: <DataCell>[
                  const DataCell(Text('Namn')),
                  DataCell(Text(thisUser.firstName)),
                ]),
                DataRow(cells: <DataCell>[
                  const DataCell(Text('Efteramn')),
                  DataCell(Text(thisUser.lastName)),
                ]),
                DataRow(cells: <DataCell>[
                  const DataCell(Text('Ålder')),
                  DataCell(Text(thisUser.age.toString())),
                ]),
                DataRow(cells: <DataCell>[
                  const DataCell(Text('Vikt')),
                  DataCell(Text(thisUser.weight.toString())),
                ]),
                DataRow(cells: <DataCell>[
                  const DataCell(Text('Längd')),
                  DataCell(Text(thisUser.height)),
                ]),
              ],
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
        });
  }
}
