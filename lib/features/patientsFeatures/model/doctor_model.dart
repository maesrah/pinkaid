import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';

class Doctor extends UserModel{
  
  String position;
  String workExperience;
  String hospitalWork;
  String profImage;
  List<Map<String, dynamic>> blockedDates;
  


  Doctor({
    required super.id,
    required super.phoneNumber,
    required super.profilePicture,
    required String fullName,
    
    required this.position,
    required this.workExperience,
    required this.hospitalWork,
    required this.profImage,
    required this.blockedDates,
    
  }): super(
          fullName: fullName,
          role: UserRole.patient,
        );



  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'position':position,
      'workExperience': workExperience,
      'hospitalWork':hospitalWork ,
      'profImage': profImage,
      'blockedDates':blockedDates,
    });
    return data;
  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
       id: json['id'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profilePicture: json['profilePicture'] as String,
      position: json['position'] as String,
      workExperience: json['workExperience'] as String,
      hospitalWork: json['hospitalWork'] as String,
      profImage: json['profImage'] as String,
      blockedDates: (json['blockedDates'] != null && json['blockedDates'] is List)
    ? List<Map<String, dynamic>>.from(json['blockedDates'])
    : [],
    
    );
  }

  factory Doctor.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Doctor(
      id: data['id'] as String,
      fullName: data['fullName'] as String,
      phoneNumber: data['phoneNumber'] as String,
      profilePicture: data['profilePicture'] as String,
      position: data['position'] as String,
      workExperience: data['workExperience'] as String,
      hospitalWork: data['hospitalWork'] as String,
      profImage: data['profImage'] as String,
       blockedDates: (data['blockedDates'] != null && data['blockedDates'] is List)
    ? List<Map<String, dynamic>>.from(data['blockedDates'])
    : [], 
    );
  }

   factory Doctor.empty() {
    return Doctor(
      id: '',
      fullName: '',
      phoneNumber: '',
      profilePicture: '',
      position: '', 
      workExperience: '', 
      hospitalWork: '', 
      profImage: '',
      blockedDates: [],
      
    );
  }
}
