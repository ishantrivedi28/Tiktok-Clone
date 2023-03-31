import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controller/upload_video_controller.dart';
import 'package:tiktok_clone/view/widgets/text_input.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';

class AddCaptionScreen extends StatefulWidget {
  File videoFile;
  String videoPath;
  AddCaptionScreen(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<AddCaptionScreen> createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {
  static VideoUploadController instance = Get.find();
  late VideoPlayerController videoPlayerController;
  TextEditingController songNameController = TextEditingController();

  TextEditingController captionController = TextEditingController();
  VideoUploadController videoUploadController =
      Get.put(VideoUploadController());

  Rx<String> UploadContent = Rx<String>('Upload');

  uploadVid() {
    UploadContent.update((val) {
      UploadContent.value = 'Please Wait...';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              width: MediaQuery.of(context).size.width,
              child: VideoPlayer(videoPlayerController),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.9,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextInputField(
                        controller: songNameController,
                        myIcon: Icons.music_note,
                        myLabelText: "Song Name"),
                    SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                        controller: captionController,
                        myIcon: Icons.closed_caption,
                        myLabelText: "Caption"),
                  ]),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                uploadVid();
                videoUploadController.uploadVideo(songNameController.text,
                    captionController.text, widget.videoPath);
              },
              child: Obx(() => Text(UploadContent.value)),
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
            )
          ],
        ),
      ),
    );
  }
}
