import 'package:flutter/material.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: KampsportPage(),
    );
  }
}

class KampsportPage extends StatefulWidget{
  const KampsportPage({super.key});
 @override
  KampsportPageState createState() => KampsportPageState();
  }
  class KampsportPageState extends State<KampsportPage>{
  List<String> options = [    "Boxning",    "MMA",    "Taekwondo",    "Judo",    "Karate",    "Kickboxning",    "Kendo",    "Sumo",    "Wushu",  ];

  List<String> selectedOptions = [];

  void _onOptionSelected(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Välja kampssportsintressen"),
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
                    "Dina kampssportsintressen",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Välj kampsporter som du aktivt utövar. Vi kommer matcha ihop dig med personer med samma intressen😊 ",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Välj max 6 stycken"),
                ),
                Wrap(
                  children: options.map((option) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: Text(option),
                        selected: selectedOptions.contains(option),
                        onSelected: (_) => _onOptionSelected(option),
                      ),
                    );
                  }).toList(),
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