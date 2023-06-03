import 'package:fight_buddy/model/event.dart';
import 'package:fight_buddy/screens/events/eventprofilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Google Maps events test',
      home: EventMapScreen(),
    );
  }
}

class EventMapScreen extends StatefulWidget {
  const EventMapScreen({super.key});

  @override
  EventMapScreenState createState() => EventMapScreenState();
}

class EventMapScreenState extends State<EventMapScreen> {
  late GoogleMapController mapController;
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  void fetchEvents() async {
    // Fetch all events from Firestore
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('events').get();

    List<Event> fetchedEvents = [];
    snapshot.docs.forEach((doc) {
      Event event = Event.fromMap(doc.data());
      fetchedEvents.add(event);
    });

    setState(() {
      events = fetchedEvents;
    });
  }

  Set<Marker> createMarkers() {
    return events.map((event) {
      LatLng eventLocation = LatLng(
        event.place['lat'] as double,
        event.place['lng'] as double,
      );
      return Marker(
        markerId: MarkerId(event.eventId),
        position: eventLocation,
        infoWindow: InfoWindow(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventProfilePage(event: event),
              ),
            );
          },
          title: event.eventName,
          snippet: 'Date: ${event.date}\n'
              'Time: ${event.timeFrom} - ${event.timeTo}\n'
              'Category: ${event.category}\n'
              'Additional Information:\n'
              'Description: ${event.about}',
        ),
      );
    }).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(3, 137, 129, 50), //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.white10,
          title: const Text(
            "Event nära mig",
            style: TextStyle(color: Colors.black, fontFamily: 'auto'),
          ),
          centerTitle: true,
          actions: const <Widget>[
            //Inget här tror jag kan tas bort
          ]),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(59.334591, 18.063240),
                zoom: 13,
              ),
              markers: createMarkers(),
            ),
          ),
        ],
      ),
    );
  }
}
