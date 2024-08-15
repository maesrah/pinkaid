import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  String id;
  String fullName;
  String position;
  String workExperience;
  String hospitalWork;
  String profImage;
  


  Doctor({
    required this.id,
    required this.fullName,
    required this.position,
    required this.workExperience,
    required this.hospitalWork,
    required this.profImage,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'position':position,
      'workExperience': workExperience,
      'hospitalWork':hospitalWork ,
      'profImage': profImage,
    };
  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'].toString(),
      fullName: json['fullName'] as String,
      position: json['position'] as String,
      workExperience: json['workExperience'] as String,
      hospitalWork: json['hospitalWork'] as String,
      profImage: json['profImage'] as String,
    
    );
  }

  factory Doctor.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Doctor(
      id: data['id'] as String,
      fullName: data['fullName'] as String,
      position: data['position'] as String,
      workExperience: data['workExperience'] as String,
      hospitalWork: data['hospitalWork'] as String,
      profImage: data['profImage'] as String,
    );
  }
}
