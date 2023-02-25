import 'dart:convert';
import 'package:ambulance_tracker/screens/patient_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Patient Severity Chatbot',
//       home: PatientChatbot(),
//     );
//   }
// }

class PatientChatbot extends StatefulWidget {
  @override
  _PatientChatbotState createState() => _PatientChatbotState();
}

class _PatientChatbotState extends State<PatientChatbot> {
  final apiKey = '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';
  final List<String> questions = [
    "Is there heavy bleeding or severe pain?",
    "Are you experiencing any chest pain ?",
    "Are you experiencing shortness of breath?",
    "Do you have a history of heart disease or stroke?",
    "Are you feeling unconscious or fainting?",
    "Is the patient able to walk or do they require assistance?",
  ];
  int questionIndex = 0;
  Map<String, String> answers = {};

  Future<String> getSeverity(String question, String answer) async {
    var url = 'https://api.openai.com/v1/engines/davinci-codex/completions';
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': apiKey,
      },
      body: jsonEncode({
        'prompt': '$question\nAnswer: $answer\nSeverity:',
        'max_tokens': 1,
        'temperature': 0.5,
      }),
    );
    var responseJson = json.decode(response.body);
    return responseJson['choices'][0]['text'];
  }

  void _submitAnswer(String answer) {
    setState(() {
      answers[questions[questionIndex]] = answer;
      questionIndex++;
    });
    if (questionIndex == questions.length) {
      _showSeverity();
    }
  }

  void _showSeverity() async {
    String severity = '';
    int point = 0;
    for (int i = 0; i < answers.length; i++) {
      if (answers[questions[i]] == 'Yes') {
        point += 1;
      }
    }
    double percentage = point / answers.length * 100;
    if (percentage >= 0 && percentage <= 33) {
      severity = 'Mild';
    } else if (percentage > 33 && percentage <= 66) {
      severity = 'Moderate';
    } else if (percentage > 66 && percentage <= 100) {
      severity = 'Severe';
    }
    String advice;
    if (severity == 'Mild') {
      advice = 'You should try some home remedies.';
    } else if (severity == 'Moderate') {
      advice = 'You should see a doctor.';
    } else if (severity == 'Severe') {
      advice = 'You should go to the emergency room.';
    } else {
      advice = 'Sorry, we were unable to determine your severity.';
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Severity Detected: $severity'),
            content: Text(advice),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PatientInfoPage(
                            hospitalName: 'Hospital 1',
                          )));
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Severity Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: questions.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(16.0),
          //         child: Text(
          //           questions[index],
          //           style: TextStyle(fontSize: 18.0),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: answers.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(16.0),
          //         child: Text(
          //           answers[questions[index]]!,
          //           style: TextStyle(fontSize: 18.0),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    questionIndex < questions.length
                        ? questions[questionIndex]
                        : 'Thank you for your answers!',
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        child: Text('Yes'),
                        onPressed: () {
                          _submitAnswer('Yes');
                        },
                      ),
                      ElevatedButton(
                        child: Text('No'),
                        onPressed: () {
                          _submitAnswer('No');
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
