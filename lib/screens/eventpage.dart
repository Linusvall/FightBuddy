import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../assets/theme/colors.dart';
import 'package:fight_buddy/handlers/event_handler.dart';
import 'package:fight_buddy/handlers/event.dart';
import 'package:fight_buddy/screens/create_event.dart';

import 'eventprofilepage.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  EventPageState createState() => EventPageState();
}

class EventPageState extends State<EventPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fightbuddyLightgreen,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                const Spacer(),
                IconButton(
                  icon:
                      const Icon(Icons.add_circle_outline, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateEventPage()));
                  },
                ),
              ],
            ),
          ),
          StreamBuilder(
              //Realtime updates of changes to users information
              stream: EventHandler.getEventStream(
                  FirebaseAuth.instance.currentUser!.uid,
                  FirebaseFirestore.instance),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Event event = Event.fromMap(
                      ((snapshot.data) as DocumentSnapshot).data()
                          as Map<String, dynamic>);
                  return Container(
                    child: _eventCard(event, context),
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: fightbuddyLightgreen,
                  );
                }
              }),
        ],
      ),
    );
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
                        image: NetworkImage(event.eventPicture),
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
                          "3/${event.capacity} medlemmar kommer",
                          style: const TextStyle(color: fightbuddyLightgreen),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.place),
                        Text(event.place),
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
                          builder: (context) =>
                              EventProfilePage(event: event)));
                }),
          ],
        ));
  }
}

Future signOut() async {
  await FirebaseAuth.instance.signOut();
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