import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/video_controller.dart';
import 'package:tiktok_clone/view/screens/comment_screen.dart';
import 'package:tiktok_clone/view/screens/profile_screen.dart';
import 'package:tiktok_clone/view/widgets/album_rotator.dart';
import '../widgets/profile_button.dart';
import '../widgets/tiktok_videoplayer.dart';

class DisplayVideoScreen extends StatelessWidget {
  DisplayVideoScreen({super.key});
  final VideoController videoController = Get.put(VideoController());

  Future<void> share(String vidId) async {
    await FlutterShare.share(
      title: 'Download My TikTok Clone App',
      text: 'Watch Awesome Videos on Fingertips',
    );
    videoController.shareVideo(vidId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => PageView.builder(
        itemBuilder: (context, index) {
          final videoDat = videoController.videoList[index];
          return InkWell(
            onDoubleTap: () => videoController.likedVideo(videoDat.id),
            child: Stack(
              children: [
                TikTokVideoPlayer(
                  videoUrl: videoDat.videoUrl,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@${videoDat.username}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        videoDat.caption,
                      ),
                      Text(
                        videoDat.songName,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 350,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.to(ProfileScreen(uid: videoDat.uid));
                            },
                            child: ProfileButton(
                                profilePhotoUrl: videoDat.profilePic)),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                videoController.likedVideo(videoDat.id);
                              },
                              child: Icon(
                                Icons.favorite,
                                size: 35,
                                color: videoDat.likes.contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? Colors.pinkAccent
                                    : Colors.white,
                              ),
                            ),
                            Text(
                              videoDat.likes.length.toString(),
                              style: TextStyle(
                                  fontSize: 15, color: Colors.pinkAccent),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => share(videoDat.id),
                          child: Column(
                            children: [
                              Icon(
                                Icons.reply,
                                size: 35,
                                color: Colors.white,
                              ),
                              Text(
                                videoDat.shareCount.toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.to(CommentScreen(
                            id: videoDat.id,
                          )),
                          child: Column(
                            children: [
                              Icon(
                                Icons.comment,
                                size: 35,
                                color: Colors.white,
                              ),
                              Text(
                                videoDat.commentCount.toString(),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        AlbumRotator(profilePicUrl: videoDat.profilePic),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: videoController.videoList.length,
        controller: PageController(initialPage: 1, viewportFraction: 1),
      ),
    ));
  }
}
