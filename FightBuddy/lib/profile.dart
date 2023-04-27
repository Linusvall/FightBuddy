import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


int itemCount = 1;

class DatabaseManager {

  User? user = FirebaseAuth.instance.currentUser;


Future getUser() async {

  if (user != null){
    String? userID = user?.uid;
    FirebaseFirestore.instance
      .collection('users')
  }

 

  
}
}
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: itemCount,  
      itemBuilder: (
      BuildContext context, int index) {
      return const ListTile(
        title: Text('Profil'),
      );
    });
  }
}