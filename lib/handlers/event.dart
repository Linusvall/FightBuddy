import 'dart:core';

class Event {
  final String about;
  final String capacity;
  final String category;
  final String date;
  final String eventName;
  final String level;
  final String place;
  final String timeFrom;
  final String timeTo;
  final String weightClass;
  final String eventPicture;
  final List<String> attendees;
  final String organizer;
  final String eventid;

  Event({
    required this.about,
    required this.capacity,
    required this.category,
    required this.date,
    required this.eventName,
    required this.level,
    required this.place,
    required this.timeFrom,
    required this.timeTo,
    required this.weightClass,
    required this.eventPicture,
    required this.organizer,
    required this.attendees,
    required this.eventid,
  });

  factory Event.fromMap(Map<String, dynamic> data) {
    return Event(
      about: data['about'],
      capacity: data['capacity'],
      category: data['category'],
      date: data['date'],
      eventName: data['eventName'],
      level: data['level'],
      place: data['place'],
      timeFrom: data['timeFrom'],
      timeTo: data['timeTo'],
      weightClass: data['weightClass'],
      eventPicture: data['eventPicture'],
      organizer: data['organizer'],
      attendees: <String>[...data['attendees']],
      eventid: data['eventid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'about': about,
      'capacity': capacity,
      'category': category,
      'date': date,
      'eventName': eventName,
      'level': level,
      'place': place,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'weightClass': weightClass,
      'eventPicture': eventPicture,
      'organizer': organizer,
      'attendees': attendees,
      'eventid': eventid,
    };
  }
}
