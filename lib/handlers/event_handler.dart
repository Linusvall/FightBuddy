import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../../handlers/user_handler.dart';
import 'package:flutter/widgets.dart';

class EventHandler {
  final eventsCollection = FirebaseFirestore.instance.collection('events');

  createEventDocument(Map<String, dynamic> eventData) async {
    final newDocRef = eventsCollection.doc();
    String eventId = newDocRef.id;
    eventData['eventId'] = eventId;
    UserHandler().updateCreatedEvents(eventId);
    UserHandler().updateAttendingEvents(eventId);
    File? image = eventData['eventImage'];
    eventData['eventImage'] = '';
    newDocRef.set(eventData);
    if (image != null) {
      await uploadImage(image, eventId);
    }
    UserHandler().updateCreatedEvents(eventId);
    updateAttendees(eventId, UserHandler().getUserId());
  }

  //TODO: Metoder för att uppdatera event, som i user_handler + lägga till användare som skapat eventet?

  /* void addAttendee(String uid){
    eventsCollection.where('')
  } */

  Future uploadImage(File file, String eventId) async {
    //Hämta eventId här, inte uid

    final Reference storageRef =
        FirebaseStorage.instance.ref().child('eventPictures/$eventId');
    final TaskSnapshot snapshot = await storageRef.putFile(file);
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    //Lägg in bild i event med hjälp av eventid
    await eventsCollection.doc(eventId).update({'eventImage': downloadUrl});
  }

  static Stream<DocumentSnapshot> getEventStream(
      String eventId, FirebaseFirestore firestore) {
    return firestore.collection('events').doc(eventId).snapshots();
  }

  Future updateAttendees(String eventId, String uid) async {
    await eventsCollection.doc(eventId).update({
      'attendees': FieldValue.arrayUnion([uid]),
    });
  }
}
