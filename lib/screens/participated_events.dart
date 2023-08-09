import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class participatedInfoPage extends StatefulWidget {
  String userid;
  participatedInfoPage({required this.userid});

  @override
  State<participatedInfoPage> createState() => _participatedInfoPageState();
}

class _participatedInfoPageState extends State<participatedInfoPage> {
  List registeredStudents = [];

  @override
  void initState() {
    super.initState();
    final Query<Map<String, dynamic>> StudentsReference = FirebaseFirestore
        .instance
        .collection("registration")
        .where("userId", isEqualTo: widget.userid);

    StudentsReference.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          registeredStudents.add(doc);
        });
      }
      print(registeredStudents);
      print(registeredStudents.length);
      if (registeredStudents.isEmpty) {
        Fluttertoast.showToast(msg: "No Registration");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int count = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registered Events Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(38.0),
              child: Text(
                "Hey User",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: DataTable(
                        columns: const [
                          DataColumn(
                              label: Text(
                            'ID',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 20, 114, 221)),
                          )),
                          DataColumn(
                              label: Text(
                            'Club Name',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 20, 114, 221)),
                          )),
                          DataColumn(
                              label: Text(
                            'Event Name',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 20, 114, 221)),
                          )),
                        ],
                        rows: registeredStudents
                            .map((e) => DataRow(cells: [
                                  DataCell(Text((count++).toString())),
                                  DataCell(Text(e["clubId"])),
                                  DataCell(Text(e["eventName"])),
                                ]))
                            .toList(),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
