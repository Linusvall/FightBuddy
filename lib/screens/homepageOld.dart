import 'package:fight_buddy/screens/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Text(
            "Startsidan",
            style: TextStyle(fontSize: 30),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(60),
            ),
            icon: const Icon(Icons.exit_to_app_sharp, size: 32),
            label: const Text(
              "Logga ut",
              style: TextStyle(fontSize: 24),
            ),
            onPressed: signOut,
          ),
        ],
      ),
    ));
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainPage()));
  }
}
