import 'package:fight_buddy/screens/events/all_events.dart';
import 'package:fight_buddy/screens/events/my_events.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fight_buddy/handlers/event.dart';
import '../../assets/theme/colors.dart';
import 'eventprofilepage.dart';
import 'package:fight_buddy/screens/events/create_event.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fight_buddy/handlers/google_maps/google_maps_events.dart';
import 'package:fight_buddy/handlers/user_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:google_places_flutter/google_places_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Events Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventMainPage(),
    );
  }
}

class EventMainPage extends StatefulWidget {
  const EventMainPage({Key? key}) : super(key: key);
  @override
  _EventMainPageState createState() => _EventMainPageState();
}

class _EventMainPageState extends State<EventMainPage> {
  List<Event> _attendingEvents = [];
  bool _isLoading = false;
  String uid = UserHandler().getUserId();
  late GoogleMapController mapController;
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    _loadAttendingEvents();
    fetchEvents();
  }

  void _loadAttendingEvents() {
    setState(() {
      _isLoading = true;
    });

    FirebaseFirestore.instance
        .collection('events')
        .where('attendees', arrayContains: uid)
        .limit(10)
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        _attendingEvents = _convertSnapshotToList(snapshot);
        _isLoading = false;
      });
    });
  }

  List<Event> _convertSnapshotToList(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Event.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
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
      body: Column(
        children: [
          Container(
            color: Color.fromRGBO(0, 182, 170, 1),
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Skapa event',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EventMapScreen()),
                                );
                              },
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateEventPage()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Kommande event',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Se alla',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AllEventsPage()),
                            );
                          },
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      WidgetSpan(
                        child: Icon(Icons.arrow_right_outlined, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                'Mina event',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Se alla',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyEventsPage()),
                            );
                          },
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      WidgetSpan(
                        child: Icon(Icons.arrow_right_outlined, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 10), // Padding at the start
                ..._attendingEvents.take(3).map((event) {
                  return SizedBox(
                    width: 300, // Adjust the width as needed
                    child: _eventCard(event, context),
                  );
                }),
                SizedBox(width: 10), // Padding at the end
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Nära dig',
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Se alla',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventMapScreen()),
                            );
                          },
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      WidgetSpan(
                        child: Icon(Icons.arrow_right_outlined, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: GestureDetector(
            onTap: () {
              // Navigate to another page when the map is tapped
              // Replace `AnotherPage()` with the desired page/widget you want to navigate to
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventMapScreen()),
              );
            },
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(59.334591, 18.063240),
                zoom: 13,
              ),
              markers: createMarkers(),
            ),
          )),
        ],
      ),
    );
  }
}

Widget _eventCard(Event event, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 75,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(event.eventImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          tileColor: Colors.white,
          title: Row(
            children: [
              Expanded(
                // Wrap the text widget with Expanded
                child: Text(
                  event.eventName,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.message_rounded),
                  onPressed: () {
                    //Implementera att den gå till chatten
                    print("pressed icon message");
                  },
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${event.date}   ${event.timeFrom}",
                style: const TextStyle(
                  color: fightbuddyLightgreen,
                  fontSize: 15,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.signal_cellular_alt),
                  Text(
                    event.level,
                    style: const TextStyle(color: fightbuddyDarkgreen),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.boy_rounded),
                  Expanded(
                    child: Text(
                      "${event.attendees.length}/${event.capacity} medlemmar kommer",
                      style: const TextStyle(color: fightbuddyLightgreen),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.place),
                  Expanded(
                    // Wrap the text widget with Expanded
                    child: Text(
                      event.place['location'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventProfilePage(event: event),
              ),
            );
          },
        ),
      ],
    ),
  );
}
