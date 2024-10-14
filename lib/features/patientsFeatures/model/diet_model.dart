

class PatientHealth{
  String patientId;
  double weight; // in kilograms
  double height; // in meters
  double get bmi => weight / (height * height); // BMI calculation
  int dailySleepHours; // Sleep hours per day

  // Meals: List of meals for Breakfast, Lunch, Dinner, and Snacks
  List<String> breakfastMeals;
  List<String> lunchMeals;
  List<String> dinnerMeals;
  List<String> snacksMeals;

  // List of exercises performed by the patient today
  List<String> dailyExercises;

  String dailySymptom; // Symptoms experienced today
  List<String> medications; // List of medications to be taken

  PatientHealth({
    required this.patientId,
    required this.weight,
    required this.height,
    required this.dailySleepHours,
    required this.breakfastMeals,
    required this.lunchMeals,
    required this.dinnerMeals,
    required this.snacksMeals,
    required this.dailyExercises,
    required this.dailySymptom,
    required this.medications,
  });

  // Convert a PatientHealth object to JSON
    Map<String, dynamic> toJson() {
    return {
      'id': patientId,
      'weight': weight,
      'height': height,
      'bmi': bmi, // Automatically calculated BMI
      'dailySleepHours': dailySleepHours,
      'breakfastMeals': breakfastMeals,
      'lunchMeals': lunchMeals,
      'dinnerMeals': dinnerMeals,
      'snacksMeals': snacksMeals,
      'dailyExercises': dailyExercises,
      'dailySymptom': dailySymptom,
      'medications': medications,
    };
  
    
  }

  // Create a PatientHealth object from JSON
  factory PatientHealth.fromJson(Map<String, dynamic> json) {
    return PatientHealth(
      patientId: json['patientId'],
      weight: json['weight'],
      height: json['height'],
      dailySleepHours: json['dailySleepHours'],
      breakfastMeals: List<String>.from(json['breakfastMeals']),
      lunchMeals: List<String>.from(json['lunchMeals']),
      dinnerMeals: List<String>.from(json['dinnerMeals']),
      snacksMeals: List<String>.from(json['snacksMeals']),
      dailyExercises: List<String>.from(json['dailyExercises']),
      dailySymptom: json['dailySymptom'],
      medications: List<String>.from(json['medications']),
    );
  }
}
