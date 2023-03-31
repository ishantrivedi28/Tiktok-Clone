import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  String songName;
  String videoUrl;
  String profilePic;
  int shareCount;
  String caption;
  String thumbnail;

  Video(
      {required this.username,
      required this.commentCount,
      required this.id,
      required this.likes,
      required this.profilePic,
      required this.songName,
      required this.uid,
      required this.videoUrl,
      required this.shareCount,
      required this.caption,
      required this.thumbnail});

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'profilePic': profilePic,
        'id': id,
        'likes': likes,
        'commentCount': commentCount,
        'shareCount': shareCount,
        'songName': songName,
        'caption': caption,
        'videoUrl': videoUrl,
        'thumbnail': thumbnail
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
        username: snapshot['username'],
        commentCount: snapshot['commentCount'],
        id: snapshot['id'],
        likes: snapshot['likes'],
        profilePic: snapshot['profilePic'],
        songName: snapshot['songName'],
        uid: snapshot['uid'],
        videoUrl: snapshot['videoUrl'],
        shareCount: snapshot['shareCount'],
        caption: snapshot['caption'],
        thumbnail: snapshot['thumbnail']);
  }
}
