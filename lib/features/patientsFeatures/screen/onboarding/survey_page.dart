import 'package:flutter/material.dart';
import 'package:pinkaid/theme/textheme.dart';

class SurveyOnboardingPage extends StatefulWidget {
  const SurveyOnboardingPage({super.key});

  @override
  State<SurveyOnboardingPage> createState() => _SurveyOnboardingPageState();
}

class _SurveyOnboardingPageState extends State<SurveyOnboardingPage> {
  final _formKey = GlobalKey<FormState>();

  // Section A Variables
  String? _selectedRace;
  String? _selectedEducation;
  bool _hasCancer = false;
  DateTime? _diagnosisDate;
  bool _hasUndergoneTreatment = false;
  List<String> _selectedTreatments = [];
  bool _hasUndergoneScreening = false;
  bool _doesSelfExamination = false;

  // Section B Variables
  bool _hasHospitalAdmissions = false;
  String? _hospitalizationType;

  // Section C Variables
  bool _experiencingBreastLumps = false;
  bool _noticedBreastChanges = false;
  bool _nippleDischarge = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Medical Form'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Section A: Personal & Medical Information
              Text('Section A: Demographic Data',
                  style: KTextTheme.lightTextTheme.headlineSmall),
              const SizedBox(height: 16.0),
              // Race Selection
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Race'),
                value: _selectedRace,
                items: const [
                  DropdownMenuItem(value: 'Malay', child: Text('Malay')),
                  DropdownMenuItem(value: 'Chinese', child: Text('Chinese')),
                  DropdownMenuItem(value: 'Indian', child: Text('Indian')),
                  DropdownMenuItem(value: 'Others', child: Text('Others')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRace = value;
                  });
                },
                validator: (value) => value == null ? 'Please select your race' : null,
              ),
              const SizedBox(height: 16.0),
              // Education Level Selection
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Education Level'),
                value: _selectedEducation,
                items: const [
                  DropdownMenuItem(value: 'Degree', child: Text('Degree')),
                  DropdownMenuItem(value: 'Diploma', child: Text('Diploma')),
                  DropdownMenuItem(value: 'Secondary School', child: Text('Secondary School')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedEducation = value;
                  });
                },
                validator: (value) => value == null ? 'Please select your education level' : null,
              ),
              const SizedBox(height: 16.0),
              // Cancer Diagnosis
              CheckboxListTile(
                title: const Text('Have you been diagnosed with cancer before?'),
                value: _hasCancer,
                onChanged: (value) {
                  setState(() {
                    _hasCancer = value!;
                  });
                },
              ),
              if (_hasCancer) ...[
                // Date of Diagnosis
                ListTile(
                  title: const Text('When were you diagnosed?'),
                  subtitle: _diagnosisDate == null
                      ? const Text('Select Date')
                      : Text('${_diagnosisDate?.toLocal()}'.split(' ')[0]),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _diagnosisDate = picked;
                      });
                    }
                  },
                ),
                // Treatment Undergoing
                CheckboxListTile(
                  title: const Text('Have you undergone any treatment?'),
                  value: _hasUndergoneTreatment,
                  onChanged: (value) {
                    setState(() {
                      _hasUndergoneTreatment = value!;
                    });
                  },
                ),
                if (_hasUndergoneTreatment) ...[
                  // Type of Treatment
                  CheckboxListTile(
                    title: const Text('Chemotherapy'),
                    value: _selectedTreatments.contains('Chemotherapy'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _selectedTreatments.add('Chemotherapy');
                        } else {
                          _selectedTreatments.remove('Chemotherapy');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Radiotherapy'),
                    value: _selectedTreatments.contains('Radiotherapy'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _selectedTreatments.add('Radiotherapy');
                        } else {
                          _selectedTreatments.remove('Radiotherapy');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Surgery'),
                    value: _selectedTreatments.contains('Surgery'),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _selectedTreatments.add('Surgery');
                        } else {
                          _selectedTreatments.remove('Surgery');
                        }
                      });
                    },
                  ),
                ],
              ],
              // Breast Cancer Screening
              CheckboxListTile(
                title: const Text('Have you undergone any breast cancer screening?'),
                value: _hasUndergoneScreening,
                onChanged: (value) {
                  setState(() {
                    _hasUndergoneScreening = value!;
                  });
                },
              ),
              // Breast Self-Examination
              CheckboxListTile(
                title: const Text('Do you engage in regular breast self-examination?'),
                value: _doesSelfExamination,
                onChanged: (value) {
                  setState(() {
                    _doesSelfExamination = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Section B: History of Admissions
              const Text('Section B: History of Admissions',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16.0),
              // History of Admissions
              CheckboxListTile(
                title: const Text('Have you been hospitalized before?'),
                value: _hasHospitalAdmissions,
                onChanged: (value) {
                  setState(() {
                    _hasHospitalAdmissions = value!;
                  });
                },
              ),
              if (_hasHospitalAdmissions) ...[
                // Type of Hospitalization
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Type of Hospitalization'),
                  value: _hospitalizationType,
                  items: const [
                    DropdownMenuItem(value: '5 days', child: Text('5 days')),
                    DropdownMenuItem(value: '6-10 days', child: Text('6-10 days')),
                    DropdownMenuItem(value: 'More than 10 days', child: Text('More than 10 days')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _hospitalizationType = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select the type of hospitalization' : null,
                ),
              ],
              const SizedBox(height: 16.0),

              // Section C: Breast Health
              const Text('Section C: Breast Health',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16.0),
              // Breast Lumps
              CheckboxListTile(
                title: const Text('Are you experiencing breast lumps?'),
                value: _experiencingBreastLumps,
                onChanged: (value) {
                  setState(() {
                    _experiencingBreastLumps = value!;
                  });
                },
              ),
              // Breast Changes
              CheckboxListTile(
                title: const Text('Have you noticed any changes to your breast?'),
                value: _noticedBreastChanges,
                onChanged: (value) {
                  setState(() {
                    _noticedBreastChanges = value!;
                  });
                },
              ),
              // Nipple Discharge
              CheckboxListTile(
                title: const Text('Do you have any nipple discharge?'),
                value: _nippleDischarge,
                onChanged: (value) {
                  setState(() {
                    _nippleDischarge = value!;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    print('Form Submitted');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }}