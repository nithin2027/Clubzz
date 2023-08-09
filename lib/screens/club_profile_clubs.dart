import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_part_of_app/model/club_model.dart';
import 'package:first_part_of_app/screens/createEvent.dart';
import 'package:first_part_of_app/screens/show_created_events_clubs.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class ClubDetailPageClubs extends StatefulWidget {
  String club;
  ClubDetailPageClubs({required this.club});

  @override
  State<ClubDetailPageClubs> createState() => _ClubDetailPageStateClubs();
}

class _ClubDetailPageStateClubs extends State<ClubDetailPageClubs> {
  User? user = FirebaseAuth.instance.currentUser;

  ClubModel loggedInClub = ClubModel();

  @override
  void initState() {
    // print("UserId" + user!.uid);
    super.initState();
    _firestore.collection("Clubs").doc(widget.club).get().then((value) {
      this.loggedInClub = ClubModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final createEvent = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 241, 148, 61),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          // signIn(emailController.text, passwordController.text);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      createEventpage(clubuid: widget.club.toString())));
        },
        child: Text(
          "Create Event",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 216, 69, 50),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    final showOnGoingEvents = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 241, 148, 61),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          // signIn(emailController.text, passwordController.text);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      eventShower(clubuid: widget.club.toString())));
        },
        child: Text(
          "Ongoing Event",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 216, 69, 50),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Club Details"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.logout_outlined),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: 200,
                      width: 200,
                      // gs://clubzz-login.appspot.com/ClubLogoPhotos/1673359702740
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset('assets/${widget.club}.png'))),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${loggedInClub.clubName}',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Club Head :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 0, 16, 16),
                        child: Text(
                          '${loggedInClub.clubHead}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            // color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Contact us :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(1.0, 0, 16, 16),
                        child: Text(
                          '${loggedInClub.clubEmail}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            // color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bio",
                        style: TextStyle(
                          color: Color.fromARGB(255, 14, 1, 1),
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${loggedInClub.clubBio}',
                        // 'My name is Natasha and I am  a freelance mobile app developper.\n'
                        // 'Having Experiece in Flutter and Android',
                        style: TextStyle(
                          fontSize: 18.0,
                          // fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),

                  const Divider(),
                  createEvent,
                  // SizedBox(
                  //   height: 30,
                  // ),
                  const Divider(),
                  const Center(
                      child: Text(
                    'Ongoing Events',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
                  showOnGoingEvents,
                  // for (int i = 0; i < 3; i++)
                  //   GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => StudentInfoPage()));
                  //     },
                  //     // Fluttertoast.showToast(msg: "This is tapped")),
                  //     child: Card(
                  //       margin: const EdgeInsets.symmetric(vertical: 20),
                  //       elevation: 4,
                  //       color: Colors.white,
                  //       shape: const RoundedRectangleBorder(
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(10))),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(0),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.stretch,
                  //           children: <Widget>[
                  //             ClipRRect(
                  //               child: Image.network(
                  //                 'http://www.violetqa.com/images/Live-Events-image%20(1).jpeg',
                  //                 height: 150,
                  //                 fit: BoxFit.fitWidth,
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.only(top: 8.0, left: 8.0),
                  //               child: Row(
                  //                 children: <Widget>[
                  //                   Expanded(
                  //                     flex: 3,
                  //                     child: Row(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: const <Widget>[
                  //                         Text(
                  //                           "Music",
                  //                         ),
                  //                         Spacer(),
                  //                         Text(
                  //                           "location",
                  //                         ),
                  //                         Spacer(),
                  //                         Text(
                  //                           "duration",
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class EventsStream extends StatelessWidget {
//   EventsStream({required this.clubuid});
//   String clubuid;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: _firestore
//             .collection("Clubs")
//             .doc(clubuid)
//             .collection("Events")
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.data != null) {
//             final events = snapshot.data?.docs;
//             List<ListEvent> messagesWidgets = [];}
//           return Scaffold(
//             for (var event in events!) {
//               final eventName = event['eventName'];
//               final eventDate = event['eventDate'];
//               final eventTime = event['eventTime'];
//               final eventVenue = event['eventVenue'];
//               final eventLogo = event['eventLogo'];
//               child: Expanded(
//                 child: ListView(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 10.0, vertical: 20.0),
//                   children: messagesWidgets,
//                 ),
//               );
//             }
//           );
//         });
//   }
// }

// class ListEvent extends StatelessWidget {
//   ListEvent(
//       {required this.eventName,
//       required this.eventDate,
//       required this.eventTime,
//       required this.eventVenue,
//       required this.eventLogo});

//   String eventName;
//   String eventDate;
//   String eventTime;
//   String eventVenue;
//   String eventLogo;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Container(
//         color: Colors.transparent,
//         margin: EdgeInsets.all(12.0),
//         padding: EdgeInsets.all(8.0),
//         child: Padding(
//           padding: EdgeInsets.all(3.0),
//           child: Material(
//             color: Colors.grey.withOpacity(0.7),
//             borderRadius: BorderRadius.circular(10.0),
//             child: Container(
//               color: Colors.transparent,
//               margin: EdgeInsets.all(12.0),
//               child: ExpansionTile(
//                 initiallyExpanded: false,
//                 childrenPadding: EdgeInsets.all(12.0),
//                 // trailing: Icon(
//                 //   // FontAwesomeIcons.eye,
//                 //   color: Colors.black,
//                 // ),
//                 backgroundColor: Colors.transparent,
//                 title: Text(
//                   eventName,
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 25.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 children: [
//                   Text(
//                     eventDate,
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.w400),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 10.0),
//                     child: Material(
//                       elevation: 5.0,
//                       color: Colors.blue.withOpacity(0.6),
//                       borderRadius: BorderRadius.circular(15.0),
//                       child: MaterialButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => registerForEventpage(
//                                 clubId: "clubid",
//                               ),
//                             ),
//                           );
//                         },
//                         minWidth: 80.0,
//                         height: 42.0,
//                         child: Text(
//                           "View",
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
