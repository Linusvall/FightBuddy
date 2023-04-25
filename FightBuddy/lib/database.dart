import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final user = FirebaseAuth.instance.currentUser;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, int age) async {
    var uid;
    if (user != null) {
      uid = user?.uid;
    }
    return await userCollection.doc(uid).set({
      'name': name,
      'age': age,
    });
  }

  Future updateUserGender(String gender) async {
    var uid;
    if (user != null) {
      uid = user?.uid;
    }
    return await userCollection.doc(uid).set({'gender': gender});
  }

  Future updateUserHeightAndWeight(String height, String weight) async {
    var uid;
    if (user != null) {
      uid = user?.uid;
    }
    return await userCollection.doc(uid).set({
      'weight': weight,
      'height': height,
    });
  }
}

Future createUsers(String email, String password) async {
  FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);
}
