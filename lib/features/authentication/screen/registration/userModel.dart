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

  UserModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.role,
    this.medicalId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        phoneNumber: json['phoneNumber'] as String,
        role: UserRole.values.firstWhere((e) => e.name == json['role']),
        medicalId: json['medicalId'] as String?);
  }

  // Method to convert a UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'role': role.name,
      'medicalId': medicalId,
    };
  }
}
