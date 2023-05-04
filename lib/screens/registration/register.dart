import 'package:fight_buddy/screens/registration/gender.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../handlers/database.dart';
import '../../handlers/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthService auth = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _passController1 = TextEditingController();
  final _passController2 = TextEditingController();

  String userName = '';
  String password1 = '';
  String password2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(3, 137, 129, 50), //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white10,
        //Någon titeltext?
        title: const Text("Skapa konto"),
        titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Form(
            key: formKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a username';
                      }
                      return null;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passController1,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: _passController2,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Confirm password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm password';
                      }
                      if (value != _passController1.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    }),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: const Color.fromRGBO(3, 137, 129, 50),
                fixedSize: const Size(250, 50),
              ),
              child: const Text('SKAPA KONTO'),
              onPressed: () {
                setState(() {
                  userName = _nameController.text;
                  password1 = _passController1.text;
                });
                if (formKey.currentState!.validate()) {
                  auth.registerUser(userName, password1);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GenderPage()));
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
