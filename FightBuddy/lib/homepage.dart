import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'profile.dart';
import 'aboutyou.dart';
import 'birth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final List<Widget> _pages = const [
    ProfilePage(),
    AboutYouPage(),
    BirthPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(245, 245, 245, 245),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'lib/assets/images/logo.png',
              fit: BoxFit.contain,
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'FightBuddy',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [];
              },
              child: IconButton(
                icon: const Icon(Icons.notifications,
                    color: Color.fromRGBO(80, 82, 86, 100)),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: PageView(
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          }
          /*       Center(
        child: Column(
          children: [
            const Text(
              "Startsidan",
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60),
              ),
              icon: const Icon(Icons.exit_to_app_sharp, size: 32),
              label: const Text(
                "Logga ut",
                style: TextStyle(fontSize: 24),
              ),
              onPressed: signOut,
            ),
          ],
        ),
      ),
      */
          ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromRGBO(80, 82, 86, 100)),
            label: 'Hem',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_sharp,
                  color: Color.fromRGBO(80, 82, 86, 100)),
              label: 'Bokade pass'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline_sharp,
                  color: Color.fromRGBO(80, 82, 86, 100)),
              label: 'Meddelanden'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: Color.fromRGBO(80, 82, 86, 100)),
              label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Color.fromRGBO(80, 82, 86, 100)),
              label: 'Profil'),
        ],
        unselectedItemColor: Color.fromRGBO(80, 82, 86, 100),
        selectedItemColor: const Color.fromRGBO(80, 82, 86, 100),
      ),
    );
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
