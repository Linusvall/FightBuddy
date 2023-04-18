import 'package:flutter/material.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  int currentPage = 0; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'), 
          centerTitle: true
        ),
        body: const Center(),
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Hem'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
          ],
          onDestinationSelected: (int index){
            setState(() {
              currentPage = index;
            });
          },
          selectedIndex: currentPage,
        )
    );
  }
}



