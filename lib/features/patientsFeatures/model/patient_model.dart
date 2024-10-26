import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
 

class Patient extends UserModel {
  Map<String,dynamic> medicalHistory; 
  List<Map<String, dynamic>>medication;
  double weight;
  double height;
  double get bmi => weight / ((height / 100) * (height / 100));
  int dailySleepHours;

  // Tracking meals, exercises, and symptoms for each date
  Map<String, Map<String, dynamic>> dailyTracking;
  int streakCount; // Streak counter
  DateTime lastActiveDate;

  Patient({
    required super.id,
    required String name,
    required super.phoneNumber,
    required super.profilePicture,
    required this.medicalHistory,
    required this.medication,
    required this.weight,
    required this.height,
    required this.dailySleepHours,
    required this.dailyTracking,
     required this.streakCount,
    required this.lastActiveDate,
    
  }) : super(
          fullName: name,
          role: UserRole.patient,
          fillForm: false,
        );

  // Convert Patient object to JSON for Firestore
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'medicalHistory': medicalHistory,
      'medication': medication,
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'dailySleepHours': dailySleepHours,
      'dailyTracking': dailyTracking, 
      'streakCount': streakCount, 
      'lastActiveDate': DateFormat('dd-MM-yyyy').format(lastActiveDate),
    });
    return data;
  }

  // Create a Patient from Firestore JSON data
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profilePicture: json['profilePicture'] as String,
       medicalHistory:Map<String, dynamic>.from(json['medicalHistory'] ?? []),
      medication: (json['medication'] != null && json['medication'] is List)
    ? List<Map<String, dynamic>>.from(json['medication'])
    : [], 
      weight: (json['weight'] is String)
          ? double.tryParse(json['weight']) ?? 0.0
          : json['weight'] as double,
      height: (json['height'] is String)
          ? double.tryParse(json['height']) ?? 0.0
          : json['height'] as double,
      dailySleepHours: json['dailySleepHours'] as int,
      dailyTracking: (json['dailyTracking'] != null)
          ? (json['dailyTracking'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                key,
                Map<String, dynamic>.from(value as Map),
              ),
            )
          : {}, 
          streakCount: json['streakCount'] as int, 
      lastActiveDate: DateFormat('dd-MM-yyyy').parse(json['lastActiveDate']),
    );
  }

  // Create a Patient from Firestore Snapshot
  factory Patient.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

     double parseToDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0; // Default to 0.0 if parsing fails
    } else {
      return 0.0; // Default if the value is null or invalid
    }
  }
    return Patient(
      id: data['id'] as String,
      name: data['fullName'] as String,
      phoneNumber: data['phoneNumber'] as String,
      profilePicture: data['profilePicture'] as String,
      medicalHistory: Map<String, dynamic>.from(data['medicalHistory'] ?? []),
      medication: (data['medication'] != null && data['medication'] is List)
    ? List<Map<String, dynamic>>.from(data['medication'])
    : [], 
       weight: parseToDouble(data['weight']),  // Using the helper function
    height: parseToDouble(data['height']), 
      dailySleepHours: data['dailySleepHours'] as int,
      dailyTracking: (data['dailyTracking'] != null)
          ? (data['dailyTracking'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                key,
                Map<String, dynamic>.from(value as Map),
              ),
            )
          : {}, 
          streakCount: data['streakCount'] as int,
      lastActiveDate: DateFormat('dd-MM-yyyy').parse(data['lastActiveDate']),
    );
  }

  // Empty Patient constructor for initialization
  factory Patient.empty() {
    return Patient(
      id: '',
      name: '',
      phoneNumber: '',
      profilePicture: '',
      medicalHistory: {},
      medication: [],
      weight: 0.0,
      height: 0.0,
      dailySleepHours: 0,
      dailyTracking: {}, 
      streakCount:0,
      lastActiveDate: DateTime.now(),
    );
  }
}
