import 'dart:typed_data';

import 'package:aplos/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aplos/models/user.dart' as model;

class AuthenticationMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User? currentUser = _auth.currentUser;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUser?.uid).get();
    return model.User.fromSnap(snapshot);
  }

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String school,
      required String job,
      required String bio,
      required Uint8List file}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          school.isNotEmpty ||
          job.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // Register the user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(credential.user!.uid);

        // Upload Profile Picture to Storage
        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file);

        // Create User instance
        model.User user = model.User(
          uid: credential.user!.uid,
          username: username,
          email: email,
          photoUrl: photoUrl,
          school: school,
          job: job,
          bio: bio,
        );

        // Add user to Database
        await _firestore.collection('users').doc(credential.user!.uid).set(
              user.toJson(),
            );

        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      res = err.toString();
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
