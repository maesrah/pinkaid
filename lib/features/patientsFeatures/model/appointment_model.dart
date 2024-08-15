import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final DateTime appointmentDate;
  final String status; // e.g., 'scheduled', 'completed', 'cancelled'
  final String notes;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.status,
    this.notes = '',
  });

  // Method to convert AppointmentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'appointmentDate': appointmentDate.toIso8601String(),
      'status': status,
      'notes': notes,
    };
  }

  // Method to create AppointmentModel from JSON
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      status: json['status'],
      notes: json['notes'] ?? '',
    );
  }

  
  factory Appointment.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Appointment(
      id: data['id'],
      patientId: data['patientId'],
      doctorId: data['doctorId'],
      appointmentDate: DateTime.parse(data['appointmentDate']),
      status: data['status'],
      notes: data['notes'] ?? '',
    );
  }
}
