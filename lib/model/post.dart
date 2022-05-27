import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? id;
  final DocumentReference<Map<String, dynamic>> owner;
  final String caption;
  final String photo;
  final int likes;
  final List comments;

  Post(
    this.owner,
    this.caption,
    this.photo,
    this.likes,
    this.comments, {
    this.id,
  });

  factory Post.fromJson(Map<String, dynamic> data, {String? id}) => Post(
        data["owner"],
        data["caption"],
        data["photo"],
        data["likes"].length,
        data["comments"],
        id: id,
      );

  Map<String, dynamic> toMap() => {
        "caption": caption,
        "photo": photo,
        "likes": likes,
        "comments": comments,
      };
}
