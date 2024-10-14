import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  String id;
  String mealName;
  int nutrient;
  int calories;

  Meal({
    required this.id,
    required this.mealName,
    required this.nutrient,
    required this.calories,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mealName': mealName,
      'nutrient': nutrient,
      'calories': calories,
     
    };
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] as String,
      mealName: json['mealName'] as String,
      nutrient: json['nutrient'] as int,
      calories: json['calories'] as int,
      
    );
  }

  factory Meal.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Meal(
      id: data['id'] as String,
      mealName: data['mealName'] as String,
      nutrient: data['nutrient'] as int,
      calories: data['calories'] as int,
     
    );
  }
}
