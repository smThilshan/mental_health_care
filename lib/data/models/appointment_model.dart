
class AppointmentModel {
  String? doctorName;
  String? doctorId;
  String? userId;
  String? userCallingName;
  String? date;
  String? time;
  String? eventId;

  AppointmentModel({
    this.time,
    this.date,
    this.userId,
    this.doctorName,
    this.doctorId,
    this.userCallingName,
    this.eventId,
  });

  // Convert a AppointmentModel instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'doctorName': doctorName,
      'doctorId': doctorId,
      'userId': userId,
      'userCallingName': userCallingName,
      'date': date,
      'time': time,
      'eventId':eventId,
    };
  }

  // Construct a AppointmentModel instance from a JSON map.
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      doctorName: json['doctorName'],
      doctorId: json['doctorId'],
      userId: json['userId'],
      userCallingName: json['userCallingName'],
      date: json['date'],
      time: json['time'],
      eventId: json['eventId'],
    );
  }
}
