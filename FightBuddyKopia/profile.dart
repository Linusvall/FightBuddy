import 'package:flutter/material.dart';

int itemCount = 1;

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: itemCount,  
      itemBuilder: (
      BuildContext context, int index) {
      return const ListTile(
        title: Text('Profil'),
      );
    });
  }
}