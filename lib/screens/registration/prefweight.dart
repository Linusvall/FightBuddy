import 'package:fight_buddy/handlers/user_handler.dart';
import 'package:fight_buddy/screens/registration/preflevel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PrefWeightPage(),
    );
  }
}

class PrefWeightPage extends StatefulWidget {
  const PrefWeightPage({Key? key}) : super(key: key);

  @override
  PrefWeightPageState createState() => PrefWeightPageState();
}

class PrefWeightPageState extends State<PrefWeightPage> {
  UserHandler database = UserHandler();
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;
  int weight = 0;

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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrefLevelPage()));
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
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "Vem vill du träna med?",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                      "Checka dom boxarna som stämmer in på dig, detta hjälper oss att hitta fightbuddys till dig😉"),
                ),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Checkbox(
                      value: _value1,
                      onChanged: (bool? value) {
                        setState(() {
                          _value1 = value!;
                          weight = 0;
                        });
                      },
                    ),
                    const Text("Samma viktklass som mig"),
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
                          weight = 5;
                        });
                      },
                    ),
                    const Text("+/- 5 kg mer än mig"),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Checkbox(
                      value: _value3,
                      onChanged: (bool? value) {
                        setState(() {
                          _value3 = value!;
                          weight = 10;
                        });
                      },
                    ),
                    const Text("+/- 10 kg mer än mig"),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Checkbox(
                      value: _value4,
                      onChanged: (bool? value) {
                        setState(() {
                          _value4 = value!;
                          weight = 1000;
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
                      database.updatePrefWeight(weight);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrefLevelPage()));
                    },
                    child: const Text('Gå vidare',
                        style: TextStyle(fontSize: 20)))),
          ),
        ],
      ),
    );
  }
}
