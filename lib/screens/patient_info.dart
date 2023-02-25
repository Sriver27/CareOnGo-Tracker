import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PatientInfoPage extends StatefulWidget {
  const PatientInfoPage({Key? key}) : super(key: key);

  @override
  _PatientInfoPageState createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _incidentController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _incidentController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Information'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _incidentController,
              decoration: InputDecoration(
                labelText: 'Incident',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Send action
                final name = _nameController.text;
                final age = int.tryParse(_ageController.text);
                final incident = _incidentController.text;
                final location = _locationController.text;

                if (name.isNotEmpty &&
                    age != null &&
                    age > 0 &&
                    location.isNotEmpty &&
                    incident.isNotEmpty) {
                  // Do something with the data
                  Fluttertoast.showToast(
                      msg:
                          "Patient Name = $name, Patient Age = $age, Incident Detail = $incident, Location = $location",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  Navigator.pop(context, {'name': name, 'age': age});
                }
              },
              child: Text('Send'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Cancel action
                Navigator.pop(context, null);
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
