import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole {
  doctor,
  patient,
}

class UserModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final UserRole role;
  final String? medicalId;
  String profilePicture;

  UserModel(
      {required this.id,
      required this.fullName,
      required this.phoneNumber,
      required this.role,
      this.medicalId,
      required this.profilePicture});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        phoneNumber: json['phoneNumber'] as String,
        role: UserRole.values.firstWhere((e) => e.name == json['role']),
        medicalId: json['medicalId'] as String?,
        profilePicture: json['profilePicture'] as String);
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
        id: snapshot.id,
        fullName: data['fullName'] as String,
        phoneNumber: data['phoneNumber'] as String,
        role: UserRole.values.firstWhere((e) => e.name == data['role']),
        medicalId: data['medicalId'] as String?,
        profilePicture: data['profilePicture'] as String);
  }

  factory UserModel.empty() {
    return UserModel(
        id: '',
        fullName: '',
        phoneNumber: '',
        role: UserRole.patient,
        medicalId: null,
        profilePicture: '');
  }

  // Method to convert a UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'role': role.name,
      'medicalId': medicalId,
      'profilePicture': profilePicture
    };
  }
}
