class DoctorModel {
  String? displayName;
  String? email;
  String? uid;
  String? special;
  String? gender;
  DoctorModel({this.displayName, this.email,this.uid,this.special,this.gender});

  // Convert class instance to JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (displayName != null) {
      data['displayName'] = displayName;
    }
    if (email != null) {
      data['email'] = email;
    }
    if (uid != null) {
      data['uid'] = uid;
    }
    if (special != null) {
      data['special'] = special;
    }
    if (gender != null) {
      data['gender'] = gender;
    }
    return data;
  }

  // Create DoctorModel instance from JSON map
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      displayName: json['displayName'],
      email: json['email'],
      uid: json['uid'],
      special: json['special'],
      gender: json['gender'],
    );
  }
}
