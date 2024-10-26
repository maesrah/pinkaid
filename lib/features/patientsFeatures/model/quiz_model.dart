import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String quizId;
  String question;
  List<String>? options;
  String correctAnswer;
  String? imageUrl; // Optional for image-based quizzes
  final Timestamp dateCreated;
  String categoryId;
  List<String>? letters;

  Quiz({
    required this.quizId,
    required this.question,
    this.options,
    required this.correctAnswer,
    this.imageUrl, // Optional, used for image-based quizzes
    required this.dateCreated,
    required this.categoryId,
    this.letters,
  });

  // Convert quiz object to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'imageUrl': imageUrl,
      'dateCreated': dateCreated,
      'categoryId': categoryId,
      'letters':letters,
    };
  }

  // Create quiz object from JSON
  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      quizId: json['quizId'] as String,
      question: json['question'] as String,
      options: List<String>.from(json['options']),
      correctAnswer: json['correctAnswer'] as String,
      imageUrl: json['imageUrl'] as String?,
      dateCreated: json['dateCreated'] as Timestamp,
      categoryId: json['categoryId'] as String,
      letters: List<String>.from(json['letters'])
    );
  }

  // Create quiz object from Firestore snapshot
  factory Quiz.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Quiz(
      quizId: data['quizId'] as String,
      question: data['question'] as String,
      options: List<String>.from(data['options']),
      correctAnswer: data['correctAnswer'] as String,
      imageUrl: data['imageUrl'] as String?,
      dateCreated: data['dateCreated'] as Timestamp,
      categoryId: data['categoryId'] as String,
      letters: List<String>.from(data['letters'])
    );
  }
}
