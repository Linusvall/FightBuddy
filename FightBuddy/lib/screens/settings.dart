import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget{
 @override
  _SettingsPageState createState() => _SettingsPageState();
  }

  class _SettingsPageState extends State<SettingsPage>{
    
    bool value = true;


    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          centerTitle: true
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Notifications"),
              trailing: Switch(
                value: value,
                onChanged:(bool newValue){
                  setState((){
                    value = newValue;
                });
                }
              ),
              ),
              Divider(),
              ListTile(
                title: Text("Change password"),
                trailing: ElevatedButton(onPressed: () => print("Pressed"),
                child: Icon(Icons.arrow_forward_ios_sharp),
                ),
              )
          ]
        )
      );
    }
  }