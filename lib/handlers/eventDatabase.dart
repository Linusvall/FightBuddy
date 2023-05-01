import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final instance = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('event');

  Future updateEventName(String name) async {
    var uid = user?.uid;

    return await userCollection.doc(uid).update({
      'name': name,
    });
  }
}
