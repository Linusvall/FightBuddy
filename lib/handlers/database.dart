import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final instance = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserGender(String gender) async {
    final user1 = FirebaseAuth.instance.currentUser;
    var uid = user1?.uid;

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

  Future updateAboutYouInformation(String information) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'information': information,
    });
  }

  Future updatePlace(String place) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'place': place,
    });
  }

  Future updateMemberOfClub(String club) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'club': club,
    });
  }

  Future updateMartialArts(String martialArts) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'martialArts': martialArts,
    });
  }

  Future updateLevel(String level) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'level': level,
    });
  }

  Future updateNewMartialArts(String martialArts) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'newMArtialArts': martialArts,
    });
  }

  Future updatePrefGender(String gender) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'prefGender': gender,
    });
  }

  Future updatePrefWeight(String weight) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'prefWeight': weight,
    });
  }

  Future updatePrefLevel(String level) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'prefLevel': level,
    });
  }

  Future createUsers(String email, String password) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
