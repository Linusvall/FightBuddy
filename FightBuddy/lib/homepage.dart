import 'package:flutter/material.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
} 

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  List<Widget> pages = const [
    HomePage(), 
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(245, 245, 245, 245),
          elevation: 0,
          leading: SizedBox(
            width: double.infinity,
            height: kToolbarHeight,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'lib/assets/images/logga.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [];
              },
                child: IconButton(
                  icon: const Icon(Icons.notifications, color: Color.fromRGBO(80, 82, 86, 100)),
                  onPressed: () {},
                ),
              ),
            ),
          ],


        ),
        body: const Center(),
        bottomNavigationBar: NavigationBar(
        destinations: const [ 
          NavigationDestination(icon: Icon(Icons.home), label: 'Hem'),
          NavigationDestination(icon: Icon(Icons.calendar_month_sharp), label: 'Bokade pass'),
          NavigationDestination(icon: Icon(Icons.mail_outline_sharp), label: 'Meddelanden'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
        onDestinationSelected: (int index){
          setState(() {
            currentPage = index;
            });
          },
          selectedIndex: currentPage,
        ),
    );
  }


}
