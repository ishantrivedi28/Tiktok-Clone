import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/view/screens/add_video.dart';
import 'package:tiktok_clone/view/screens/display_video_screen.dart';
import 'package:tiktok_clone/view/screens/my_profile_screen.dart';
import 'package:tiktok_clone/view/screens/profile_screen.dart';
import 'package:tiktok_clone/view/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][Random().nextInt(3)];

var pageindex = [
  DisplayVideoScreen(),
  SearchScreen(),
  AddVideoScreen(),
  const Text('Comming Soon In New Updates!'),
  MyProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid)
];
