import 'package:fight_buddy/screens/settings/changeemail.dart';
import 'package:fight_buddy/screens/settings/changepassword.dart';
import 'package:fight_buddy/screens/settings/changeprofile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsValue = true;
  bool weightValue = false;

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
            title: Text("Konto inställningar"),
            textColor: Color.fromRGBO(102, 99, 99, 0.808),
          ),
          const Divider(),
          ListTile(
              title: const Text("Redigera profil"),
              trailing: IconButton(
                  iconSize: 20,
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangeProfilePage()),
                      ))),
          const Divider(),
          ListTile(
              title: const Text("Ändra lösenord"),
              trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  iconSize: 20,
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangePasswordPage()),
                      ))),
          const Divider(),
          ListTile(
              title: const Text("Ändra din email"),
              trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  iconSize: 20,
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangeEmailPage()),
                      ))),
          const Divider(),
          ListTile(
            title: const Text("Aktivera notiser"),
            trailing: Switch(
                activeColor: Color.fromRGBO(3, 137, 129, 50),
                value: notificationsValue,
                onChanged: (bool newValue) {
                  setState(() {
                    notificationsValue = newValue;
                  });
                }),
          ),
          const Divider(),
          ListTile(
            title: const Text("Visa min vikt"),
            trailing: Switch(
                activeColor: Color.fromRGBO(3, 137, 129, 50),
                value: weightValue,
                onChanged: (bool newValue) {
                  setState(() {
                    weightValue = newValue;
                  });
                }),
          ),
        ]));
  }
}
