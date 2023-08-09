import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_part_of_app/model/club_model.dart';
import 'package:first_part_of_app/screens/registerForEvent.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class eventShowerUser extends StatefulWidget {
  String userid;
  String clubuid;
  eventShowerUser({required this.clubuid, required this.userid});
  @override
  _eventState createState() => _eventState();
}

class _eventState extends State<eventShowerUser> {
  ClubModel loggedInClub = ClubModel();

  List eventList = [];
  @override
  void initState() {
    super.initState();
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
      print(widget.clubuid);
      print(eventList.length);
      print(eventList);
      if (eventList.length == 0) {
        Fluttertoast.showToast(msg: "There is no Events to Show");
      }
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
                          builder: (context) => registerForEventpage(
                              userId: widget.userid,
                              clubId: widget.clubuid,
                              eventName: '${eventList[index]['eventName']}',
                              eventId: '${eventList[index]['eventuid']}'),
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
