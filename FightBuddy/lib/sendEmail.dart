import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: emailPage(),
    );
  }
}

class emailPage extends StatelessWidget{
 @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kön"), centerTitle: true,),
      body: Center(
        child: ElevatedButton(
          onPressed :() => print("Hej"),
          child: Text("Test"),
        )
      )
    );
  }
  }