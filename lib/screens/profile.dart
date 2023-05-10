import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:core';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ProfilePageState extends State<ProfilePage> {
  List<User> users2 = [];
  String firstname = "";
  String lastname = "";
  int age = 0;
  String height = '';
  int weight = 0;
  bool isLoadingData = true;

  @override
  void initState() {
    fetch();
    super.initState();
  }

  fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((ds) {
      setState(() {
        firstname = ds.data()?['firstName'];
        lastname = ds.data()?['lastName'];
        age = ds.data()?['age'] as int;
        height = ds.data()?['height'];
        weight = ds.data()?['weight'] as int;
        isLoadingData = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingData
        ? LoadingIndicator()
        : DataTable(
            columns: <DataColumn>[
              DataColumn(
                  label: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                      image: AssetImage("lib/assets/images/face.png")),
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
                DataCell(Text(firstname)),
              ]),
              DataRow(cells: <DataCell>[
                const DataCell(Text('Efteramn')),
                DataCell(Text(lastname)),
              ]),
              DataRow(cells: <DataCell>[
                const DataCell(Text('Ålder')),
                DataCell(Text(age.toString())),
              ]),
              DataRow(cells: <DataCell>[
                const DataCell(Text('Vikt')),
                DataCell(Text(weight.toString())),
              ]),
              DataRow(cells: <DataCell>[
                const DataCell(Text('Längd')),
                DataCell(Text(height)),
              ]),
            ],
          );
  }
}
