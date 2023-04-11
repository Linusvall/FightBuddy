import 'package:flutter/material.dart';
import 'sqltest.dart';

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

class _LoginPageState extends State<LoginPage>{ 

  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  
  String userName = '';
  String password = '';

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('FightBuddy'),
        centerTitle: true
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Login'),
            ),
               Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                controller: _nameController,  
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User name',
                  suffixIcon: IconButton(
                onPressed: () {
                  _nameController.clear();
                },
                icon: const Icon(Icons.clear),
              )
                )
                          ),
              ),
           Padding(
              padding: EdgeInsets.all(10),
              child:  TextField(
              controller: _passController, 
              obscureText: true,
              decoration: InputDecoration(
               border: OutlineInputBorder(),
              labelText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  _passController.clear();
                },
                icon: const Icon(Icons.clear),
              )
              ),
                      ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  setState(() {
                  userName = _nameController.text;
                  password = _passController.text;
                  sqlLogin(userName, password);
                  });
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}

