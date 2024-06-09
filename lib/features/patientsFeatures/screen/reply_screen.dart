import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/authentication/controller/user_controller.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';

import 'package:pinkaid/features/authentication/widget/appbar.dart';
import 'package:pinkaid/features/patientsFeatures/controller/reply_controller.dart';
import 'package:pinkaid/features/patientsFeatures/screen/reply_card.dart';
import 'package:pinkaid/theme/theme.dart';

class ReplyScreen extends StatelessWidget {
  final String postId;
  //inal UserModel user;

  const ReplyScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReplyController controller = Get.put(ReplyController());
    final UserController userController = Get.put(UserController());
    final UserModel userModel = userController.user.value;

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          color: kColorSecondaryLight,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(kSpaceScreenPadding),
            child: Container(
              decoration: const BoxDecoration(
                  color: kColorInfo,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(30))),
              height: kToolbarHeight,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userModel.profilePicture),
                    radius: 18,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
                      child: TextField(
                        controller: controller.comment,
                        decoration: InputDecoration(
                          hintText: 'Comment as ${userModel.fullName}',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await controller.postComment(
                          controller.comment.text, userModel, postId);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
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
          Obx(() {
            if (controller.isLoading.value) {
              return const CircularProgressIndicator();
            }
            return Expanded(
              child: FutureBuilder(
                future: controller.fetchComment(postId),
                builder: ((context, snapshot) {
                  return ListView.builder(
                    itemCount: controller.replies.length,
                    itemBuilder: (_, index) => ReplyCard(
                      comment: controller.replies[index],
                    ),
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }
}
