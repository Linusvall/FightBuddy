import 'package:flutter/material.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BirthPage(),
    );
  }
}

class BirthPage extends StatefulWidget{
  const BirthPage({super.key});
 @override
  BirthPageState createState() => BirthPageState();
  }
  class BirthPageState extends State<BirthPage>{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("Ålder"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(90),
                  child: Text(
                    "Jag är född ",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    "Vi kommer  förmodligen inte fira med tårta (sorry!) men vi kommer att rekommendera fightbuddys, grupper och aktiviteter utifrån din ålder",
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'DD',
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
                          hintText: 'MM',
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
                          hintText: 'YYYY',
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