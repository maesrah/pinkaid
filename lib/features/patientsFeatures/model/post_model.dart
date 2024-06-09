import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String fullName;
  String postId;
  final datePublished;
  String title;
  String caption;
  String postUrl;
  String profImage;

  String categoryId;

  Post({
    required this.id,
    required this.fullName,
    required this.postId,
    required this.title,
    required this.caption,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'postId': postId,
      'datePublished': datePublished,
      'title': title,
      'caption': caption,
      'postUrl': postUrl,
      'profImage': profImage,
      'categoryId': categoryId,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      postId: json['postId'] as String,
      datePublished: json['datePublished'] as Timestamp,
      postUrl: json['postUrl'] as String,
      title: json['title'] as String,
      caption: json['caption'] as String,
      profImage: json['profImage'] as String,
      categoryId: json['categoryId'] as String,
    );
  }

  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Post(
      id: data['id'] as String,
      fullName: data['fullName'] as String,
      postId: data['postId'] as String,
      datePublished: data['datePublished'] as Timestamp,
      postUrl: data['postUrl'] as String,
      title: data['title'] as String,
      caption: data['caption'] as String,
      profImage: data['profImage'] as String,
      categoryId: data['categoryId'] as String,
    );
  }
}
