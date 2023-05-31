import 'package:fight_buddy/handlers/user_handler.dart';
import 'club.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TrainingPage(),
    );
  }
}

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});
  @override
  TrainingPageState createState() => TrainingPageState();
}

class TrainingPageState extends State<TrainingPage> {
  final _placeInput = TextEditingController();
  UserHandler database = UserHandler();
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
                    "Var vill du träna? ",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: placesAutoCompleteTextField(),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(100.0),
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
                      database.updatePlace(_placeInput.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MembershipPage()));
                    },
                    child: const Text('Gå vidare',
                        style: TextStyle(fontSize: 20)))),
          ),
        ],
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: _placeInput,
          googleAPIKey: 'AIzaSyBwvbdFgwl502-cIPhBQfa7Hpujp4jK6Co',
          inputDecoration: const InputDecoration(
              hintText: "Sök plats",
              suffixIcon: Icon(Icons.place, color: Colors.blue)),
          debounceTime: 800,
          countries: const ["swe"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            //  lat = prediction.lat.toString();
            //  lng = prediction.lng.toString();
          },
          itmClick: (Prediction prediction) {
            _placeInput.text = prediction.description as String;

            final int descriptionLength = prediction.description?.length ?? 0;

            _placeInput.selection = TextSelection.fromPosition(
                TextPosition(offset: descriptionLength));
          }),
    );
  }
}
