import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/comment_controller.dart';
import 'package:tiktok_clone/view/screens/home.dart';
import 'package:tiktok_clone/view/widgets/text_input.dart';
import 'package:tiktok_clone/view/widgets/tiktok_videoplayer.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({required this.id});

  final TextEditingController _commentText = TextEditingController();

  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostID(id);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Get.off(HomeScreen());
          return true;
        },
        child: SingleChildScrollView(
            child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final comment = commentController.comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(comment.profilePic),
                        ),
                        title: Row(children: [
                          Text(
                            comment.username,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.redAccent),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            comment.comment,
                            style: TextStyle(fontSize: 13),
                          ),
                        ]),
                        subtitle: Row(
                          children: [
                            Text(
                              tago.format(comment.datePub.toDate()),
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              comment.likes.length.toString(),
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                            onTap: () {
                              commentController.likeComment(comment.id);
                            },
                            child: Icon(Icons.favorite,
                                color: comment.likes.contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? Colors.red
                                    : Colors.white)),
                      );
                    },
                    itemCount: commentController.comments.length,
                    shrinkWrap: true,
                  );
                }),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Expanded(
                  child: ListTile(
                    title: TextInputField(
                      controller: _commentText,
                      myIcon: Icons.comment,
                      myLabelText: "Comment",
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        commentController.postComent(_commentText.text);
                        _commentText.clear();
                      },
                      child: const Text("Send"),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
