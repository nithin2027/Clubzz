import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_part_of_app/model/event_register_model.dart';
import 'package:first_part_of_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class registerForEventpage extends StatefulWidget {
  String clubId;
  String eventId;
  String eventName;
  String userId;
  // late String clubId;
  registerForEventpage(
      {required this.userId,
      required this.clubId,
      required this.eventName,
      required this.eventId});
  // required clubId

  @override
  State<registerForEventpage> createState() => _registerForEventpageState();
}

class _registerForEventpageState extends State<registerForEventpage> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController studentNameController = new TextEditingController();
  TextEditingController studentEmailController = new TextEditingController();
  TextEditingController studentPhoneController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    //StudentName
    final studentName = TextFormField(
      autofocus: false,
      controller: studentNameController,
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
        studentNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter your name',
      ),
    );
    //StudentMobileNumber
    final studentPhoneNumber = TextFormField(
      autofocus: false,
      controller: studentPhoneController,
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
        studentPhoneController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter your phone number',
      ),
    );
    //Studnet Email
    final StudentEmail = TextFormField(
      autofocus: false,
      controller: studentEmailController,
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
        studentEmailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter your emailId',
      ),
    );
    //Register Botton
    final registerButton = Material(
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
          "Register",
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
        title: const Text("Register For Event"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.redAccent),
          onPressed: () {
            Navigator.of(context).pop();
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
                      height: 40,
                    ),
                    studentName,
                    SizedBox(
                      height: 40,
                    ),
                    studentPhoneNumber,
                    SizedBox(
                      height: 40,
                    ),
                    StudentEmail,
                    SizedBox(
                      height: 40,
                    ),
                    registerButton,
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

    studentRegistration registerForEvent = new studentRegistration();

    String uniqueRegistrationId =
        DateTime.now().millisecondsSinceEpoch.toString();
    registerForEvent.clubId = widget.clubId;
    registerForEvent.eventId = widget.eventId;
    registerForEvent.userId = widget.userId;
    registerForEvent.userName = studentNameController.text;
    registerForEvent.userEmail = studentEmailController.text;
    registerForEvent.userphone = studentPhoneController.text;
    registerForEvent.eventName = widget.eventName;

    await firebaseFirestore
        .collection("registration")
        .doc(uniqueRegistrationId)
        .set(registerForEvent.toMap());
    Fluttertoast.showToast(
        msg: "You are succesfully registred for the Event!!");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(
            builder: (context) => registerForEventpage(
                eventName: widget.eventName,
                userId: widget.userId,
                clubId: widget.clubId,
                eventId: widget.eventId)),
        (route) => true);
  }
}
