import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_part_of_app/model/club_model.dart';
import 'package:first_part_of_app/screens/show_created_events_user.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class ClubDetailPage extends StatefulWidget {
  String userId;
  String club;
  ClubDetailPage({required this.userId, required this.club});

  @override
  State<ClubDetailPage> createState() => _ClubDetailPageState();
}

class _ClubDetailPageState extends State<ClubDetailPage> {
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
    final showEvent = Row(
      children: <Widget>[
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(30),
          color: Color.fromARGB(255, 241, 148, 61),
          child: MaterialButton(
            padding: EdgeInsets.fromLTRB(5, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width - 64,
            onPressed: () {
              // signIn(emailController.text, passwordController.text);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => eventShowerUser(
                          clubuid: widget.club.toString(),
                          userid: widget.userId.toString())));
            },
            child: Text(
              "showEvents",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 216, 69, 50),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Club Details"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.redAccent),
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
                  // const Center(
                  //   child: CircleAvatar(
                  //     backgroundImage: NetworkImage('${loggedInClub.clubLogo}'),
                  //     radius: 70.0,
                  //   ),
                  // ),
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

                  // const Divider(),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  const Divider(),
                  const Center(
                      child: Text(
                    'Ongoing Events',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
                  showEvent,
                  // EventsStream(clubuid: loggedInClub.clubuid.toString()),
                  // for (int i = 0; i < 2; i++)
                  //   GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => registerForEventpage(
                  //                     clubId: "clubid",
                  //                   )));
                  //     },
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
                  //                       children: <Widget>[
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

                  //     //  onTap: (() => StudentInfoPage()),
                  //   )
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
//   String clubuid;
//   EventsStream({required this.clubuid});
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: _firestore
//             .collection("Clubs")
//             .doc(clubuid)
//             .collection("Events")
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final events = snapshot.data!.docs;
//             List<ListEvent> eventList = [];
//             for (var event in events) {
//               final eventName = event['eventName'];
//               final eventTime = event['eventTime'];
//               final eventDate = event['eventDate'];
//               final eventVenue = event['eventVenue'];
//               final eventLogo = event['eventLogo'];

//               eventList.add(ListEvent(
//                   eventName: eventName.toString(),
//                   eventDate: eventDate.toString(),
//                   eventTime: eventTime.toString(),
//                   eventVenue: eventVenue.toString(),
//                   eventLogo: eventLogo.toString()));
//             }
//             return Expanded(
//                 child: SizedBox(
//                     height: 1.0,
//                     width: 1,
//                     child: ListView(children: eventList)));
//           } else {
//             return Center(
//               child: CircularProgressIndicator(backgroundColor: Colors.amber),
//             );
//           }
//         });
//   }
// }

// class ListEvent extends StatelessWidget {
//   ListEvent({
//     required this.eventName,
//     required this.eventTime,
//     required this.eventDate,
//     required this.eventVenue,
//     required this.eventLogo,
//   });
//   String eventName;
//   String eventTime;
//   String eventDate;
//   String eventVenue;
//   String eventLogo;
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       child: Padding(
//         padding: EdgeInsets.all(3.0),
//         child: Text(
//           eventName,
//         ),
//         // child: Container(
//         //   decoration: BoxDecoration(
//         //     borderRadius: BorderRadius.circular(20),
//         //     color: Colors.grey,
//         //   ),
//         //   child: Column(
//         //     children: <Widget>[
//         //       Container(
//         //           height: 100,
//         //           width: 100,
//         //           margin: EdgeInsets.only(
//         //             top: 10,
//         //             // bottom: 10,
//         //           ),
//         //           child: ClipRRect(
//         //             borderRadius: BorderRadius.circular(100),
//         //             child: Image.network(eventLogo),
//         //           )),
//         //       SizedBox(
//         //         height: 25,
//         //       ),
//         //       Text(
//         //         eventName,
//         //         style: TextStyle(
//         //           fontSize: 22,
//         //           color: Colors.white,
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//       ),
//     );
//   }
// }
