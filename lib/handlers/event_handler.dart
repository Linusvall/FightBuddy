import 'package:cloud_firestore/cloud_firestore.dart';

class EventHandler {
  final eventsCollection = FirebaseFirestore.instance.collection('events');

  createEventDocument(Map<String, dynamic> eventData) {
    final newDocRef = eventsCollection.doc();
    eventData['eventid'] = newDocRef.id;
    newDocRef.set(eventData);
  }

  //TODO: Metoder för att uppdatera event, som i user_handler + lägga till användare som skapat eventet?

/*  Future updateEventID() async {
    var uid = user?.uid;

    await userCollection.doc(uid).update({'uid': uid});
  } */

  /* void addAttendee(String uid){
    eventsCollection.where('')
  } */

  static Stream<DocumentSnapshot> getEventStream(
      String eventId, FirebaseFirestore firestore) {
    return firestore.collection('events').doc(eventId).snapshots();
  }
}
