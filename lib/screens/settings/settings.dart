import 'package:fight_buddy/screens/create_event.dart';
import 'package:fight_buddy/screens/homepage.dart';
import 'package:fight_buddy/screens/login.dart';
import 'package:fight_buddy/screens/settings/changeemail.dart';
import 'package:fight_buddy/screens/settings/changepassword.dart';
import 'package:fight_buddy/screens/settings/changeprofile.dart';
import 'package:fight_buddy/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangeProfilePage()),
                      ))),
          const Divider(),
          ListTile(
              title: const Text("Ändra lösenord"),
              trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
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
                  icon: const Icon(Icons.arrow_forward_ios),
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
                activeColor: const Color.fromRGBO(3, 137, 129, 50),
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
                activeColor: const Color.fromRGBO(3, 137, 129, 50),
                value: weightValue,
                onChanged: (bool newValue) {
                  setState(() {
                    weightValue = newValue;
                  });
                }),
          ),
          const SizedBox(
            height: 100,
          ),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: 'Logga ut',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const StartPage()),
                          (Route<dynamic> route) => false);
                    },
                  style: const TextStyle(
                      fontSize: 17,
                      decoration: TextDecoration.underline,
                      color: Color.fromRGBO(3, 137, 129, 50)),
                )
              ]))
        ]));
  }
}
