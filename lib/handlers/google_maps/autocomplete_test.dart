import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String lat = '';
  String lng = '';
  String location = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autocomplete'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            placesAutoCompleteTextField(),
          ],
        ),
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: controller,
          googleAPIKey: 'AIzaSyBwvbdFgwl502-cIPhBQfa7Hpujp4jK6Co',
          inputDecoration: InputDecoration(hintText: "Search your location"),
          debounceTime: 800,
          countries: ["swe"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            lat = prediction.lat.toString();
            lng = prediction.lng.toString();
            print("Lattitude: " + lat);
            print("Longitude: " + lng);
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
