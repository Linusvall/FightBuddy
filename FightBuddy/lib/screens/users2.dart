import 'dart:convert';

Users2 users2FromJson(String str) => Users2.fromJson(json.decode(str));

String users2ToJson(Users2 data) => json.encode(data.toJson());

class Users2 {
  String id;
  String age;
  String firstname;
  String lastname;
  String weight;
  String height;
  String location;
  String martialarts;

  Users2({
    required this.id,
    required this.age,
    required this.firstname,
    required this.lastname,
    required this.weight,
    required this.height,
    required this.location,
    required this.martialarts,
  });

  factory Users2.fromJson(Map<String, dynamic> json) => Users2(
        id: json["id"],
        age: json["age"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        weight: json["weight"],
        height: json["height"],
        location: json["location"],
        martialarts: json["martialarts"],
      );

  get quantity => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "age": age,
        "firstname": firstname,
        "lastname": lastname,
        "weight": weight,
        "height": height,
        "location": location,
        "martialarts": martialarts,
      };
}
