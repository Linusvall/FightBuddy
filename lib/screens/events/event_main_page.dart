import 'package:fight_buddy/screens/events/my_events.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fight_buddy/handlers/event.dart';
import '../../assets/theme/colors.dart';
import 'eventprofilepage.dart';
import 'package:fight_buddy/screens/events/create_event.dart';
import 'package:fight_buddy/screens/events/all_events.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';

class EventMainPage extends StatefulWidget {
  const EventMainPage({Key? key}) : super(key: key);
  @override
  _EventMainPageState createState() => _EventMainPageState();
}

class _EventMainPageState extends State<EventMainPage> {
  List<Event> _events = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() {
    setState(() {
      _isLoading = true;
    });

    FirebaseFirestore.instance
        .collection('events')
        .limit(10)
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        _events = _convertSnapshotToList(snapshot);
        _isLoading = false;
      });
    });
  }

  List<Event> _convertSnapshotToList(QuerySnapshot snapshot) {
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Event.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: fightbuddyLightgreen,
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.white),
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
                        text: 'Se alla >',
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Dina event',
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
                        text: 'Se alla >',
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
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}








//Knappen i en ny appbar istället?

/*  appBar: AppBar(backgroundColor: fightbuddyLightgreen, actions: [
        IconButton(
          icon: const Icon(Icons.add_circle_outline, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateEventPage()));
          },
        ),
      ]),*/

