import 'package:flutter/material.dart';
import 'register.dart';
import 'login.dart';


void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget{
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(
        title: const Text('FightBuddy'),
        centerTitle: true
      ),
    body: Center(
      child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
      children: [
          ElevatedButton(
            child: const Text('Register'),
            onPressed: () {
              //gå till register
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterPage()),
            );
            },
          ),
              ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  //gå till login
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
                  
                },
              ),

            

    ],)),
    );
  }
} 

 


