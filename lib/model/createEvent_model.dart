import 'package:cloud_firestore/cloud_firestore.dart';

class creatEventModel {
  String? eventid;
  String? eventName;
  String? eventVenue;
  String? eventDate;
  String? eventTime;
  // Timestamp? eTime;
  String? eventLogo;
  String? eventCat;
  String? eventDisc;

  creatEventModel(
      {this.eventid,
      this.eventName,
      this.eventVenue,
      this.eventDate,
      this.eventTime,
      this.eventLogo,
      this.eventCat,
      this.eventDisc});

  // Receiving data from server
  factory creatEventModel.fromMap(map) {
    return creatEventModel(
        eventid: map['eventid'],
        eventName: map['eventName'],
        eventVenue: map['eventVenue'],
        eventDate: map['eventDate'],
        eventTime: map['eventTime'],
        eventLogo: map['eventLogo'],
        eventCat: map['eventCat']);
  }

  //sending the data to the server
  Map<String, dynamic> toMap() {
    return {
      'eventuid': eventid,
      'eventName': eventName,
      'eventVenue': eventVenue,
      'eventDate': eventDate,
      'eventTime': eventTime,
      'eventLogo': eventLogo,
      'eventCat': eventCat,
    };
  }
}
