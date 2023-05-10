import 'package:fight_buddy/handlers/user_handler.dart';
import 'package:fight_buddy/screens/registration/newmartialarts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LevelPage(),
    );
  }
}

class LevelPage extends StatefulWidget {
  const LevelPage({Key? key}) : super(key: key);

  @override
  LevelPageState createState() => LevelPageState();
}

class LevelPageState extends State<LevelPage> {
  UserHandler database = UserHandler();
  var yearController = TextEditingController();
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;

  List<String> levelManager() {
    List<String> level = [];
    if (_value1 == true) {
      level.add("competitor");
    }
    if (_value2 == true) {
      level.add("experienced");
    }
    if (_value3 == true) {
      level.add("exerciser");
    }
    if (_value4 == true) {
      level.add("beginner");
    }
    return level;
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
        //Någon titeltext?
        title: const Text(""),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "Vilken nivå tränar du på",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Checka dom boxarna som stämmer in på dig"),
                ),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Checkbox(
                      value: _value1,
                      onChanged: (bool? value) {
                        setState(() {
                          _value1 = value!;
                        });
                      },
                    ),
                    const Text("Jag tävlar"),
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
                        });
                      },
                    ),
                    const Text("Jag är erfaren"),
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
                        });
                      },
                    ),
                    const Text("Jag är motionär"),
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
                        });
                      },
                    ),
                    const Text("Jag är nybörjare"),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Hur länge har du utövat kampsport"),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: yearController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ange tid i år',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
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
                      database.updateLevel(levelManager());
                      database.yearsOfPractice(yearController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NewMartialArtsPage()));
                    },
                    child: const Text('Gå vidare',
                        style: TextStyle(fontSize: 20)))),
          ),
        ],
      ),
    );
  }
}
