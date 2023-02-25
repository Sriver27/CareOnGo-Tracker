import 'package:ambulance_tracker/screens/new_driver_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'all_drivers.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({Key? key}) : super(key: key);

  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Color.fromRGBO(143, 148, 251, 0.75),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: RichText(
                              text: TextSpan(
                                  text:
                                      "Hospital Dashboard         ", //let the spaces be for alignment
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Container(
                        height: 250,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Hospital')
                              .snapshots(),
                          builder: (context, patientSnapshot) {
                            if (patientSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              final patientDocs = patientSnapshot.data!.docs;
                              return ListView.builder(
                                  itemCount: patientDocs.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Text(
                                            "You have ${patientDocs.length} no of patients"),
                                        Card(
                                          elevation: 10,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: SizedBox(
                                              width: 200,
                                              child: Column(children: [
                                                Text(
                                                    " Name : ${patientDocs[index]['name']}"),
                                                Text(
                                                    "Location : ${patientDocs[index]['location']}"),
                                                Text(
                                                    "Incident : ${patientDocs[index]['incident']}"),
                                                // Text(petDocs[index]['age']),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                  maxHeight: double.maxFinite,
                ),
                child: Container(
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 0.0,
                        offset: Offset(
                            -1.0, -1.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: new SingleChildScrollView(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        Container(
                          height: 250,
                          child: PageView(
                            controller: PageController(
                                viewportFraction: 1, initialPage: 1),
                            scrollDirection: Axis.horizontal,
                            pageSnapping: false,
                            children: <Widget>[
                              _buildItemCard(
                                  title: "Drivers Status",
                                  total: "Total: 11",
                                  totalNum: 11,
                                  color: Colors.blue,
                                  icon: FontAwesomeIcons.addressCard,
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShowDrivers()),
                                      )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemCard(
      {required String title,
      String? total,
      required int totalNum,
      Color? color,
      IconData? icon,
      GestureTapCallback? onTap}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                children: [
                  WidgetSpan(
                      child: FaIcon(
                    icon,
                    color: color,
                    size: 40,
                  )),
                ],
              )),
              SizedBox(height: 25),
              RichText(
                  text: TextSpan(
                      text: title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ))),
              SizedBox(height: 20),
              Divider(
                thickness: 1,
              ),
              RichText(
                  text: TextSpan(
                      text: total,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ))),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestsCard({
    required String title,
    String? subject,
    required String text,
    required Image image,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text: subject,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text: text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
