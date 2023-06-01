import 'package:fight_buddy/handlers/user_handler.dart';
import 'package:fight_buddy/screens/mainpage.dart';
import 'package:flutter/material.dart';

class PrefLevelPage extends StatefulWidget {
  final String sourceScreen;
  const PrefLevelPage({Key? key, required this.sourceScreen}) : super(key: key);

  @override
  PrefLevelPageState createState() => PrefLevelPageState();
}

class PrefLevelPageState extends State<PrefLevelPage> {
  UserHandler database = UserHandler();
  bool _value1 = false;
  bool _value2 = false;
  String prefLevel = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(3, 137, 129, 50), //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white10,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "Vem vill du träna med?",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                      "Checka dom boxarna som stämmer in på dig, detta hjälper oss att hitta fightbuddys till dig 😉"),
                ),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Checkbox(
                      value: _value1,
                      onChanged: (bool? value) {
                        setState(() {
                          _value1 = value!;
                          prefLevel = 'same';
                        });
                      },
                    ),
                    const Text("Samma nivå som mig"),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Checkbox(
                      value: _value2,
                      onChanged: (bool? value) {
                        setState(() {
                          _value2 = value!;
                          prefLevel = 'none';
                        });
                      },
                    ),
                    const Text("Spelar ingen roll"),
                  ],
                ),
              ],
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
                      UserHandler().updatePrefLevel(prefLevel);
                      UserHandler().updateMatches();

                      if (widget.sourceScreen == "updateProfile") {
                        Navigator.pop(context);
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const MainPage()),
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: const Text('Gå vidare',
                        style: TextStyle(fontSize: 20)))),
          ),
        ],
      ),
    );
  }
}
