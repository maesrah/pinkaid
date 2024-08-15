import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinkaid/features/patientsFeatures/model/doctor_model.dart';


class Api {
  static const baseUrl="http://192.168.68.106/api/";
  var apiUrl = Uri.parse("");
  

  Future<void> createDoctors(List<Doctor> doctors) async {
  var url = Uri.parse("${baseUrl}addDoctors");
  List<Map<String, dynamic>> doctorsJson = doctors.map((doctor) => doctor.toJson()).toList();

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(doctorsJson),
    );

    if (response.statusCode == 200) {
      
      print("Doctors added successfully.");
    } else {
      print("Failed to add doctors. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  } catch (error) {
    print("An error occurred: $error");
  }
}

Future<List<Doctor>> getDoctor() async {
   var url = Uri.parse("${baseUrl}addDoctors");
    // final response =
    //     await http.get(url, headers: {"Content-Type": "application/json"});
    final response = await http.get(url);
    final body = json.decode(response.body);
       final List<dynamic> doctorsList = body['doctorData'];
    return doctorsList.map((e) => Doctor.fromJson(e)).toList();
  }

  



}