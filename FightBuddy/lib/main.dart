import 'package:flutter/material.dart';
import 'register.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Color.fromARGB(255, 46, 201, 141),

        // Define the default font family.
        //fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FightBuddy'),
        centerTitle: true,
        // backgroundColor:
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              //   backgroundColor:
              fixedSize: const Size(250, 20),
            ),
            child: const Text('Login'),
            onPressed: () {
              //gå till login
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(250, 20),
            ),
            child: const Text('Sign up'),
            onPressed: () {
              //gå till register
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );
            },
          ),
        ],
      )),
    );
  }
}
