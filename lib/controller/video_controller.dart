import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/model/video.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  Rx<bool> isPlaying = Rx<bool>(true);

  List<Video> get videoList => _videoList.value;
  late VideoPlayerController videoPlayerController;

  @override
  void onInit() {
    _videoList.bindStream(FirebaseFirestore.instance
        .collection("videos")
        .snapshots()
        .map((QuerySnapshot queru) {
      List<Video> retVal = [];
      for (var element in queru.docs) {
        retVal.add(Video.fromSnap(element));
      }
      return retVal;
    }));

    super.onInit();
  }

  shareVideo(String videoId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('videos')
        .doc(videoId)
        .get();

    int newShareCount = (doc.data() as dynamic)['shareCount'] + 1;
    await FirebaseFirestore.instance
        .collection('videos')
        .doc(videoId)
        .update({'shareCount': newShareCount.toString()});
  }

  likedVideo(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("videos").doc(id).get();
    print('look here buddyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');

    print(doc);

    print(doc.data());
    var uid = AuthController.instance.user.uid;
    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance.collection("videos").doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await FirebaseFirestore.instance.collection("videos").doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}
