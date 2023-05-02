import 'package:fight_buddy/handlers/firebase_options.dart';
import 'package:fight_buddy/screens/mainpage.dart';
import 'package:fight_buddy/screens/registration/aboutyou.dart';
import 'package:fight_buddy/screens/registration/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'utils/secure_storage.dart';
import 'screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Initialization of Firebase
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    _readFromStorage();
  }

  Future<void> _readFromStorage() async {
    final String? userName = await UserSecureStorage.getUsername();
    final String? password = await UserSecureStorage.getPassword();
  }

  @override
  Widget build(BuildContext context) {
    Widget homePage = const WelcomePage();
    if (loggedIn) {
      homePage = const HomePage();
    }
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Color.fromARGB(255, 211, 0, 253),

        // Define the default font family.
        //fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontFamily: 'Paytone',
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(3, 137, 129, 50)),
          titleLarge: TextStyle(
              fontFamily: 'Paytone',
              fontSize: 20.0,
              fontStyle: null,
              color: Color.fromRGBO(3, 137, 129, 50)),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),

      //Auto login till homepage, utkommenterad tills vi har utloggningsknapp
      //home: loggedIn ? const HomePage() : const WelcomePage(),

      home: const WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'lib/assets/images/logo.png',
            fit: BoxFit.contain,
            height: 150,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'FightBuddy',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: const Color.fromRGBO(3, 137, 129, 50),
              fixedSize: const Size(250, 50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Spacer(),
                Text(
                  '     LOGGA IN',
                  style: TextStyle(fontSize: 15),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
              ],
            ),
            onPressed: () {
              //gå till login
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
          const SizedBox(
            height: 320,
          ),
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: 'Har du inget konto?  ',
                  children: [
                TextSpan(
                  text: 'Skapa konto',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      //gå till register
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromRGBO(3, 137, 129, 50)),
                )
              ]))
        ],
      )),
    );
  }
}




/*appBar: AppBar(
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
                style: Theme.of(context).textTheme.displayLarge,
              ),
            )
          ],
        ),
      ),*/