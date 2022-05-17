import 'package:cloud_firestore/cloud_firestore.dart';

enum EventTypes { concert, drinking, dancing }

class EventModel {
  final String? id;
  final String name;
  final String description;
  final Timestamp date;
  final int points;
  final List<DocumentReference<Map<String, dynamic>>> going;
  final String secret;
  final List<String> photos;
  final String address;
  final EventTypes type;

  EventModel(
    this.name,
    this.description,
    this.date,
    this.points,
    this.going,
    this.secret,
    this.photos,
    this.address,
    this.type, {
    this.id,
  });

  factory EventModel.fromJson(Map<String, dynamic> data, {String? uid}) {
    EventTypes tempType = EventTypes.concert;

    switch (data["type"]) {
      case "concert":
        tempType = EventTypes.concert;
        break;
      case "drinking":
        tempType = EventTypes.drinking;
        break;
      case "dancing":
        tempType = EventTypes.dancing;
        break;
      default:
    }

    return EventModel(
      data["name"],
      data["description"],
      data["date"],
      data["points"],
      data['going'].cast<DocumentReference<Map<String, dynamic>>>(),
      data["secret"],
      data["photos"].cast<String>(),
      data["address"],
      tempType,
      id: uid,
    );
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "date": date,
        "points": points,
        "going": going,
        "secret": secret,
        "photos": photos,
        "address": address,
        "type": type.name,
      };
}
