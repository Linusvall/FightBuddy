import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChangeProfilePage(),
    );
  }
}

class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({super.key});

  @override
  ChangeProfilePageState createState() => ChangeProfilePageState();
}

class ChangeProfilePageState extends State<ChangeProfilePage> {
  var items = [
    const DropdownMenuItem(value: "Man", child: Text("Man")),
    const DropdownMenuItem(value: "Kvinna", child: Text("Kvinna")),
    const DropdownMenuItem(value: "Annat", child: Text("Annat"))
  ];

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
          title: const Text("Inställningar"),
        ),
        body: ListView(children: <Widget>[
          const ListTile(
            title: Text("Profil inställningar"),
            textColor: Color.fromRGBO(102, 99, 99, 0.808),
          ),
          const Divider(),
          ListTile(
              title: const Text("Kön"),
              trailing: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(3, 137, 129, 50)),
                  child: const Text(""),
                  onPressed: () => const AlertDialog(
                        title: Text("Kön"),
                        /*
                        content: DropdownButton<String>(
                            value: globals.gender,
                            onChanged: (String? newValue) {
                              setState(() {
                                globals.gender = newValue!;
                              });
                            },
                            items: items),
                            */
                      ))),
          const Divider(),
          ListTile(
              title: const Text("Längd"),
              trailing: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(3, 137, 129, 50)),
                child: const Text(""),
                onPressed: () => print("pressed"),
              )),
          const Divider(),
          ListTile(
              title: const Text("Vikt"),
              trailing: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(3, 137, 129, 50)),
                child: const Text(""),
                onPressed: () => print("pressed"),
              )),
          const Divider(),
          ListTile(
              title: const Text("Kampsporter"),
              trailing: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(3, 137, 129, 50)),
                child: const Text(""),
                onPressed: () => print("pressed"),
              )),
          const Divider(),
          ListTile(
              title: const Text("Nya kampsporter"),
              trailing: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(3, 137, 129, 50)),
                child: const Text(""),
                onPressed: () => print("pressed"),
              )),
        ]));
  }
}
