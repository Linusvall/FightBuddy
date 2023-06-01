import 'package:fight_buddy/handlers/user_handler.dart';
import 'package:fight_buddy/screens/registration/martialarts.dart';
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
  UserHandler database = UserHandler();

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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(70),
                    child: Text(
                      "Ange vilken klubb är du medlem i ",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                        "Ange vilken eller vilka klubbar du är medlem i du kan max välja 2 stycken"),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Expanded(
                        child: placesAutoCompleteTextField(),

                        /*TextField(
                          controller: clubController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Sök...',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 16),
                        ), */
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MartialArtsPage(
                              sourceScreen: 'registration',
                            )));
              },
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
                        database.updateMemberOfClub(
                            clubController.text as List<String>);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MartialArtsPage(
                                      sourceScreen: 'registration',
                                    )));
                      },
                      child: const Text('Gå vidare',
                          style: TextStyle(fontSize: 20)))),
            ),
          ],
        ),
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: clubController,
          googleAPIKey: 'AIzaSyBwvbdFgwl502-cIPhBQfa7Hpujp4jK6Co',
          inputDecoration: const InputDecoration(
              hintText: "Sök klubb",
              suffixIcon: Icon(Icons.house, color: Colors.blue)),
          debounceTime: 800,
          countries: const ["swe"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            //  lat = prediction.lat.toString();
            //  lng = prediction.lng.toString();
          },
          itmClick: (Prediction prediction) {
            clubController.text = prediction.description as String;

            final int descriptionLength = prediction.description?.length ?? 0;

            clubController.selection = TextSelection.fromPosition(
                TextPosition(offset: descriptionLength));
          }),
    );
  }
}
