import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fight_buddy/handlers/user.dart' as fightbuddy;
import '../assets/theme/colors.dart';
import '../handlers/event.dart';
import 'package:fight_buddy/handlers/user_handler.dart';

class EventProfilePage extends StatefulWidget {
  final Event event;
  const EventProfilePage({Key? key, required this.event}) : super(key: key);

  @override
  EventProfilePageState createState() => EventProfilePageState();
}

class EventProfilePageState extends State<EventProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Event event = widget.event;
    return Scaffold(
        backgroundColor: fightbuddyLightgreen,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 4),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(event.eventPicture),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100))),
            child: Column(
              children: [
                Container(
                  child: _eventCard(event, context),
                ),
                const SizedBox(
                  height: 5,
                ),
                _listTile(
                    const Icon(Icons.calendar_month,
                        color: fightbuddyLightgreen),
                    event.date,
                    "${event.timeFrom} - ${event.timeTo}",
                    context),
                _listTile(const Icon(Icons.place, color: fightbuddyLightgreen),
                    event.place, "", context),
                _listTile(
                    const Icon(Icons.signal_cellular_alt,
                        color: fightbuddyLightgreen),
                    event.level,
                    "",
                    context),
                _userListTile(event.organizer, context),
                const Text("Om eventet",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                    width: 300,
                    child: Text(
                      event.about,
                      style: const TextStyle(
                          fontSize: 17, color: Color.fromARGB(255, 94, 90, 90)),
                    )),
                const SizedBox(height: 50),
                SizedBox(
                    height: 60,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 122, 122, 122))),
                        onPressed: () {
                          print("pressed");
                        },
                        child:
                            const Text("DU KAN INTE ANMÄLA DIG TILL EVENTET"))),
              ],
            ),
          ),
        ));
  }
}

Widget _userListTile(String uid, BuildContext context) {
  return FutureBuilder<fightbuddy.User>(
    future: UserHandler().getUser(uid),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return const Text("An error occurred while loading user data");
      } else {
        fightbuddy.User user = snapshot.data!;
        return ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: fightbuddySuperLightGreen,
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(user.profilePicture),
                fit: BoxFit.cover,
              ),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.profilePicture),
            ),
          ),
          title: Text("${user.firstName} ${user.lastName}"),
          subtitle: const Text("Arrangör"),
        );
      }
    },
  );
}

Widget _listTile(
    Icon icon, String title, String subtitle, BuildContext context) {
  return ListTile(
    leading: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: fightbuddySuperLightGreen,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: icon,
    ),
    title: Text(title),
    subtitle: Text(subtitle),
  );
}

Widget _eventCard(Event event, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            tileColor: Colors.white,
            title: Text(
              event.eventName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ));
}
