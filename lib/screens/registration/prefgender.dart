import 'package:fight_buddy/handlers/user_handler.dart';
import 'package:fight_buddy/screens/registration/prefweight.dart';
import 'package:flutter/material.dart';

class PrefGenderPage extends StatefulWidget {
  final String sourceScreen;
  const PrefGenderPage({Key? key, required this.sourceScreen})
      : super(key: key);

  @override
  PrefGenderPageState createState() => PrefGenderPageState();
}

class PrefGenderPageState extends State<PrefGenderPage> {
  UserHandler database = UserHandler();
  var genderController = TextEditingController();
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;

  List<String> prefGender = [];

  updateGenderList() {
    if (_value4 == true) {
      prefGender.add("none");
      return;
    }
    if (_value1 == true) {
      prefGender.add("Kvinna");
    }
    if (_value2 == true) {
      prefGender.add("Man");
    }
    if (_value3 == true) {
      prefGender.add("Annat");
    }
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
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  //Hoppa över och gå vidare

                  if (widget.sourceScreen == "updateProfile") {
                    Navigator.pop(context);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrefWeightPage(
                                  sourceScreen: 'registration',
                                )));
                  }
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
                      "Checka dom boxarna som stämmer in på dig, detta hjälper oss att hitta fightbuddys till dig😉ps. du kan checka flera boxar"),
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
                    const Text("Kvinna"),
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
                    const Text("Man"),
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
                    const Text("Annat"),
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
                      updateGenderList();
                      database.updatePrefGender(prefGender);

                      if (widget.sourceScreen == "updateProfile") {
                        Navigator.pop(context);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PrefWeightPage(
                                      sourceScreen: 'registration',
                                    )));
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
