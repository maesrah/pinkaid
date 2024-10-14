import 'package:flutter/material.dart';



class SurveyForm extends StatefulWidget {
  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
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
      appBar: AppBar(title: Text('Health Survey Form')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Section A: Personal & Medical Information
              Text('Section A: Personal & Medical Information',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 16.0),
              // Race Selection
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Race'),
                value: _selectedRace,
                items: [
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
              SizedBox(height: 16.0),
              // Education Level Selection
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Education Level'),
                value: _selectedEducation,
                items: [
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
              SizedBox(height: 16.0),
              // Cancer Diagnosis
              CheckboxListTile(
                title: Text('Have you been diagnosed with cancer before?'),
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
                  title: Text('When were you diagnosed?'),
                  subtitle: _diagnosisDate == null
                      ? Text('Select Date')
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
                  title: Text('Have you undergone any treatment?'),
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
                    title: Text('Chemotherapy'),
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
                    title: Text('Radiotherapy'),
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
                    title: Text('Surgery'),
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
                title: Text('Have you undergone any breast cancer screening?'),
                value: _hasUndergoneScreening,
                onChanged: (value) {
                  setState(() {
                    _hasUndergoneScreening = value!;
                  });
                },
              ),
              // Breast Self-Examination
              CheckboxListTile(
                title: Text('Do you engage in regular breast self-examination?'),
                value: _doesSelfExamination,
                onChanged: (value) {
                  setState(() {
                    _doesSelfExamination = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),

              // Section B: History of Admissions
              Text('Section B: History of Admissions',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 16.0),
              // History of Admissions
              CheckboxListTile(
                title: Text('Have you been hospitalized before?'),
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
                  decoration: InputDecoration(labelText: 'Type of Hospitalization'),
                  value: _hospitalizationType,
                  items: [
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
              SizedBox(height: 16.0),

              // Section C: Breast Health
              Text('Section C: Breast Health',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 16.0),
              // Breast Lumps
              CheckboxListTile(
                title: Text('Are you experiencing breast lumps?'),
                value: _experiencingBreastLumps,
                onChanged: (value) {
                  setState(() {
                    _experiencingBreastLumps = value!;
                  });
                },
              ),
              // Breast Changes
              CheckboxListTile(
                title: Text('Have you noticed any changes to your breast?'),
                value: _noticedBreastChanges,
                onChanged: (value) {
                  setState(() {
                    _noticedBreastChanges = value!;
                  });
                },
              ),
              // Nipple Discharge
              CheckboxListTile(
                title: Text('Do you have any nipple discharge?'),
                value: _nippleDischarge,
                onChanged: (value) {
                  setState(() {
                    _nippleDischarge = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    print('Form Submitted');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
