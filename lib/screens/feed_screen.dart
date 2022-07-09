import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF383737),
        title: const Text(
          "aplós",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 35, color: primaryColor),
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
      ),
    );
  }
}
