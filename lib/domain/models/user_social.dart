import 'package:cloud_firestore/cloud_firestore.dart';

class UserSocial {
  String picUrl, name, email, message;
  String? dbRef;

  UserSocial({
    required this.picUrl,
    required this.name,
    required this.email,
    required this.message,
    this.dbRef,
  });

  factory UserSocial.fromJson(Map<String, dynamic> map) {
    final data = map["data"];
    return UserSocial(
        picUrl: data['picUrl'],
        name: data['name'],
        email: data['email'],
        message: data['message'],
        dbRef: map['ref']);
  }

  Map<String, dynamic> toJson() {
    return {
      "picUrl": picUrl,
      "name": name,
      "email": email,
      "message": message,
      "timestamp": Timestamp.now(),
    };
  }
}
