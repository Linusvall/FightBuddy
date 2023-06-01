import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fight_buddy/handlers/event.dart';
import '../../assets/theme/colors.dart';
import 'eventprofilepage.dart';
import 'package:fight_buddy/screens/events/create_event.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fight_buddy/handlers/google_maps/google_maps_events.dart';

class AllEventsPage extends StatefulWidget {
  const AllEventsPage({Key? key}) : super(key: key);
  @override
  _AllEventsPageState createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
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
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(3, 137, 129, 50), //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.white10,
          title: const Text(
            "Kommande Event",
            style: TextStyle(color: Colors.black, fontFamily: 'auto'),
          ),
          centerTitle: true,
          actions: const <Widget>[
            //Inget här tror jag kan tas bort
          ]),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _events.length + 1,
              itemBuilder: (context, index) {
                if (index < _events.length) {
                  // Visa eventet
                  final event = _events[index];
                  return _eventCard(event, context);
                } else if (_isLoading) {
                  // Visa cirkel om det laddar
                  return const Center(child: CircularProgressIndicator());
                } else {
                  // Nått slutet av listan
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _eventCard(Event event, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  Text("${event.date}   ${event.timeFrom}",
                      style: const TextStyle(
                        color: fightbuddyLightgreen,
                        fontSize: 15,
                      )),
                  Row(
                    children: [
                      const Icon(Icons.signal_cellular_alt),
                      Text(event.level,
                          style: const TextStyle(color: fightbuddyDarkgreen)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.boy_rounded),
                      Text(
                        "${event.attendees.length}/${event.capacity} medlemmar kommer",
                        style: const TextStyle(color: fightbuddyLightgreen),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.place),
                      Expanded(child: Text(event.place['location'])),
                    ],
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventProfilePage(event: event)));
              }),
        ],
      ));
}
