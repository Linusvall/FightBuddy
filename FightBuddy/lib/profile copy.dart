import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

int itemCount = 1;

class DatabaseManager {
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> getUserData(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      String? username = data[username];
    }
  }

  Future getUser() async {
    if (user != null) {
      String? userID = user?.uid;
      FirebaseFirestore.instance
          .collection('users2')
          .doc(userID)
          .get()
          .then((DocumentSnapshot snapshot) {
        getUserData(snapshot);
      });
    }
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return const ListTile(
            title: Text('Profil'),
          );
        });
  }
}
