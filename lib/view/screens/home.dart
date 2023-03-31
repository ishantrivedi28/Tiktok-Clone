import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/view/widgets/customAddIcon.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: (pageindex[pageIdx])),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            pageIdx = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        currentIndex: pageIdx,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 25,
              ),
              label: "Home"),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 25,
              ),
              label: "Search"),
          BottomNavigationBarItem(icon: CustomAddIcon(), label: ""),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                size: 25,
              ),
              label: "Messages"),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 25,
              ),
              label: "Profile"),
        ],
      ),
    );
  }
}
