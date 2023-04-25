import 'package:flutter/material.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TrainingPage(),
    );
  }
}

class TrainingPage extends StatefulWidget{
  const TrainingPage({super.key});
 @override
  TrainingPageState createState() => TrainingPageState();
  }
  class TrainingPageState extends State<TrainingPage>{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("Anläggning"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(70),
                  child: Text(
                    "Var vill du träna? ",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                
                Row(
                  children: [
              
                    const SizedBox(width: 16),
                    Expanded(
                      
                      child: TextField(
                        
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Skriv in en eller flera stadsdelar',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          isDense: true,
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(100.0),
                  child: Text(
                    "**Vi kan alternativt ha en radius här som dom väljer med**"
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 15.0, // adjust this value to change the position of the button
            right: 10.0, // adjust this value to change the position of the button
            child: ElevatedButton(
              onPressed: ()  {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  backgroundColor: const Color.fromARGB(156, 0, 171, 159),
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
                  backgroundColor:const Color.fromARGB(156, 0, 171, 159),
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