import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fight_buddy/handlers/algorithm_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fight_buddy/handlers/user.dart' as fightbuddy;
import 'package:firebase_storage/firebase_storage.dart';

class UserHandler {
  final user = FirebaseAuth.instance.currentUser;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserID() async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({'uid': uid});
  }

  Future uploadImage(File file) async {
    var uid = user?.uid;
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('images/${file.path}');
    final TaskSnapshot snapshot = await storageRef.putFile(file);
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    await userCollection.doc(uid).update({'profilePicture': downloadUrl});
  }

  Future<List<String>> getAllUserIds() async {
    List<String> userIds = [];
    QuerySnapshot querySnapshot = await userCollection.get();
    for (var document in querySnapshot.docs) {
      userIds.add(document.id);
    }
    return userIds;
  }

  getUserId() {
    var uid = user?.uid;
    return uid;
  }

  Future<Set<String>> getUIDsFromMartialArt(List<String> martialArts) async {
    Set<String> userIDs = <String>{};
    List<Future<void>> futures = [];

    for (String martialArt in martialArts) {
      Future<void> future = FirebaseFirestore.instance
          .collection('martialArts')
          .doc(martialArt)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          List<dynamic> userIds = documentSnapshot.get('userIDs');
          userIDs.addAll(userIds.map((id) => id.toString()).toSet());
        }
      });
      futures.add(future);
    }
    await Future.wait(futures);

    return userIDs;
  }

  updateMatches() async {
    var uid = user?.uid;
    fightbuddy.User fightbuddyUser = await getUser(uid!);

    findMatches(fightbuddyUser);
  }

  //Parameter is a specific user ID and returns a user object tied to it
  Future<fightbuddy.User> getUser(String userId) async {
    DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    return fightbuddy.User.fromMap(document.data() as Map<String, dynamic>);
  }

  //Update realtime changes through stream
  static Stream<DocumentSnapshot> getUserStream(
      String userId, FirebaseFirestore firestore) {
    return firestore.collection('users').doc(userId).snapshots();
  }

  Future putUserInMartialArtsMap(List<String> martialArts) async {
    final CollectionReference martialArtsCollection =
        FirebaseFirestore.instance.collection('martialArts');
    String? uid = user?.uid;
    for (String str in martialArts) {
      await martialArtsCollection.doc(str).update({
        'userIDs': FieldValue.arrayUnion([uid])
      });
    }
  }

  Future updateUserMatchesList(List<String> matches) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({'uidList': matches});
  }

  Future updateUserGender(String gender) async {
    final user1 = FirebaseAuth.instance.currentUser;
    var uid = user1?.uid;

    await userCollection.doc(uid).update({'gender': gender});
  }

  Future updateUserFirstAndLastName(String firstName, String lastName) async {
    final user1 = FirebaseAuth.instance.currentUser;
    var uid = user1?.uid;

    await userCollection.doc(uid).update({
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  Future updateUserHeightAndWeight(String height, int weight) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({
      'weight': weight,
      'height': height,
    });
  }

  Future updateUserAge(int age) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({
      'age': age,
    });
  }

  Future updateAboutYouInformation(String information) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({
      'information': information,
    });
  }

  Future updatePlace(String place) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({
      'place': place,
    });
  }

  Future updateMemberOfClub(String club) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({
      'club': club,
    });
  }

  Future yearsOfPractice(String years) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({
      'yearsOfPractice': years,
    });
  }

  Future updateMartialArts(List<String> martialArts) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({
      'martialArts': martialArts,
    });
  }

  Future updateLevel(List<String> level) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({
      'level': level,
    });
  }

  Future updateNewMartialArts(List<String> martialArts) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({
      'newMartialArts': martialArts,
    });
  }

  Future updatePrefGender(List<String> gender) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({
      'prefGender': gender,
    });
  }

  Future updatePrefWeight(int weight) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({
      'prefWeight': weight,
    });
  }

  Future updatePrefLevel(String level) async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({
      'prefLevel': level,
    });
  }

  Future createUsers(String email, String password) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
}
