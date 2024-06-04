import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinkaid/features/authentication/widget/appbar.dart';
import 'package:pinkaid/features/patientsFeatures/controller/reply_controller.dart';
import 'package:pinkaid/features/patientsFeatures/screen/replyCard.dart';

class ReplyScreen extends StatelessWidget {
  final String postId;
  const ReplyScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReplyController controller = Get.put(ReplyController(postId));

    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Reply'),
      ),
      body: Obx(() {
        if (controller.comments.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: controller.comments.length,
          itemBuilder: (ctx, index) => ReplyCard(
            snap: controller.comments[index],
          ),
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              Obx(() {
                return CircleAvatar(
                  backgroundImage:
                      NetworkImage(controller.user.value.profilePicture),
                  radius: 18,
                );
              }),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller: controller.commentEditingController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${controller.user.value.fullName}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: controller.postComment,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
