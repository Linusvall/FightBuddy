import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final instance = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserGender(String gender) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({'gender': gender});
  }

  Future updateUserHeightAndWeight(String height, String weight) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'weight': weight,
      'height': height,
    });
  }

  Future updateUserDateOfBirth(String date) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'dateOfBirth': date,
    });
  }

  Future createDatabase() async {
    var uid = user?.uid;

    return await userCollection.doc(uid).set({
      'dateOfBirth': '',
      'weight': '',
      'height': '',
      'gender': '',
    });
  }

  Future createUsers(String email, String password) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
