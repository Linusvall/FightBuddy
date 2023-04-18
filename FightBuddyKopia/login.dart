import 'package:flutter/material.dart';
import 'sqltest.dart';
import 'homepage.dart';
import 'utils/secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _passController = TextEditingController();

  String userName = '';
  String password = '';
  bool loggedIn = false;
  bool loginFail = false;
  var _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
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
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User name',
                      prefixIcon: Icon(Icons.person),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _passController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      errorText:
                          loginFail ? 'Wrong username or password' : null,
                      prefixIcon: Icon(Icons.lock),
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
                      userName = _nameController.text;
                      password = _passController.text;
                    });
                    loggedIn = await sqlLogin(userName, password);
                    if (!mounted) return;
                    if (loggedIn) {
                      UserSecureStorage.setUsername(userName);
                      UserSecureStorage.setPassword(password);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false,
                      );
                    } else {
                      setState(() {
                        loginFail = true;
                      });
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