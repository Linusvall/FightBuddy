import 'package:flutter/material.dart';
import 'sqltest.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage>{

  final _nameController = TextEditingController();
  final _passController1 = TextEditingController();
  final _passController2 = TextEditingController();
  
  String userName = '';
  String password1 = '';
  String password2= '';


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('FightBuddy'),
        centerTitle: true
      ),

      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
        const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Register'),
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
              controller: _passController1, 
              obscureText: true,
              decoration: InputDecoration(
               border: OutlineInputBorder(),
              labelText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  _passController1.clear();
                },
                icon: const Icon(Icons.clear),
              )
              ),
                      ),
            ),
             Padding(
              padding: EdgeInsets.all(10),
              child:  TextField(
              controller: _passController2, 
              obscureText: true,
              decoration: InputDecoration(
               border: OutlineInputBorder(),
              labelText: 'Confirm password',
              suffixIcon: IconButton(
                onPressed: () {
                  _passController2.clear();
                },
                icon: const Icon(Icons.clear),
              )
              ),
                      ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                child: const Text('Confirm'),
                onPressed: () {
                  setState(() {
                  userName = _nameController.text;
                  password1 = _passController1.text;
                  password2 = _passController2.text;

                  //anropa sqlmetod för insert
                  if(password1 == password2){
                    sqlInsert(userName, password1);
                  }else{
                    //Visa på skärmen istället för print här
                    print('Passwords do not match');
                  }
                  
                  });
                  
                },
              ),
            ),
      ],)),


      
    );
  }

}
 

