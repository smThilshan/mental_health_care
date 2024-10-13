class UserModel {
  String? displayName;
  String? email;
  String? uid;
  String? gender;

  UserModel({this.displayName, this.email,this.uid,this.gender});

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
    if (gender != null) {
      data['gender'] = gender;
    }
    return data;
  }

  // Create DoctorModel instance from JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['displayName'],
      email: json['email'],
      uid: json['uid'],
      gender: json['gender'],
    );
  }
}
