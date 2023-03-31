import 'package:flutter/material.dart';
import 'package:tiktok_clone/controller/search_user_controller.dart';
import 'package:tiktok_clone/model/user.dart';
import 'package:tiktok_clone/view/screens/profile_screen.dart';
import 'package:tiktok_clone/view/widgets/text_input.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  TextEditingController searchQuery = TextEditingController();

  SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: FormField(
            builder: (value) {
              return TextFormField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Search Username"),
                controller: searchQuery,
                onFieldSubmitted: (value) {
                  searchController.searchUser(value);
                },
              );
            },
          ),
        ),
        body: searchController.searchUsers.isEmpty
            ? Center(child: Text("Search Users"))
            : ListView.builder(
                itemCount: searchController.searchUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  MyUser user = searchController.searchUsers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePhoto),
                    ),
                    title: Text(user.name),
                    onTap: () => Get.to(ProfileScreen(uid: user.uid)),
                  );
                },
              ),
      ),
    );
  }
}
