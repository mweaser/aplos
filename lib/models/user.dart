import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final String photoUrl;
  final String school;
  final String job;
  final String bio;

  const User({
    required this.uid,
    required this.username,
    required this.email,
    required this.photoUrl,
    required this.school,
    required this.job,
    required this.bio,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "email": email,
        "photoUrl": photoUrl,
        "school": school,
        "job": job,
        "bio": bio,
      };
}
