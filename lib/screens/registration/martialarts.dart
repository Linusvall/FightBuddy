import 'package:fight_buddy/handlers/user_handler.dart';
import 'package:fight_buddy/screens/registration/newmartialarts.dart';
import 'package:flutter/material.dart';

class MartialArtsPage extends StatefulWidget {
  final String sourceScreen;
  const MartialArtsPage({super.key, required this.sourceScreen});
  @override
  MartialArtsPageState createState() => MartialArtsPageState();
}

class MartialArtsPageState extends State<MartialArtsPage> {
  List<String> options = [
    "Boxning",
    "MMA",
    "Taekwondo",
    "Judo",
    "Karate",
    "Kickboxning",
    "Kendo",
    "Sumo",
    "Wushu",
  ];

  List<String> selectedOptions = [];

  void _navigateToLevelAndExperience() async {
    for (String martialArt in selectedOptions) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LevelPage(
            martialArt: martialArt,
          ),
        ),
      );

      if (widget.sourceScreen == 'updateProfile') {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NewMartialArtsPage(
              sourceScreen: 'registration',
            ),
          ),
        );
      }
    }
  }

  void _onOptionSelected(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
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
                  padding: EdgeInsets.all(70),
                  child: Text(
                    "Dina kampssportsintressen",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Välj kampsporter som du aktivt utövar. Vi kommer matcha ihop dig med personer med samma intressen😊 ",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Välj max 3 stycken"),
                ),
                Wrap(
                  children: options.map((option) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: Text(option),
                        selected: selectedOptions.contains(option),
                        onSelected: (_) => _onOptionSelected(option),
                      ),
                    );
                  }).toList(),
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
                      UserHandler().updateMartialArts(selectedOptions);
                      UserHandler().putUserInMartialArtsMap(selectedOptions);
                      _navigateToLevelAndExperience();
                    },
                    child: const Text('Gå vidare',
                        style: TextStyle(fontSize: 20)))),
          ),
        ],
      ),
    );
  }
}

class LevelPage extends StatefulWidget {
  final String martialArt;
  const LevelPage({Key? key, required this.martialArt}) : super(key: key);

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

  var level = '';

  @override
  Widget build(BuildContext context) {
    String martialArt = widget.martialArt;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(3, 137, 129, 50), //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white10,
        //Någon titeltext?
        title: Text(martialArt),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    "Berätta mer om ditt intresse för $martialArt",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
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
                          level = "Tävlare";
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
                          level = "Erfaren";
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
                          level = "Motionär";
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
                          level = "Nybörjare";
                        });
                      },
                    ),
                    const Text("Jag är nybörjare"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Hur länge har du utövat $martialArt?"),
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
                      UserHandler().updateLevel(level);
                      UserHandler().yearsOfPractice(yearController.text);
                      Navigator.pop(context);
                    },
                    child: const Text('Gå vidare',
                        style: TextStyle(fontSize: 20)))),
          ),
        ],
      ),
    );
  }
}
