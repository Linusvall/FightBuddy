import 'dart:core';
import 'package:fight_buddy/handlers/user_handler.dart';

class User {
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String height;
  final int weight;
  final String information;
  final String martialArts;
  final List<String> uidList;
  late List<User> userList = [];

  User({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.information,
    required this.martialArts,
    required this.uidList,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      firstName: data['firstName'],
      lastName: data['lastName'],
      age: data['age'],
      gender: data['gender'],
      height: data['height'],
      weight: data['weight'],
      information: data['information'],
      martialArts: data['martialArts'],
      uidList: <String>[...data['userList']],
    );
  }

  updateUserList() async {
    userList = [];
    for (String uid in uidList) {
      userList.add(await UserHandler.getUser(uid));
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'information': information,
      'martialArts': martialArts,
      'userList': uidList,
    };
  }
}
