import 'package:ambulance_tracker/screens/nearby_driver.dart';
import 'package:ambulance_tracker/screens/patient_page.dart';
import 'package:flutter/material.dart';

class ServiceRequired extends StatelessWidget {
  const ServiceRequired({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //add two buttons here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Service Required',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please select the service you require',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => PatientPage()));
              },
              child: Text('Hospital'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => NearDriver()));
              },
              child: Text('Driver'),
            ),
          ],
        ),
      ),
    );
  }
}
