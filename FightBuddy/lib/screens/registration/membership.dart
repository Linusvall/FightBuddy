import 'package:fight_buddy/handlers/database.dart';
import 'package:fight_buddy/screens/registration/martialarts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MembershipPage(),
    );
  }
}

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});
  @override
  MembershipPageState createState() => MembershipPageState();
}

class MembershipPageState extends State<MembershipPage> {
  DatabaseService database = DatabaseService();

  var clubController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(3, 137, 129, 50), //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.white10,
          //Någon titeltext?
          title: const Text(""),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  //Hoppa över och gå vidare
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    backgroundColor: Colors.white,
                    minimumSize: const Size(160, 10)),
                child: const Text(
                  "Hoppa över",
                  style: TextStyle(
                    color: Color.fromRGBO(3, 137, 129, 50),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ]),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(70),
                  child: Text(
                    "Ange vilken klubb är du medlem i ",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                      "Ange vilken eller vilka klubbar du är medlem i du kan max välja 3 stycken"),
                ),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: clubController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Sök...',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          isDense: true,
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom:
                240.0, // adjust this value to change the position of the button
            left:
                50.0, // adjust this value to change the position of the button
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  backgroundColor: const Color.fromRGBO(3, 137, 129, 50),
                  minimumSize: const Size(300, 50)),
              child: const Text(
                "Jag är inte medlem i någon klubb",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: const Color.fromRGBO(3, 137, 129, 50),
                      fixedSize: const Size(250, 50),
                    ),
                    onPressed: () {
                      database.updatePlace(clubController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MartialArtsPage()));
                    },
                    child: const Text('Gå vidare',
                        style: TextStyle(fontSize: 20)))),
          ),
        ],
      ),
    );
  }
}
