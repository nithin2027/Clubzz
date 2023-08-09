import 'package:cloud_firestore/cloud_firestore.dart';

class ClubModel {
  String? clubuid;
  String? clubEmail;
  String? clubName;
  String? clubHead;
  Timestamp? cTime;
  String? clubLogo;
  String? clubBio;

  ClubModel(
      {this.clubuid,
      this.clubEmail,
      this.clubName,
      this.clubHead,
      this.cTime,
      this.clubLogo,
      this.clubBio});

  // Receiving data from server
  factory ClubModel.fromMap(map) {
    return ClubModel(
        clubuid: map['clubuid'],
        clubEmail: map['clubEmail'],
        clubName: map['clubName'],
        clubHead: map['clubHead'],
        cTime: map['cTime'],
        clubLogo: map['clubLogo'],
        clubBio: map['clubBio']);
  }

  //sending the data to the server
  Map<String, dynamic> toMap() {
    return {
      'clubuid': clubuid,
      'clubEmail': clubEmail,
      'clubName': clubName,
      'clubHead': clubHead,
      'cTime': cTime,
      'clubLogo': clubLogo,
      'clubBio': clubBio
    };
  }
}
