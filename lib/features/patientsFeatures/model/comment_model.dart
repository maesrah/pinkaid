import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String fullName;
  String postId;
  String comment;
  final datePublished;
  String profImage;

  Comment(
      {required this.id,
      required this.fullName,
      required this.postId,
      required this.comment,
      required this.datePublished,
      required this.profImage});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'postId': postId,
      'datePublished': datePublished,
      'profImage': profImage,
      'comment': comment
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      postId: json['postId'] as String,
      datePublished: json['datePublished'] as Timestamp,
      comment: json['comment'] as String,
      profImage: json['profImage'] as String,
    );
  }

  factory Comment.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Comment(
      id: data['id'] as String,
      fullName: data['fullName'] as String,
      postId: data['postId'] as String,
      datePublished: data['datePublished'] as Timestamp,
      comment: data['comment'] as String,
      profImage: data['profImage'] as String,
    );
  }
}
