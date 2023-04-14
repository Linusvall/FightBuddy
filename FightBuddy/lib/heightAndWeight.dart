import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HeightAndWeightPage(),
    );
  }
}

class HeightAndWeightPage extends StatefulWidget{
  const HeightAndWeightPage({super.key});

 @override
  HeightAndWeightPageState createState() => HeightAndWeightPageState();
  }


  class HeightAndWeightPageState extends State<HeightAndWeightPage>{

    final weightController = TextEditingController();
    final heightController = TextEditingController();
    bool weightButton = false;
    bool heightButton = false;

    @override
 Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: const Text("Vikt & Längd"),
       centerTitle: true,
     ),
     body: Stack(
       children: [
         Center(
           child: Column(
            children: <Widget>[
           const Padding(
             padding: EdgeInsets.all(50),
             child: Text(
               "Vikt & Längd",
               style:
               TextStyle(fontSize: 30, fontWeight: FontWeight.bold), 
             ),
           ),
      Row(
     children: [
       Expanded(
      child: TextField(
keyboardType: TextInputType.number,
      decoration: InputDecoration(
     hintText: 'VIKT KG',
     contentPadding: const EdgeInsets.symmetric(
    horizontal: 16, vertical: 10),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5),
                         ),
                         isDense: true,
                       ),
                       style: const TextStyle(fontSize: 16),
                     ),
                   ),
                   const SizedBox(width: 16),
                   Expanded(
                     child: TextField(
                       keyboardType: TextInputType.number,
                       decoration: InputDecoration(
                         hintText: 'Längd cm',
                         contentPadding: const EdgeInsets.symmetric(
                             horizontal: 16, vertical: 10),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(5),
                         ),
                         isDense: true,
                       ),
                       style: const TextStyle(fontSize: 16),
                     ),
                   ),
           ],
       ),
           const Padding(
             padding: EdgeInsets.all(40),
             child : Text("Eller",
             style: TextStyle(fontSize: 30),
             ),
             ),
            ],
           ),
         ),
         Positioned(
           top: 15.0, // adjust this value to change the position of the button
           right: 10.0, // adjust this value to change the position of the button
           child: ElevatedButton(
             onPressed: ()  => print("pressed"),
             style: ElevatedButton.styleFrom(
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                 primary: Color.fromARGB(156, 0, 171, 159),
                 minimumSize: const Size(160,50)
                 ),


             child: const Text(
               "Hoppa över",
              style: TextStyle(
                   color: Colors.white,
                   fontSize: 15,
              ),
             ),
           ),
         ),


Positioned(
           top: 15.0, // adjust this value to change the position of the button
           left: 10.0, // adjust this value to change the position of the button
           child: ElevatedButton(
             onPressed: ()  => print("pressed"),
             style: ElevatedButton.styleFrom(
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                 primary: Color.fromARGB(156, 0, 171, 159),
                 minimumSize: const Size(50,50)
                 ),


             child: IconButton(
                 icon: const Icon(Icons.arrow_back_ios, color: Color.fromRGBO(255, 255, 255, 1)),
                
                 onPressed: () => print("PRESSED"),
             ),
           ),
         ),


     Padding(
           padding: const EdgeInsets.all(70),
           child: Align(
             alignment: Alignment.bottomCenter,
             child: ElevatedButton(
               onPressed: () => print("pressed"),
               style: ElevatedButton.styleFrom(
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                 primary: Color.fromARGB(156, 0, 171, 159),
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
