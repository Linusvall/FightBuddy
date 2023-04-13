import 'package:flutter/material.dart';
import 'sqltest.dart';
import 'homepage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                    errorText: loginFail ? 'Wrong username or password' : null,
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
                child: const Text('Login'),
                onPressed: () async {
                  loginFail = false;
                  setState(() {
                    userName = _nameController.text;
                    password = _passController.text;
                  });
                  loggedIn = await sqlLogin(userName, password);
                  if (!mounted) return;
                  if (loggedIn) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
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
    );
  }
}
