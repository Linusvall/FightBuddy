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
  final List<String> matches;
  final List<String> yearsOfPractice;
  final String profilePicture;
  final List<String> newMartialArts;
  final List<String> club;
  final List<String> createdEvents;
  final List<String> attendingEvents;
  final List<String> savedUsers;
  final String coverPicture;

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
    required this.matches,
    required this.yearsOfPractice,
    required this.profilePicture,
    required this.newMartialArts,
    required this.club,
    required this.createdEvents,
    required this.attendingEvents,
    required this.savedUsers,
    required this.coverPicture,
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
      matches: <String>[...data['matches']],
      yearsOfPractice: <String>[...data['yearsOfPractice']],
      profilePicture: data['profilePicture'],
      newMartialArts: <String>[...data['newMartialArts']],
      club: <String>[...data['club']],
      createdEvents: <String>[...data['createdEvents']],
      attendingEvents: <String>[...data['attendingEvents']],
      savedUsers: <String>[...data['savedUsers']],
      coverPicture: data['coverPicture'],
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
      'matches': matches,
      'yearsOfPractice': yearsOfPractice,
      'profilePicture': profilePicture,
      'newMartialArts': newMartialArts,
      'club': club,
      'createdEvents': createdEvents,
      'attendingEvents': attendingEvents,
      'savedUsers': savedUsers,
      'coverPicture': coverPicture,
    };
  }
}
