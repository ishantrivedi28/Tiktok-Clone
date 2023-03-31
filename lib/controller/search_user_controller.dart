import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/model/user.dart';

class SearchController extends GetxController {
  final Rx<List<MyUser>> _searchUsers = Rx<List<MyUser>>([]);

  List<MyUser> get searchUsers => _searchUsers.value;

  searchUser(String query) async {
    _searchUsers.bindStream(FirebaseFirestore.instance
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: query)
        .snapshots()
        .map((QuerySnapshot query) {
      List<MyUser> retVal = [];
      for (var element in query.docs) {
        retVal.add(MyUser.fromSnap(element));
      }
      return retVal;
    }));
  }
}
