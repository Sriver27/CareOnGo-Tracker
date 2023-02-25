import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future createData(String collName, docName, name, inc, loc, int age) async {
  await FirebaseFirestore.instance
      .collection(collName)
      .doc(docName)
      .set({'name': name, 'incident': inc, 'location': loc, 'age': age});
  print("Database Updated");
}
