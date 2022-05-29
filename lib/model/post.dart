import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/model/users.dart';

class Posts {
  final String? id;
  final Users owner;
  final String caption;
  final String photo;
  final List likes;
  final List<Map<String, dynamic>> comments;
  final Timestamp createdAt;

  Posts(
    this.owner,
    this.caption,
    this.photo,
    this.likes,
    this.comments,
    this.createdAt, {
    this.id,
  });

  factory Posts.fromJson(Map<String, dynamic> data, {String? id}) {
    return Posts(
      data["owner"],
      data["caption"],
      data["photo"],
      data["likes"],
      data["comments"].cast<Map<String, dynamic>>(),
      data["created_at"],
      id: id,
    );
  }

  Map<String, dynamic> toMap() => {
        "caption": caption,
        "photo": photo,
        "likes": likes,
        "comments": comments,
      };
}
