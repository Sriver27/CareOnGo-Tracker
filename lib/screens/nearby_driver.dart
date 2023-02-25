import 'dart:math';

import 'package:ambulance_tracker/screens/driver_booking.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NearDriver extends StatefulWidget {
  const NearDriver({Key? key}) : super(key: key);

  @override
  State<NearDriver> createState() => _NearDriverState();
}

String driverName = " ";

class _NearDriverState extends State<NearDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nearby Driver',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please select the driver you require',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // show demo drivers details here in card widgets
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: getNearbyDrivers(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getNearbyDrivers() {
    List<Widget> lst = [];
    for (int i = 1; i <= 4; i++) {
      lst.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height / 7,
            child: Card(
              child: Column(children: [
                Text(
                  "Driver " + i.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(get6DigitNumber()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          driverName = "Driver" + i.toString();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => DriverBooking(
                                  driverName: "Driver" + i.toString())));
                        }),
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Hospital rejected",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }),
                  ],
                )
              ]),
            )),
      ));
    }

    return lst;
  }

  String get6DigitNumber() {
    Random random = Random();
    String number = '';
    for (int i = 0; i < 10; i++) {
      number = number + random.nextInt(9).toString();
    }
    return number;
  }
}
