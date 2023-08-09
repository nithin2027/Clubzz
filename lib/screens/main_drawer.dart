import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_part_of_app/model/user_model.dart';
import 'package:first_part_of_app/screens/login_screen.dart';
import 'package:first_part_of_app/screens/user_profile.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class MainDrawer extends StatefulWidget {
  String userid;
  String email;
  String firstName;
  String lastName;

  MainDrawer(
      {required this.userid,
      required this.email,
      required this.firstName,
      required this.lastName});

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  // User? user = FirebaseAuth.instance.currentUser;

  // UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();

    setState(() {
      print(widget.email);
      print(widget.firstName);
      print(widget.lastName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Theme.of(context).primaryColor,
          child: Center(
              child: Column(
            children: <Widget>[
              Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"))),
              Text(
                widget.firstName + " " + widget.lastName,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              Text(
                widget.email,
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          )),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
            'profile',
            style: TextStyle(fontSize: 18),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          userid: widget.userid,
                          firstName: widget.firstName,
                          secondName: widget.lastName,
                        )));
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            'Settings',
            style: TextStyle(fontSize: 18),
          ),
          onTap: null,
        ),
        ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              logout(context);
            }),
      ]),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
