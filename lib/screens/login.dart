import 'package:fight_buddy/screens/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _passController = TextEditingController();

  String email = '';
  String password = '';
  bool loggedIn = false;
  bool loginFail = false;
  var _passwordVisible = false;

  @override
  void initState() {
    super.initState();
  }

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
        title: const Text("Logga in"),
        titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-post',
                      prefixIcon: Icon(Icons.person),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _passController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Lösenord',
                      errorText: loginFail ? 'Fel E-post eller lösenord' : null,
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: const Color.fromRGBO(3, 137, 129, 50),
                    fixedSize: const Size(250, 50),
                  ),
                  child: const Text('LOGGA IN'),
                  onPressed: () async {
                    loginFail = false;
                    setState(() {
                      email = _nameController.text;
                      password = _passController.text;
                    });
                    if (!mounted) return;
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email, password: password);

                      loggedIn = true;
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                    if (loggedIn == true) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const MainPage()),
                          (Route<dynamic> route) => false);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
