import 'dart:core';

class Event {
  final String eventName;
  final String date;
  final String timeFrom;
  final String timeTo;
  final String place;
  final String category;
  final String capacity;
  final String level;
  final String weightClass;
  final String about;

  Event({
    required this.eventName,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.place,
    required this.category,
    required this.capacity,
    required this.level,
    required this.weightClass,
    required this.about,
  });

  factory Event.fromMap(Map<String, dynamic> data) {
    return Event(
      eventName: data['eventName'],
      date: data['date'],
      timeFrom: data['timeFrom'],
      timeTo: data['timeTo'],
      place: data['place'],
      category: data['category'],
      capacity: data['capacity'],
      level: data['level'],
      weightClass: data['weightClass'],
      about: data['about'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'date': date,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'place': place,
      'category': category,
      'capacity': capacity,
      'level': level,
      'weightClass': weightClass,
      'about': about,
    };
  }
}
