import 'package:fight_buddy/screens/registration/profilpicture.dart';
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
      home: HeightWeightPage(),
    );
  }
}

class HeightWeightPage extends StatefulWidget {
  const HeightWeightPage({super.key});

  @override
  HeightWeightPageState createState() => HeightWeightPageState();
}

class HeightWeightPageState extends State<HeightWeightPage> {
  final UserHandler database = UserHandler();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  bool weightButton = false;
  bool heightButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(3, 137, 129, 50), //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(90),
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
                          controller: weightController,
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
                          controller: heightController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'LÄNGD CM',
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
                  const SizedBox(
                    height: 320,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor:
                                  const Color.fromRGBO(3, 137, 129, 50),
                              fixedSize: const Size(250, 50),
                            ),
                            onPressed: () {
                              UserHandler().updateUserHeightAndWeight(
                                  heightController.text,
                                  int.parse(weightController.text));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfilePicture()));
                            },
                            child: const Text('Gå vidare',
                                style: TextStyle(fontSize: 20)))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
