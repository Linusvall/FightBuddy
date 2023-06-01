import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fight_buddy/handlers/event.dart';
import 'package:fight_buddy/handlers/user_handler.dart';
import '../../assets/theme/colors.dart';
import 'eventprofilepage.dart';
import 'package:fight_buddy/screens/events/create_event.dart';

class MyEventsPage extends StatefulWidget {
  const MyEventsPage({Key? key}) : super(key: key);
  @override
  _MyEventsPageState createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage>
    with SingleTickerProviderStateMixin {
  String uid = UserHandler().getUserId();
  List<Event> _createdEvents = [];
  List<Event> _attendingEvents = [];
  bool _isLoading = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _loadCreatedEvents();
    _loadAttendingEvents();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _loadCreatedEvents() {
    setState(() {
      _isLoading = true;
    });

    FirebaseFirestore.instance
        .collection('events')
        .where('organizer', isEqualTo: uid)
        .limit(10)
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        _createdEvents = _convertSnapshotToList(snapshot);
        _isLoading = false;
      });
    });
  }

  //Inneffektiv temporär lösning, istället för att matcha direkt med dokument med rätt eventId söks varje events "attendees" igenom
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: fightbuddyLightgreen, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          "Dina event",
          style: TextStyle(color: Colors.black, fontFamily: 'auto'),
        ),
        centerTitle: true,
        actions: const <Widget>[
          //Inget här tror jag kan tas bort
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: fightbuddyLightgreen,
          tabs: [
            Tab(
              child: Text(
                'Alla',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Tab(
              child: Text(
                'Skapade',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
          labelColor: fightbuddyLightgreen,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Widget for 'Alla' tab

          // Widget for 'Skapade' tab
          Expanded(
            child: ListView.builder(
              itemCount: _attendingEvents.length + 1,
              itemBuilder: (context, index) {
                if (index < _attendingEvents.length) {
                  // Visa eventet
                  final event = _attendingEvents[index];
                  return _eventCard(event, context);
                } else if (_isLoading) {
                  // Visa cirkel om det laddar
                  return Center(child: CircularProgressIndicator());
                } else {
                  // Nått slutet av listan
                  return Container();
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _createdEvents.length + 1,
              itemBuilder: (context, index) {
                if (index < _createdEvents.length) {
                  // Visa eventet
                  final event = _createdEvents[index];
                  return _eventCard(event, context);
                } else if (_isLoading) {
                  // Visa cirkel om det laddar
                  return Center(child: CircularProgressIndicator());
                } else {
                  // Nått slutet av listan
                  return Container();
                }
              },
            ),
          ),
        ],
      ), /* Column(
        children: [
          
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        'Värd:')
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _createdEvents.length + 1,
              itemBuilder: (context, index) {
                if (index < _createdEvents.length) {
                  // Visa eventet
                  final event = _createdEvents[index];
                  return _eventCard(event, context);
                } else if (_isLoading) {
                  // Visa cirkel om det laddar
                  return Center(child: CircularProgressIndicator());
                } else {
                  // Nått slutet av listan
                  return Container();
                }
              },
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        'Övriga:')
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _attendingEvents.length + 1,
              itemBuilder: (context, index) {
                if (index < _attendingEvents.length) {
                  // Visa eventet
                  final event = _attendingEvents[index];
                  return _eventCard(event, context);
                } else if (_isLoading) {
                  // Visa cirkel om det laddar
                  return Center(child: CircularProgressIndicator());
                } else {
                  // Nått slutet av listan
                  return Container();
                }
              },
            ),
          ),
        ],
      ),*/
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

