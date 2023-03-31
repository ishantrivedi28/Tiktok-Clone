import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/model/comment.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;
  String _postID = '';
  updatePostID(String id) {
    _postID = id;
    fetchComment();
  }

  fetchComment() async {
    _comments.bindStream(FirebaseFirestore.instance
        .collection("videos")
        .doc(_postID)
        .collection("comments")
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comment> retVal = [];
      for (var element in query.docs) {
        retVal.add(Comment.fromSnap(element));
      }
      return retVal;
    }));
  }

  likeComment(String id) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    print(id);
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("videos")
        .doc(_postID)
        .collection("comments")
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(_postID)
          .collection("comments")
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(_postID)
          .collection("comments")
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

  postComent(String comment) async {
    if (comment.isNotEmpty) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .get();

      var allDocs = await FirebaseFirestore.instance
          .collection("videos")
          .doc(_postID)
          .collection("comments")
          .get();
      int len = allDocs.docs.length;

      Comment coment = Comment(
          username: (userDoc.data() as dynamic)['name'],
          comment: comment.trim(),
          datePub: DateTime.now(),
          likes: [],
          profilePic: (userDoc.data() as dynamic)['profilePic'],
          uid: FirebaseAuth.instance.currentUser!.uid,
          id: 'Coment $len');

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("videos")
          .doc(_postID)
          .get();
      await FirebaseFirestore.instance.collection("videos").doc(_postID).update(
          {'commentCount': (doc.data() as dynamic)['commentCount'] + 1});
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(_postID)
          .collection("comments")
          .doc('Coment $len')
          .set(coment.toJson());
    }
  }
}
