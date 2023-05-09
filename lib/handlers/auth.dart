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
        'firstName': '',
        'lastName': '',
        'age': '',
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
        'userList': '',
      });
    } catch (e) {}
  }
}
