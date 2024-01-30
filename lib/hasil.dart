import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultPage extends StatefulWidget {
  final File imageFile;

  ResultPage({required this.imageFile});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int _currentIndex = 1;
  String? woundType = '';
  String? answerQuestion1;
  String? answerQuestion2;
  String? question1Text = 'Pertanyaan 1';
  String? question2Text = 'Pertanyaan 2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Prediksi'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Image.file(
                  widget.imageFile,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Jenis Luka: $woundType',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      woundType = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Ini Prediksi',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Question 1
              Container(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(question1Text ?? 'Pertanyaan 1'),
                    DropdownButton<String>(
                      value: answerQuestion1,
                      items: <String>['Iya', 'Tidak'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          answerQuestion1 = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Question 2
              Container(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(question2Text ?? 'Pertanyaan 2'),
                    DropdownButton<String>(
                      value: answerQuestion2,
                      items: <String>['Iya', 'Tidak'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          answerQuestion2 = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _fetchWoundPrediction();
                  _sendUserInput();
                  _navigateToTreatmentPage();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text('Selanjutnya'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        iconSize: 35,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            Navigator.pushNamed(context, '/dashboard');
          } else if (index == 1) {
            // Navigator.pushNamed(context, '/scan');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/chatbot');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat), // Change the icon to a chat icon
            label: 'Chatbot', // Change the label to 'Chatbot'
          ),
        ],
      ),
    );
  }

  void _fetchWoundPrediction() async {
    try {
      final response = await http.get(Uri.parse('https://example.com/api/predict-wound'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          woundType = data['predictedWoundType'];
          _setQuestionsByWoundType(woundType);
        });
      } else {
        throw Exception('Failed to fetch wound prediction');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _setQuestionsByWoundType(String? detectedWoundType) {
    switch (detectedWoundType) {
      case 'Luka tusuk':
        setState(() {
          question1Text = 'Apakah material penusuk berkarat?';
          question2Text = 'Apakah ada material tertinggal didalam?';
        });
        break;
      case 'Luka sayat':
        setState(() {
          question1Text = 'Apakah luka menembus jaringan epidermis?';
          question2Text = 'Apakah ada material tertinggal?';
        });
        break;
      case 'Luka gores':
        setState(() {
          question1Text = 'Apakah terdapat kotoran menempel pada luka?';
          question2Text = 'Apakah luka gores berdiameter besar?';
        });
        break;
      case 'Luka bakar':
        setState(() {
          question1Text = 'Apakah luka bakar terjadi pada daerah indra?';
          question2Text = 'Apakah luka bakar besar?';
        });
        break;
      default:
      // Handle other cases or set default questions
        break;
    }
  }

  void _sendUserInput() async {
    try {
      final response = await http.post(
        Uri.parse('https://example.com/api/send-user-input'),
        body: {
          'woundType': woundType ?? '',
          'answerQuestion1': answerQuestion1 ?? '',
          'answerQuestion2': answerQuestion2 ?? '',
        },
      );

      if (response.statusCode == 200) {
        print('User input sent successfully');
        _getMedicationRecommendation();
      } else {
        throw Exception('Failed to send user input');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _getMedicationRecommendation() async {
    try {
      final response = await http.post(
        Uri.parse('https://example.com/api/get-medication-recommendation'),
        body: {
          'woundType': woundType ?? '',
          'answerQuestion1': answerQuestion1 ?? '',
          'answerQuestion2': answerQuestion2 ?? '',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Medication recommendation: ${data['medication']}');
      } else {
        throw Exception('Failed to get medication recommendation');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _navigateToTreatmentPage() {
    Navigator.pushNamed(context, '/perawatan');
  }
}