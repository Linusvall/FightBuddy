import 'package:fight_buddy/screens/registration/gender.dart';
import 'package:flutter/material.dart';
import '../../../handlers/auth.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({Key? key}) : super(key: key);

  @override
  ChangeEmailPageState createState() => ChangeEmailPageState();
}

class ChangeEmailPageState extends State<ChangeEmailPage> {
  AuthService auth = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _passController1 = TextEditingController();

  String userName = '';
  String password1 = '';
  String password2 = '';

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
        title: const Text(""),
        titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Form(
            key: formKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      labelText: 'Ny email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter an email';
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
                    prefixIcon: const Icon(Icons.mail),
                    labelText: 'Bekräfta email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter an email';
                    }
                    return null;
                  },
                ),
              ),
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
              child: const Text('ÄNDRA EMAIL'),
              onPressed: () {
                setState(() {
                  userName = _nameController.text;
                  password1 = _passController1.text;
                });
                if (formKey.currentState!.validate()) {
                  auth.registerUser(userName, password1);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GenderPage()));
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
