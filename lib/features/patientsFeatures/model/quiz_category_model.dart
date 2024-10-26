import 'package:cloud_firestore/cloud_firestore.dart';

class QuizCategoryModel {
  String id;
  String quizCategoryName;
  String image;
  

  QuizCategoryModel(
      {required this.id,
      required this.quizCategoryName,
      required this.image,
     });

  static QuizCategoryModel empty() =>
      QuizCategoryModel(id: '', quizCategoryName: '',image:'');

  Map<String, dynamic> toJson() {
    return {'quizCategoryName': quizCategoryName,
    'image':image};
  }

  factory QuizCategoryModel.fromJson(Map<String, dynamic> json) {
    return QuizCategoryModel(
        id: json['id'] as String,
        quizCategoryName: json['quizCategoryName'] as String,
        image: json['image'] as String,
       );
  }

  factory QuizCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return QuizCategoryModel(
      id: snapshot.id,
      quizCategoryName: data['quizCategoryName'] as String,
       image: data['image'] as String
      
      
    );
  }
}
