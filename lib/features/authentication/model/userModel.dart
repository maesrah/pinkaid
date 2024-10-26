import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole {
  doctor,
  patient,
}

class UserModel {
  final String id;
  String fullName;
  String phoneNumber;
  final UserRole role;
  final String? medicalId;
  String profilePicture;
  bool fillForm=false;

  UserModel(
      {required this.id,
      required this.fullName,
      required this.phoneNumber,
      required this.role,
      this.medicalId,
      required this.profilePicture,
      required this.fillForm});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        phoneNumber: json['phoneNumber'] as String,
        role: UserRole.values.firstWhere((e) => e.name == json['role']),
        medicalId: json['medicalId'] as String?,
        profilePicture: json['profilePicture'] as String,
        fillForm:json['fillForm'] as bool);
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
        id: snapshot.id,
        fullName: data['fullName'] as String,
        phoneNumber: data['phoneNumber'] as String,
        role: UserRole.values.byName(data['role']),
         fillForm: data['fillForm'] as bool,
        medicalId: data['medicalId'] as String?,
        profilePicture: data['profilePicture'] as String,
        );
  }

  factory UserModel.empty() {
    return UserModel(
        id: '',
        fullName: '',
        phoneNumber: '',
        role: UserRole.patient,
        medicalId: null,
        profilePicture: '',
        fillForm: false);
  }

  // Method to convert a UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'role': role.name,
      'medicalId': medicalId,
      'profilePicture': profilePicture,
      'fillForm':fillForm
    };
  }
}
