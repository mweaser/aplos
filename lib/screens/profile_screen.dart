import 'package:aplos/resources/authentication_methods.dart';
import 'package:aplos/responsive/mobile_screen_layout.dart';
import 'package:aplos/responsive/responsive_layout_screen.dart';
import 'package:aplos/responsive/web_screen_layout.dart';
import 'package:aplos/screens/sign_up_screen.dart';
import 'package:aplos/screens/welcome_screen.dart';
import 'package:aplos/widgets/text_field_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  String? get uid => null;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  // bool isFollowing = false;
  // bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      // followers = userSnap.data()!['followers'].length;
      // following = userSnap.data()!['following'].length;
      // isFollowing = userSnap
      //     .data()!['followers']
      //     .contains(FirebaseAuth.instance.currentUser!.uid);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: GestureDetector(
            onTap: () {
              _signOut();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
            child: const Text(
              "logout",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF383737),
        title: Container(
          padding: const EdgeInsets.only(bottom: 10),
          child: const Text(
            "aplós",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 35, color: primaryColor),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.1,
              0.3,
              0.7,
            ],
            colors: [
              Color(0xFF383737),
              Color(0xFF282727),
              Color(0xFF151515),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 25, right: 15),
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                "https://images.unsplash.com/photo-1595152772835-219674b2a8a6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80"),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "@JohnAppleseed",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                Icon(Icons.rocket_launch),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Software Engineer",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: const [
                                Icon(Icons.school),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Columbia University",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: Colors.white),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.only(
                                  left: 10, top: 5, right: 10, bottom: 5),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text("Edit Profile",
                              style: TextStyle(fontSize: 14))),
                      const SizedBox(width: 10),
                      buildStatColumn(15, "Insights"),
                      const SizedBox(width: 10),
                      const VerticalDivider(thickness: 1.5),
                      const SizedBox(width: 10),
                      buildStatColumn(620, "Followers"),
                      const SizedBox(width: 10),
                      const VerticalDivider(thickness: 1.5),
                      const SizedBox(width: 10),
                      buildStatColumn(452, "Following"),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 400,
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 15, right: 15),
                  decoration: const BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "About",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Flutter Engineer. Passionate about ML and Sustainable Technology.",
                        style: TextStyle(color: whiteColor, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: const Divider(
                    thickness: 1,
                    color: secondaryColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
