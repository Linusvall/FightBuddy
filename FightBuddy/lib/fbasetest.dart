import 'package:fight_buddy/screens/registration/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage2 extends StatelessWidget {
  const LoginPage2({Key? key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MainPage();
            } else {
              return const LoginWidget();
            }
          }));
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loggedIn = false;
  bool loginFail = false;
  var _passwordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        reverse: true,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User name',
                  prefixIcon: Icon(Icons.person),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  errorText: loginFail ? 'Wrong username or password' : null,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: const Color.fromRGBO(3, 137, 129, 50),
                      fixedSize: const Size(250, 50),
                    ),
                    onPressed: signIn,
                    child: const Text('LOGGA IN'),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text('Skapa konto'),
                  ),
                ]),
          ),
        ]),
      );

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }
}
