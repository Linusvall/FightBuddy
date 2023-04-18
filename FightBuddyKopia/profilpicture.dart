import 'package:flutter/material.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GenderPage(),
    );
  }
}

class GenderPage extends StatefulWidget{
  const GenderPage({super.key});

 @override
  GenderPageState createState() => GenderPageState();
  }

  class GenderPageState extends State<GenderPage>{
    bool _womanHasBeenPressed = false;
    bool _nothingHasBeenPressed = false;
    bool _manHasBeenPressed = false;
    var gender = '';

    pressedbutton(String button){
    _nothingHasBeenPressed = false;
    _manHasBeenPressed = false;
    _womanHasBeenPressed = false;


    if(button == 'man'){
      _manHasBeenPressed = true;
      gender = 'man';
    }
    else if(button == 'woman'){
      _womanHasBeenPressed = true;
      gender = 'woman';
    }
    else{
      _nothingHasBeenPressed = true; 
      gender = 'nothing';
    }
  }

   @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("Bild"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
            Center(
             child: Column(
             children: <Widget>[
              const Padding(
               padding: EdgeInsets.all(7),
                 child: Text(
                 "Lägg till profilbild",
                  style:
                TextStyle(fontSize: 30,),
           ),
         ),
Padding(padding: const EdgeInsets.all(5),
             child: ElevatedButton(
              
               style: ElevatedButton.styleFrom(fixedSize: const Size(130,130),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                 backgroundColor: _womanHasBeenPressed ?const Color.fromRGBO(0,181,169,100) : Colors.white,
                
               ),
               onPressed: () => setState((){
                 pressedbutton("woman");
               }
               ),
               child: Row(
                 children: const [
                   Align (alignment: Alignment.centerLeft,
                     child: Text("Bild                                                      ",
                     style: TextStyle(color: Color.fromRGBO(112,112,112,100))
                     )
                     ),
                   Align(alignment: Alignment.centerRight,
                     child: Icon(Icons.check)
                   ),
                 ],
               ),
               )
  
               ),
            
               Padding(padding: const EdgeInsets.all(5),
             child: ElevatedButton(
              
               style: ElevatedButton.styleFrom(fixedSize: const Size(300,60),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                 backgroundColor: _manHasBeenPressed ? const Color.fromRGBO(0,181,169,100) : Colors.white,
               ),
               onPressed: () => setState(() {
                 pressedbutton("man");
               }
               ),
               child: Row(
                 children: const [
                   Align(alignment: Alignment.centerLeft,
                     child: Text("  Välj bild                                                          ",
                     style: TextStyle(color: Color.fromRGBO(112,112,112,100))
                     )
                   ),
                   Align(alignment: Alignment.centerRight,
                     child: Icon(Icons.check)
                   ),
                 ],
             ),
               ),
               ),


               Padding(padding: const EdgeInsets.all(5),
             child: ElevatedButton(
              
               style: ElevatedButton.styleFrom(fixedSize: const Size(300,60),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                 backgroundColor : _nothingHasBeenPressed ? const Color.fromRGBO(0,181,169,100) : Colors.white,
               ),
               onPressed: () => setState(() {
                 pressedbutton("nothing");
               }
               ),
               child: Row(
                 children: const [
                   Align(alignment: Alignment.centerLeft,
                     child: Text("  Ta en selfie                                        ",
                     style: TextStyle(color: Color.fromRGBO(112,112,112,100))
                     )
                   ),
                   Align(alignment: Alignment.centerRight,
                     child: Icon(Icons.check)
                   ),
                 ],
               ),
             ),
               )
             ],
               ),
             ),
      

          Positioned(
            top: 15.0, // adjust this value to change the position of the button
            right: 10.0, // adjust this value to change the position of the button
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  backgroundColor: const Color.fromARGB(156, 0, 171, 159),
                  minimumSize: const Size(160,50)
                  ),

              child: const Text(
                "Hoppa över",
               style: TextStyle(
                    color:  Color.fromARGB(255, 255, 255, 255),
                    fontSize: 15,
               ),
              ),
            ),
          ),

 Positioned(
            top: 15.0, // adjust this value to change the position of the button
            left: 10.0, // adjust this value to change the position of the button
            child: ElevatedButton(
              onPressed: ()  {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  backgroundColor: const Color.fromARGB(156, 0, 171, 159),
                  minimumSize: const Size(50,50)
                  ),

              child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Color.fromRGBO(255, 255, 255, 1)), 
                  
                  onPressed: () {},
              ),
            ),
          ),

      Padding(
            padding: const EdgeInsets.all(70),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  backgroundColor: const Color.fromARGB(156, 0, 171, 159),
                  minimumSize: const Size(250,70)
                ),
                child: const Text(
                  "Gå vidare",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                ),
              ),
            ),
           ),
      ),
      ],
      ),
     );
  }
  }