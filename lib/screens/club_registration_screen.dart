import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_part_of_app/model/club_model.dart';
import 'package:first_part_of_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreen1 extends StatefulWidget {
  const RegistrationScreen1({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState1 createState() => _RegistrationScreenState1();
}

class _RegistrationScreenState1 extends State<RegistrationScreen1> {
  //our form key
  final _formKey = GlobalKey<FormState>();
  //Auth key
  final _auth = FirebaseAuth.instance;
  //editing controller
  final clubNameEditingController = new TextEditingController();
  final clubManagerEditingController = new TextEditingController();
  final clubLogoEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final clubbioEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    //ClubName
    final clubName = TextFormField(
      autofocus: false,
      controller: clubNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name dont be null");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter valid name(Min. 3 Character");
        }
        return null;
      },
      onSaved: (value) {
        clubNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefix: Icon(Icons.account_circle_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Club Name",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    //ClubManager
    final clubManagerName = TextFormField(
      autofocus: false,
      controller: clubManagerEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name dont be null");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter valid name(Min. 3 Character");
        }
        return null;
      },
      onSaved: (value) {
        clubManagerEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefix: Icon(Icons.account_circle_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Club Head Name",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        return null;
        // reg Expression for email validation
        // if (!RegExp("^[a-zA-Z0-9+_,-]+@[a-zA-Z0-9,-]+,[a-z]").hasMatch(value)) {
        //   return ("Please Enter a valid Email");
        // }
        // return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefix: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    //club bio
    final clubBio = TextFormField(
      autofocus: false,
      controller: clubbioEditingController,
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
        clubbioEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Club Bio',
      ),
      maxLines: 5, // <-- SEE HERE
      minLines: 2, //     minLines: 1,
    );
    //Password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      // keyboardType: TextInputType.emailAddress,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter valid Password(Min. 6 Character");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefix: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    //Confirm Password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefix: Icon(Icons.vpn_lock),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    //SIGN UP BUTTON
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 241, 148, 61),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text(
          "Sign Up",
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
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "Let's SignUp!!",
                      style: TextStyle(
                          color: Color.fromARGB(255, 245, 138, 37),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ]),
                  SizedBox(
                    height: 40,
                  ),
                  clubName,
                  SizedBox(
                    height: 20,
                  ),
                  clubManagerName,
                  SizedBox(
                    height: 20,
                  ),
                  emailField,
                  SizedBox(
                    height: 20,
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
                            referenceRoot.child('ClubLogoPhotos');
                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);
                        try {
                          //Store the file
                          await referenceImageToUpload.putFile(File(file.path));
                          //Success: get the download URL
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } catch (error) {
                          //Some error occurred
                        }
                      },
                      icon: Icon(Icons.camera_alt)),
                  ElevatedButton(
                    onPressed: () async {
                      if (imageUrl.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please upload an image')));

                        return;
                      }
                    },
                    child: Text("Upload"),
                  ),
                  clubBio,
                  SizedBox(
                    height: 20,
                  ),
                  passwordField,
                  SizedBox(
                    height: 20,
                  ),
                  confirmPasswordField,
                  SizedBox(
                    height: 45,
                  ),
                  signUpButton,
                  SizedBox(
                    height: 45,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do you already have an account?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 243, 87, 67),
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Color.fromARGB(255, 236, 120, 43),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //calling firestore

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? club = _auth.currentUser;
    //calling club model
    ClubModel clubModel = new ClubModel();

    clubModel.clubEmail = club!.email;
    clubModel.clubuid = club.uid;
    clubModel.clubName = clubNameEditingController.text;
    clubModel.clubHead = clubManagerEditingController.text;
    clubModel.cTime = Timestamp.now();
    clubModel.clubLogo = imageUrl;
    clubModel.clubBio = clubbioEditingController.text;

    await firebaseFirestore
        .collection("Clubs")
        .doc(club.uid)
        .set(clubModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
}
