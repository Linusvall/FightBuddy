import 'dart:core';

class User {
  final String uid;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String height;
  final int weight;
  final String place;
  final String information;
  final List<String> level;
  final int prefWeight;
  final List<String> prefGender;
  final String prefLevel;
  final List<String> martialArts;
  final List<String> uidList;
  late List<User> matches = [];
  final String yearsOfPractice;
  final String profilePicture;

  User({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.place,
    required this.information,
    required this.level,
    required this.prefWeight,
    required this.prefGender,
    required this.prefLevel,
    required this.martialArts,
    required this.uidList,
    required this.yearsOfPractice,
    required this.profilePicture,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      uid: data['uid'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      age: data['age'],
      gender: data['gender'],
      height: data['height'],
      weight: data['weight'],
      place: data['place'],
      information: data['information'],
      level: <String>[...data['level']],
      prefWeight: data['prefWeight'],
      prefGender: <String>[...data['prefGender']],
      prefLevel: data['prefLevel'],
      martialArts: <String>[...data['martialArts']],
      uidList: <String>[...data['uidList']],
      yearsOfPractice: data['yearsOfPractice'],
      profilePicture: data['profilePicture'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'information': information,
      'level': level,
      'prefWeight': prefWeight,
      'prefGender': prefGender,
      'prefLevel': prefLevel,
      'martialArts': martialArts,
      'uidList': uidList,
      'yearsOfPractice': yearsOfPractice,
      'profilePicture': profilePicture,
    };
  }
}
