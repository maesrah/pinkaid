import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';

class Patient extends UserModel {
  final String medicalHistory;
  final List<String> allergies;
  
  Patient({
    required String id,
    required String name,
    required String phoneNumber,
    required String profilePicture,
    required this.medicalHistory,
    required this.allergies,
    
  }) : super(id: id, fullName: name, phoneNumber: phoneNumber, role: UserRole.patient,profilePicture: profilePicture);

   @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'medicalHistory': medicalHistory,
      'allergies': allergies,
      
    });
    return data;
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      medicalHistory: json['medicalHistory'] as String,
      allergies: List<String>.from(json['allergies'] as List), 
      profilePicture: json['profilePicture'] as String,
      
    );
  }

  factory Patient.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Patient(
      id: data['id'] as String,
      name: data['fullName'] as String,
      phoneNumber: data['phoneNumber'] as String,
      medicalHistory: data['medicalHistory'] as String,
      allergies: List<String>.from(data['allergies'] as List),
      profilePicture: data['profilePicture'] as String,
      
    );
  }

}

