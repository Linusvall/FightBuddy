import 'package:flutter/material.dart';
import 'globals.dart' as global;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GenderPage(),
    );
  }
}

class GenderPage extends StatefulWidget {
  @override
  _genderPageState createState() => _genderPageState();
}

class _genderPageState extends State<GenderPage> {
  pressed() {
    print(global.hello);
    global.hello = "ändrad";
    print(global.hello);
  }

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
          title: Text("Kön"),
          centerTitle: true,
        ),
        body: Center(
            child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(100),
              child: const Text(
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
                    children: [
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
                    children: [
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
                    children: [
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
          Padding(
              padding: const EdgeInsets.all(70),
              child: ElevatedButton(
                onPressed: () => pressed(),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    primary: Color.fromRGBO(0, 181, 169, 100),
                    minimumSize: Size(250, 70)),
                child: Text("Gå vidare",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              ))
        ])));
  }
}
