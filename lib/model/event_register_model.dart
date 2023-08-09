class studentRegistration {
  String? clubId;
  String? eventId;
  String? eventName;
  String? userId;
  String? userName;
  String? userphone;
  String? userEmail;

  studentRegistration({
    this.clubId,
    this.eventId,
    this.eventName,
    this.userId,
    this.userName,
    this.userphone,
    this.userEmail,
  });

  // Receiving data from server
  factory studentRegistration.fromMap(map) {
    return studentRegistration(
        clubId: map['clubId'],
        eventId: map['eventId'],
        eventName: map['eventName'],
        userId: map['userId'],
        userName: map['userName'],
        userphone: map['userphone'],
        userEmail: map['userEmail']);
  }

  //sending the data to the server
  Map<String, dynamic> toMap() {
    return {
      'clubId': clubId,
      'eventId': eventId,
      'eventName': eventName,
      'userId': userId,
      'userName': userName,
      'userphone': userphone,
      'userEmail': userEmail,
    };
  }
}
