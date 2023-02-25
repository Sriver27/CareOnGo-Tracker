import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future createData(String collName, docName, name, inc, loc, int age) async {
  await FirebaseFirestore.instance
      .collection(collName)
      .doc(docName)
      .set({'name': name, 'incident': inc, 'location': loc, 'age': age});
  print("Database Updated");
}

Future createDriver(String collName, docName, regid, exp, status) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).set(
      {'name': docName, 'Reg Id': regid, 'experience': exp, 'status': status});
  print("Database Updated");
}

Future instantDriver(
    String collName, docName, name, inc, loc, hospitalName, age) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).set({
    'name': name,
    'Age': age,
    'Incident': inc,
    'Location': loc,
    'Hospital Name': hospitalName
  });
  print("Database Updated");
}
