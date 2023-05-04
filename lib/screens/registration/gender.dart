import 'package:fight_buddy/screens/registration/birth.dart';
import 'package:flutter/material.dart';
import '../../handlers/database.dart';
import 'package:fight_buddy/globals.dart' as globals;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GenderPage(),
    );
  }
}

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});
  @override
  GenderPageState createState() => GenderPageState();
}

class GenderPageState extends State<GenderPage> {
  DatabaseService database = DatabaseService();
  bool _womanHasBeenPressed = false;
  bool _nothingHasBeenPressed = false;
  bool _manHasBeenPressed = false;
  var gender = '';

  pressedbutton(String button) {
    _nothingHasBeenPressed = false;
    _manHasBeenPressed = false;
    _womanHasBeenPressed = false;

    if (button == 'man') {
      _manHasBeenPressed = true;
      gender = 'man';
    } else if (button == 'woman') {
      _womanHasBeenPressed = true;
      gender = 'woman';
    } else {
      _nothingHasBeenPressed = true;
      gender = 'nothing';
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BirthPage()));
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
        body: Center(
            child: Column(children: <Widget>[
          const Padding(
              padding: EdgeInsets.all(100),
              child: Text(
                "Jag är en ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
          Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    primary: _womanHasBeenPressed
                        ? Color.fromRGBO(0, 181, 169, 100)
                        : Colors.white,
                  ),
                  onPressed: () => setState(() {
                        pressedbutton("woman");
                      }),
                  child: Row(
                    children: const [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Kvinna                                                      ",
                              style: TextStyle(
                                  color: Color.fromRGBO(112, 112, 112, 100)))),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.check))
                    ],
                  ))),
          Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    primary: _manHasBeenPressed
                        ? Color.fromRGBO(0, 181, 169, 100)
                        : Colors.white,
                  ),
                  onPressed: () => setState(() {
                        pressedbutton("man");
                      }),
                  child: Row(
                    children: const [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Man                                                          ",
                              style: TextStyle(
                                  color: Color.fromRGBO(112, 112, 112, 100)))),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.check))
                    ],
                  ))),
          Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    primary: _nothingHasBeenPressed
                        ? const Color.fromRGBO(0, 181, 169, 100)
                        : Colors.white,
                  ),
                  onPressed: () => setState(() {
                        pressedbutton("nothing");
                      }),
                  child: Row(
                    children: const [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Vill inte ange                                          ",
                              style: TextStyle(
                                  color: Color.fromRGBO(112, 112, 112, 100)))),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.check))
                    ],
                  ))),
          const SizedBox(
            height: 170,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: const Color.fromRGBO(3, 137, 129, 50),
                fixedSize: const Size(250, 50),
              ),
              onPressed: () {
                database.updateUserGender(gender);
                globals.gender = gender;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BirthPage()));
              },
              child: const Text('Gå vidare', style: TextStyle(fontSize: 20)))
        ])));
  }
}
