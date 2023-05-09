import 'package:fight_buddy/screens/registration/training.dart';
import 'package:flutter/material.dart';
import '../../handlers/user_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AboutYouPage(),
    );
  }
}

class AboutYouPage extends StatefulWidget {
  const AboutYouPage({super.key});

  @override
  AboutYouPageState createState() => AboutYouPageState();
}

class AboutYouPageState extends State<AboutYouPage> {
  var informationController = TextEditingController();
  UserHandler database = UserHandler();
  pressedbutton(String button) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(3, 137, 129, 50), //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.white10,
          //Någon titeltext?
          title: const Text(""),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  //Hoppa över och gå vidare
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TrainingPage()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    backgroundColor: Colors.white,
                    minimumSize: const Size(160, 10)),
                child: const Text(
                  "Hoppa över",
                  style: TextStyle(
                    color: Color.fromRGBO(3, 137, 129, 50),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ]),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(90),
                child: Text(
                  "Berätta lite om dig själv",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                controller: informationController,
                decoration: InputDecoration(
                  hintText:
                      'Du kan börja med att säga hej, berätta om vilken kampsport du utövar när du vill träna osv...',
                  contentPadding: const EdgeInsets.all(80),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  isDense: true,
                ),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 180,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: const Color.fromRGBO(3, 137, 129, 50),
                    fixedSize: const Size(250, 50),
                  ),
                  onPressed: () {
                    database
                        .updateAboutYouInformation(informationController.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TrainingPage()));
                  },
                  child:
                      const Text('Gå vidare', style: TextStyle(fontSize: 20)))
            ],
          ),
        ),
      ),
    );
  }
}
