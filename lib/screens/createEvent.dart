import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:first_part_of_app/model/createEvent_model.dart';
import 'package:first_part_of_app/screens/club_profile_clubs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class createEventpage extends StatefulWidget {
  String clubuid;
  createEventpage({required this.clubuid});

  @override
  State<createEventpage> createState() => _createEventpageState();
}

class _createEventpageState extends State<createEventpage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController eventNameController = new TextEditingController();
  TextEditingController eventVenueController = new TextEditingController();
  TextEditingController dateInputController = new TextEditingController();
  TextEditingController eventCategoryController = new TextEditingController();
  TextEditingController eventDiscriptionController =
      new TextEditingController();
  TextEditingController timeInputController = new TextEditingController();
  String posterUrl = ' ';

  @override
  Widget build(BuildContext context) {
    //Event Name
    final eventName = TextFormField(
      autofocus: false,
      controller: eventNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Event Name dont be null");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter valid name(Min. 3 Character");
        }
        return null;
      },
      onSaved: (value) {
        eventNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter event name',
      ),
    );
    //Event Venue
    final eventVenue = TextFormField(
      autofocus: false,
      controller: eventVenueController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Event Name dont be null");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter valid name(Min. 3 Character");
        }
        return null;
      },
      onSaved: (value) {
        eventVenueController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter event venue',
      ),
    );
    //Event Category
    final eventCategory = TextFormField(
      autofocus: false,
      controller: eventCategoryController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Event Name dont be null");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter valid name(Min. 3 Character");
        }
        return null;
      },
      onSaved: (value) {
        eventCategoryController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter event category',
      ),
    );
    //Event Discription
    final eventDiscription = TextFormField(
      autofocus: false,
      controller: eventDiscriptionController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Event Name dont be null");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter valid name(Min. 3 Character");
        }
        return null;
      },
      onSaved: (value) {
        eventDiscriptionController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter event discription',
      ),
      maxLines: 5, // <-- SEE HERE
      minLines: 2, //     minLines: 1,
    );
    //Create botton
    final createButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 241, 148, 61),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          postDetailsToFireStore();
        },
        child: Text(
          "Create",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 216, 69, 50),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 227, 158),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.clubuid),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.redAccent),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ClubDetailPageClubs(
                          club: widget.clubuid.toString(),
                        )));
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    eventName,
                    SizedBox(
                      height: 40,
                    ),
                    eventVenue,
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Date',
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                        ),
                        controller: dateInputController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2050));

                          if (pickedDate != null) {
                            dateInputController.text = pickedDate.toString();
                          }
                          if (pickedDate != null) {
                            dateInputController.text =
                                DateFormat('dd MMMM yyyy').format(pickedDate);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Time',
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                        ),
                        controller: timeInputController,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              timeInputController.text =
                                  formattedTime; //set the value of text field.
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    IconButton(
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? file = await imagePicker.pickImage(
                              source: ImageSource.gallery);

                          if (file == null) return;
                          String uniqueFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('EventPoster');
                          Reference referenceImageToUpload =
                              referenceDirImages.child(uniqueFileName);
                          try {
                            //Store the file
                            await referenceImageToUpload
                                .putFile(File(file.path));
                            //Success: get the download URL
                            posterUrl =
                                await referenceImageToUpload.getDownloadURL();
                          } catch (error) {
                            //Some error occurred
                          }
                        },
                        icon: Icon(Icons.camera_alt)),
                    ElevatedButton(
                      onPressed: () async {
                        if (posterUrl.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please upload an image')));

                          return;
                        }
                      },
                      child: Text("Upload"),
                    ),
                    eventCategory,
                    SizedBox(
                      height: 40,
                    ),
                    eventDiscription,
                    SizedBox(
                      height: 40,
                    ),
                    createButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFireStore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    creatEventModel createEvent = creatEventModel();

    String uniqueEventId = DateTime.now().millisecondsSinceEpoch.toString();
    createEvent.eventid = uniqueEventId;
    createEvent.eventName = eventNameController.text;
    createEvent.eventVenue = eventVenueController.text;
    createEvent.eventCat = eventCategoryController.text;
    createEvent.eventDisc = eventDiscriptionController.text;
    createEvent.eventTime = timeInputController.text;
    createEvent.eventDate = dateInputController.text;
    createEvent.eventLogo = posterUrl;

    await firebaseFirestore
        .collection("Clubs")
        .doc(widget.clubuid)
        .collection("Events")
        .doc(uniqueEventId)
        .set(createEvent.toMap());
    Fluttertoast.showToast(msg: "Event added successfully");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(
            builder: (context) => createEventpage(clubuid: widget.clubuid)),
        (route) => false);
  }
}
