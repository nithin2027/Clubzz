import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_part_of_app/model/user_model.dart';
import 'package:first_part_of_app/screens/button_container.dart';
import 'package:first_part_of_app/screens/club_profile_user.dart';
import 'package:first_part_of_app/screens/login_screen.dart';
import 'package:first_part_of_app/screens/main_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      setState(() {
        print(loggedInUser);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 252, 227, 158),
        appBar: AppBar(
          title: Text("Wel come"),
          centerTitle: true,
        ),
        drawer: MainDrawer(
            userid: loggedInUser.uid.toString(),
            email: loggedInUser.email.toString(),
            firstName: loggedInUser.firstName.toString(),
            lastName: loggedInUser.lastName.toString()),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              child: Text(
                'BMSCE CLUBS',
                style: TextStyle(
                  color: Colors.black,
                  height: 2,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ButtonContainer(
                    club: 'Codeio',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClubDetailPage(
                              club: 'codeio',
                              userId: loggedInUser.uid.toString(),
                            ),
                          ));
                    },
                  ),
                ),
                Expanded(
                    child: ButtonContainer(
                  club: 'Protocol',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClubDetailPage(
                            club: 'protocol',
                            userId: loggedInUser.uid.toString(),
                          ),
                        ));
                  },
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ButtonContainer(
                    club: 'IEEE',
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => ClubDetailPage(
                      //         club: 'IEEE',
                      //         clubName: "IEEE",
                      //       ),
                      //     ));
                    },
                  ),
                ),
                Expanded(
                  child: ButtonContainer(
                    club: 'NCC',
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => ClubDetailPage(
                      //         club: 'ML',
                      //         clubName: "Machine Learning Engg",
                      //       ),
                      //     ));
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ButtonContainer(
                    club: 'NSS',
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => ClubDetailPage(
                      //         club: 'ME',
                      //         clubName: "Mechanical Science & Engg",
                      //       ),
                      //     ));
                    },
                  ),
                ),
                Expanded(
                  child: ButtonContainer(
                    club: 'Robotics',
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => ClubDetailPage(
                      //         club: 'Robo',
                      //         clubName: "Robotics",
                      //       ),
                      //     ));
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ButtonContainer(
                    club: 'ಚಿರಂತನ',
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: ButtonContainer(
                    club: 'Sports',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        )));
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
