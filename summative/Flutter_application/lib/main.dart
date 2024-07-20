import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Performance Predictor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PredictionPage(),
    );
  }
}

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _hoursStudiedController = TextEditingController();
  final TextEditingController _previousScoresController = TextEditingController();
  final TextEditingController _sleepHoursController = TextEditingController();
  final TextEditingController _sampleQuestionPapersPracticedController = TextEditingController();

  // Dropdown for extracurricular activities
  String _extracurricularActivities = 'No'; // Default value

  // Dropdown for additional resources (for demonstration purposes)


  String _predictionResult = '';

  Future<void> _predictPerformance() async {
  if (_formKey.currentState!.validate()) {
    try {
      // Log the input data to the console
      print('Hours Studied: ${_hoursStudiedController.text}');
      print('Previous Scores: ${_previousScoresController.text}');
      print('Extracurricular Activities: $_extracurricularActivities');
      print('Sleep Hours: ${_sleepHoursController.text}');
      print('Sample Question Papers Practiced: ${_sampleQuestionPapersPracticedController.text}');

      final response = await http.post(
        Uri.parse('https://api-lt34.onrender.com/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'HoursStudied': int.parse(_hoursStudiedController.text),
          'PreviousScores': int.parse(_previousScoresController.text),
          'ExtracurricularActivities': _extracurricularActivities == 'Yes' ? 1 : 0, 
          'SleepHours': int.parse(_sleepHoursController.text),
          'SampleQuestionPapersPracticed': int.parse(_sampleQuestionPapersPracticedController.text),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _predictionResult = 'Predicted Performance Index: ${data['prediction']}';
        });
      } else {
        print('Failed to get prediction: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Performance Predictor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _hoursStudiedController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Hours Studied'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter hours studied';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _previousScoresController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Previous Scores'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter previous scores';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _extracurricularActivities,
                decoration: InputDecoration(labelText: 'Extracurricular Activities'),
                onChanged: (String? newValue) {
                  setState(() {
                    _extracurricularActivities = newValue!;
                  });
                },
                items: <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: _sleepHoursController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Sleep Hours'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sleep hours';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sampleQuestionPapersPracticedController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Sample Question Papers Practiced'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter sample question papers practiced';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
            
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _predictPerformance,
                child: Text('Predict'),
              ),
              SizedBox(height: 20),
              Text(
                _predictionResult,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
