import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String name;
  String profilePhoto;
  String email;
  String uid;

  MyUser({
    required this.name,
    required this.email,
    required this.profilePhoto,
    required this.uid,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "profilePic": profilePhoto,
      "email": email,
      "uid": uid
    };
  }

  static MyUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MyUser(
        name: snapshot['name'],
        email: snapshot['email'],
        profilePhoto: snapshot['profilePic'],
        uid: snapshot['uid']);
  }
}
