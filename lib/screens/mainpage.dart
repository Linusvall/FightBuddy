import 'package:fight_buddy/screens/create_event.dart';
import 'package:fight_buddy/screens/eventpage.dart';
import 'package:fight_buddy/screens/settings/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPageIndex = 0;
  final List<Widget> _pages = const [
    HomePage(),
    EventPage(),
    SettingsPage(),
    ProfilePage(),
  ];

  late final PageController _pageController = PageController(initialPage: 0);

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
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromRGBO(80, 82, 86, 100)),
            label: 'Hem',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_sharp,
                  color: Color.fromRGBO(80, 82, 86, 100)),
              label: 'Events'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: Color.fromRGBO(80, 82, 86, 100)),
              label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Color.fromRGBO(80, 82, 86, 100)),
              label: 'Profil'),
        ],
        unselectedItemColor: const Color.fromRGBO(80, 82, 86, 100),
        selectedItemColor: const Color.fromRGBO(80, 82, 86, 100),
      ),
    );
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
