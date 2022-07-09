import 'package:aplos/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 4;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 4);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        height: 50,
        backgroundColor: secondaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(top: 10),
              child: Icon(
                Icons.home,
                color: (_page == 0) ? primaryColor : whiteColor,
                size: 40,
              ),
            ),
            label: "",
            backgroundColor: secondaryColor,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(top: 10),
              child: Icon(
                Icons.search,
                color: (_page == 1) ? primaryColor : whiteColor,
                size: 40,
              ),
            ),
            label: "",
            backgroundColor: secondaryColor,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(top: 10),
              child: Icon(
                Icons.add_circle,
                color: (_page == 2) ? primaryColor : whiteColor,
                size: 40,
              ),
            ),
            label: "",
            backgroundColor: secondaryColor,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(top: 10),
              child: Icon(
                Icons.chat,
                color: (_page == 3) ? primaryColor : whiteColor,
                size: 40,
              ),
            ),
            label: "",
            backgroundColor: secondaryColor,
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(top: 10),
              child: Icon(
                Icons.person,
                color: (_page == 4) ? primaryColor : whiteColor,
                size: 40,
              ),
            ),
            label: "",
            backgroundColor: secondaryColor,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
