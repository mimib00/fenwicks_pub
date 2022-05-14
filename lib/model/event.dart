import 'package:cloud_firestore/cloud_firestore.dart';
import 'users.dart';

enum EventTypes { concert, drinking, dancing }

class Event {
  final String? id;
  final String name;
  final String description;
  final Timestamp date;
  final int points;
  final List<Users> going;
  final String secret;
  final List<String> photos;
  final String address;
  final EventTypes type;

  Event(
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

  factory Event.fromJson(Map<String, dynamic> data, {String? uid}) {
    // List<Map<String, dynamic>> temp = data['going'];

    // for (var user in temp) {}

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

    return Event(
      data["name"],
      data["description"],
      data["date"],
      data["points"],
      <Users>[],
      data["secret"],
      data["photos"].cast<String>(),
      data["address"],
      tempType,
      id: uid,
    );
  }
  toMap() => {
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
