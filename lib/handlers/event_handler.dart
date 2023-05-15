import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventHandler {
  Future<void> createEventDocument(Map<String, dynamic> eventData) async {
    CollectionReference eventsCollection =
        FirebaseFirestore.instance.collection('events');
    await eventsCollection.add(eventData);
  }

  //TODO: Metoder för att uppdatera event, som i user_handler + lägga till användare som skapat eventet?

  static Stream<DocumentSnapshot> getEventStream(
      String userId, FirebaseFirestore firestore) {
    return firestore
        .collection('events')
        .doc('ITvhZfJbpmPmv3dGirKq')
        .snapshots();
  }
}
