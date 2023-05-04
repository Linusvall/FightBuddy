import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final instance = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future changePassword(String password) async {
    //Pass in the password to updatePassword.
    user?.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  Future updateUserGender(String gender) async {
    final user1 = FirebaseAuth.instance.currentUser;
    var uid = user1?.uid;

    return await userCollection.doc(uid).update({'gender': gender});
  }

  Future updateUserFirstAndLastName(String firstName, String lastName) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  Future updateUserHeightAndWeight(String height, int weight) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'weight': weight,
      'height': height,
    });
  }

  Future updateUserAge(int age) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'age': age,
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
