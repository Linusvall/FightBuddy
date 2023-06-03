import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String lat = '';
  String lng = '';
  String location = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autocomplete'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            placesAutoCompleteTextField(),
          ],
        ),
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: controller,
          googleAPIKey: 'AIzaSyBwvbdFgwl502-cIPhBQfa7Hpujp4jK6Co',
          inputDecoration:
              const InputDecoration(hintText: "Search your location"),
          debounceTime: 800,
          countries: const ["swe"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            lat = prediction.lat.toString();
            lng = prediction.lng.toString();
            ("Lattitude: $lat");
            ("Longitude: $lng");
          },
          itmClick: (Prediction prediction) {
            controller.text = prediction.description as String;
            location = controller.text;
            final int descriptionLength = prediction.description?.length ?? 0;

            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: descriptionLength));
          }),
    );
  }
}
