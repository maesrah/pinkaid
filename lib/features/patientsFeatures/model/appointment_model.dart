import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final String doctorName;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String status; // e.g., 'scheduled', 'completed', 'cancelled'
  final String notes;
  final String patientName;

  Appointment({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    this.notes = '',
  });

  // Method to convert AppointmentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'patientName':patientName,
      'doctorId': doctorId,
      'doctorName':doctorName,
      'appointmentDate': appointmentDate.toIso8601String(),
      'appointmentTime':appointmentTime,
      'status': status,
      'notes': notes,
    };
  }

  // Method to create AppointmentModel from JSON
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patientId: json['patientId'],
      patientName: json['patientName'],
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      appointmentTime: json['appointmentTime'],
      status: json['status'],
      notes: json['notes'] ?? '',
    );
  }

  
  factory Appointment.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Appointment(
      id: data['id'],
      patientId: data['patientId'],
      patientName: data['patientName'],
      doctorId: data['doctorId'],
      doctorName: data['doctorName'],
      appointmentDate: DateTime.parse(data['appointmentDate']),
      appointmentTime: data['appointmentTime'],
      status: data['status'],
      notes: data['notes'] ?? '',
    );
  }
}
