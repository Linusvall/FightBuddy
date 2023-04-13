import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HeightAndWeightPage(),
    );
  }
}

class HeightAndWeightPage extends StatefulWidget{
 @override
  _HeightAndWeightPageState createState() => _HeightAndWeightPageState();
  }


  class _HeightAndWeightPageState extends State<HeightAndWeightPage>{

    final _weightController = TextEditingController();
    final _heightController = TextEditingController();
    bool _weightButton = false;
    bool _heightButton = false;

    @override 
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(title: Text("Vikt & Längd"), centerTitle: true ),

        body: Center(
        
        child: Column(
          children: <Widget>[
            Padding( padding: const EdgeInsets.all(50),
              child: const Text("Vikt & Längd",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),  
              )
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                
                  controller: _weightController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                    border: OutlineInputBorder(),
                    labelText: 'Ange vikt i kilogram',
                  )
                  ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child : Text("Eller"
                
              )
              ),
              Padding(padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                
                style: ElevatedButton.styleFrom(fixedSize: const Size(300,60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  primary: _weightButton ? Color.fromRGBO(0,181,169,100) : Colors.white,
                  
                ),
                onPressed: () => setState((){
                  _weightButton = !_weightButton;
                }
                ), child: Text("Vill inte ange",
                style: TextStyle(color: Colors.black)
                )
              )
              ),

              Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                
                  controller: _heightController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                    border: OutlineInputBorder(),
                    labelText: 'Ange längd i centimeter',
                  )
                  ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child : Text("Eller"
                
              )
              ),
              Padding(padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                
                style: ElevatedButton.styleFrom(fixedSize: const Size(300,60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  primary: _heightButton ? Color.fromRGBO(0,181,169,100) : Colors.white,
                  
                ),
                onPressed: () => setState((){
                  _heightButton = !_heightButton;
                }
                ), child: Text("Vill inte ange",
                style: TextStyle(color: Colors.black)
                )
              )
              ),

              Padding(padding: const EdgeInsets.all(70),
                child: ElevatedButton(
                  onPressed: () => print("pressed"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    primary: Color.fromRGBO(0,181,169,100),
                    minimumSize: Size(250,70)
                  ),
                  
                  child: Text("Gå vidare",
                  style: TextStyle(color: Colors.white,
                  fontSize: 20,

                  )
                  ),

                )
                )


        ])
        )
      );
    }
  }