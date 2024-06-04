import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Post {
  String id;
  String fullName;
  String postId;
  final datePublished;
  String title;
  String caption;
  String postUrl;
  String profImage;
  RxList<dynamic> likes;
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
    required List<dynamic> likes,
    required this.categoryId,
  }) : likes = RxList<dynamic>(likes);

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
      'likes': likes.toList(),
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
      likes: List<dynamic>.from(json['likes']),
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
      likes: List<dynamic>.from(data['likes']),
      categoryId: data['categoryId'] as String,
    );
  }
}
