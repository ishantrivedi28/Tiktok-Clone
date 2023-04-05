import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/controller/profile_controller.dart';
import 'package:get/get.dart';

class MyProfileScreen extends StatefulWidget {
  String uid;
  MyProfileScreen({required this.uid});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    profileController.updateUserId(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("@${profileController.user['name']}")),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.snackbar('TikTok Clone App', "Version 1.1");
              },
              icon: Icon(Icons.info_outline))
        ],
      ),
      body: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            return controller.user.isEmpty
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: controller.user['profilePic'],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(controller.user['followers'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Followers",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(controller.user['following'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Followings",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(controller.user['likes'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Likes",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          InkWell(
                            onTap: () {
                              widget.uid ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? authController.signOut()
                                  : controller.followUser();
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white60, width: 0.6),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(widget.uid ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? "Sign Out"
                                    : controller.user['isFollowing']
                                        ? 'Following'
                                        : 'Follow'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            indent: 30,
                            endIndent: 30,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 59,
                          ),
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 5),
                            itemBuilder: (context, index) {
                              String thumbnail =
                                  controller.user['thumbnails'][index];
                              return CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: thumbnail,
                                errorWidget: ((context, url, error) =>
                                    Icon(Icons.error)),
                              );
                            },
                            itemCount: controller.user['thumbnails'].length,
                          ),
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}
