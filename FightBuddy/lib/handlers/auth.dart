import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future registerUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return await userCollection.doc(_auth.currentUser?.uid).set({
        'dateOfBirth': '',
        'weight': '',
        'height': '',
        'gender': '',
        'profilePicture': '',
        'information': '',
        'place': '',
        'club': '',
        'martialArts': '',
        'level': '',
        'newMartialArts': '',
        'prefGender': '',
        'prefWeight': '',
        'prefLevel': '',
      });
    } catch (e) {}
  }
}
//gender - birthday - height and weight - profilepicture - information - where you want to train - member of club - fightstyles - information about certain style - new fighting styles - pref gender- pref weight - pref level