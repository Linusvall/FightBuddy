import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';

class EventHandler {
  final eventsCollection = FirebaseFirestore.instance.collection('events');

  createEventDocument(Map<String, dynamic> eventData) {
    final newDocRef = eventsCollection.doc();
    eventData['eventId'] = newDocRef.id;
    if (eventData['eventImage'] != null) {
      File image = eventData['eventImage'];
      uploadImage(image, newDocRef.id);
    }
    eventData['eventImage'] = '';
    newDocRef.set(eventData);
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
}
