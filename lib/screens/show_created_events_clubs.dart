import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_part_of_app/model/club_model.dart';
import 'package:first_part_of_app/screens/registered_students.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseFirestore.instance;

class eventShower extends StatefulWidget {
  String clubuid;
  eventShower({required this.clubuid});
  @override
  _eventState createState() => _eventState();
}

class _eventState extends State<eventShower> {
  ClubModel loggedInClub = ClubModel();

  List eventList = [];
  @override
  void initState() {
    super.initState();
    // ignore: non_constant_identifier_names
    final CollectionReference EventReference = FirebaseFirestore.instance
        .collection("Clubs")
        .doc(widget.clubuid)
        .collection("Events");
    EventReference.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          eventList.add(doc);
        });
      }
      print(eventList.length);
      print(eventList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: const Text("Event Details"),
        centerTitle: true,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back, color: Colors.redAccent),
        //     onPressed: () {
        //       Navigator.pop(context);
        //       // Navigator.push(context,
        //       //     MaterialPageRoute(builder: (context) => LoginScreen()));
        //     },
      ),
      body: Center(
        child: ListView.builder(
            itemCount: eventList.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color.fromARGB(200, 200, 200, 200),
                margin: const EdgeInsets.symmetric(vertical: 20),
                elevation: 4,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentInfoPage(
                              clubid: widget.clubuid,
                              eventName: '${eventList[index]['eventName']}',
                              eventid: '${eventList[index]['eventuid']}'),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ClipRRect(
                          child: Image.network(
                            // "assets/logo.png",
                            '${eventList[index]['eventLogo']}',
                            height: 150,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${eventList[index]['eventName']}',
                                    ),
                                    Spacer(),
                                    Text(
                                      // "Event Venue",
                                      '${eventList[index]['eventVenue']}',
                                    ),
                                    Spacer(),
                                    Text(
                                      // "Event Time"
                                      '${eventList[index]['eventTime']}',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text("Click hear to see the registration"),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
// return ListView.builder(
//         itemCount: eventList.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.symmetric(vertical: 20),
//             elevation: 4,
//             color: Colors.white,
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10))),
//             child: Padding(
//               padding: const EdgeInsets.all(0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   ClipRRect(
//                     child: Image.asset(
//                       "assets/logo.jpeg",
//                       // '${eventList[index]['eventLogo']}',
//                       height: 150,
//                       fit: BoxFit.fitWidth,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0, left: 8.0),
//                     child: Row(
//                       children: <Widget>[
//                         Expanded(
//                           flex: 3,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text("event Name"
//                                   // '${eventList[index]['eventName']}',
//                                   ),
//                               Spacer(),
//                               Text(
//                                 "Event Venue",
//                                 // '${eventList[index]['eventVenue']}',
//                               ),
//                               Spacer(),
//                               Text("Event Time"
//                                   // '${eventList[index]['eventTime']}',
//                                   ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });

// class EventsStream extends StatelessWidget {
//   String clubuid;
//   EventsStream({required this.clubuid});
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: _firebase
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
