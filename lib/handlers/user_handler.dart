import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fight_buddy/handlers/user.dart' as fightbuddy;
import 'package:firebase_storage/firebase_storage.dart';

class UserHandler {
  final user = FirebaseAuth.instance.currentUser;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<List<fightbuddy.User>> getUserList() async {
    fightbuddy.User fightbuddyUser = await getUser(user!.uid);
    fightbuddyUser.updateUserList();
    return fightbuddyUser.userList;
  }

  //Parameter is a specific user ID and returns a user object tied to it
  static Future<fightbuddy.User> getUser(String userId) async {
    DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    return fightbuddy.User.fromMap(document.data() as Map<String, dynamic>);
  }

  //Update realtime changes through stream
  static Stream<DocumentSnapshot> getUserStream(
      String userId, FirebaseFirestore firestore) {
    return firestore.collection('users').doc(userId).snapshots();
  }

  Future updateUserList() async {}

  Future<String> getPhotoUrl(String userId, FirebaseStorage storage) async {
    return storage.ref().child("$userId.png").getDownloadURL();
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
