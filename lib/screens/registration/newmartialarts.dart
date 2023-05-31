import 'package:fight_buddy/handlers/user_handler.dart';
import 'package:fight_buddy/screens/registration/prefgender.dart';
import 'package:flutter/material.dart';

class NewMartialArtsPage extends StatefulWidget {
  final String sourceScreen;
  const NewMartialArtsPage({super.key, required this.sourceScreen});
  @override
  NewMartialArtsPageState createState() => NewMartialArtsPageState();
}

class NewMartialArtsPageState extends State<NewMartialArtsPage> {
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
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(70),
                  child: Text(
                    "Nya kampssportsintressen",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Välj kampsporter som du är nyfiken på att testa!",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Välj max 2 stycken"),
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
                      UserHandler().updateNewMartialArts(selectedOptions);
                      UserHandler().putUserInMartialArtsMap(selectedOptions);
                      if (widget.sourceScreen == 'updateProfile') {
                        Navigator.pop(context);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PrefGenderPage(
                                      sourceScreen: 'Registration',
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
