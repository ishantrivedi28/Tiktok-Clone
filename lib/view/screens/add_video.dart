import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/view/screens/add_caption_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  videoPicl(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Get.snackbar("Video Selected", video.path);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddCaptionScreen(
                  videoFile: File(video.path), videoPath: video.path)));
    } else {
      Get.snackbar(
          "Error in selecting video", "Please select a different video");
    }
  }

  showDialogOpt(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    videoPicl(ImageSource.gallery, context);
                  },
                  child: const Text("Gallery"),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    videoPicl(ImageSource.camera, context);
                  },
                  child: const Text("Camera"),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            showDialogOpt(context);
          },
          child: Container(
            height: 50,
            width: 190,
            decoration: BoxDecoration(color: buttonColor),
            child: Center(
              child: Text(
                "Add Video",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
