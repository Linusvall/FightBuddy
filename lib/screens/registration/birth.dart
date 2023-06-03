import 'package:fight_buddy/screens/registration/heightweight.dart';
import 'package:flutter/material.dart';
import '../../handlers/user_handler.dart';
import 'package:age_calculator/age_calculator.dart';

void main() {
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

class BirthPage extends StatefulWidget {
  const BirthPage({super.key});
  @override
  BirthPageState createState() => BirthPageState();
}

class BirthPageState extends State<BirthPage> {
  late DateTime birthday;
  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  final UserHandler database = UserHandler();
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
                          controller: dayController,
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
                          controller: monthController,
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
                          controller: yearController,
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
            const SizedBox(height: 200),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: const Color.fromRGBO(3, 137, 129, 50),
                        fixedSize: const Size(250, 50),
                      ),
                      onPressed: () {
                        birthday = DateTime(
                            int.parse(yearController.text),
                            int.parse(monthController.text),
                            int.parse(dayController.text));
                        DateDuration duration = AgeCalculator.age(birthday);
                        database.updateUserAge(duration.years);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const HeightWeightPage()));
                        //Gå vidare till nästa sida
                      },
                      child: const Text('Gå vidare',
                          style: TextStyle(fontSize: 20)))),
            ),
          ],
        ),
      ),
    );
  }
}
