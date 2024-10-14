import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:pinkaid/features/patientsFeatures/controller/post_controller.dart';
import 'package:pinkaid/features/patientsFeatures/model/post_model.dart';
import 'package:pinkaid/features/patientsFeatures/screen/post_details_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/reply_screen.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final controller = PostController.instance;
    final user = controller.user.value;

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: kColorInfo),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER SECTION OF THE POST
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(post.profImage),
                    // backgroundImage: AssetImage(post.profImage),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            post.fullName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  post.id == user.id
                      ? IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Delete Post",
                              middleText:
                                  "Are you sure you want to delete this post?",
                              textCancel: "No",
                              textConfirm: "Yes",
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                controller.deletePost(post.id);
                                Get.back();
                              },
                              onCancel: () {
                                Get.back();
                              },
                            );
                          },
                          icon: const Icon(Icons.more_vert),
                        )
                      : Container(),
                ],
              ),
            ),
            // IMAGE SECTION OF THE POST
            if (post.postUrl.isNotEmpty)
              GestureDetector(
                onDoubleTap: () {
                  Get.to(() => PostDetailsPage(
                        post: post,
                        user: user,
                      ));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Image.network(
                        post.postUrl,
                        fit: BoxFit.cover,
                      ),
                      // child: Image.asset(
                      //   post.postUrl,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ],
                ),
              ),
            // TITLE AND CAPTION SECTION OF THE POST
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title,
                      style: KTextTheme.lightTextTheme.headlineSmall!
                          .copyWith(fontSize: 16)),
                  Text(post.caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: KTextTheme.lightTextTheme.bodySmall),
                ],
              ),
            ),
            // LIKE, COMMENT SECTION OF THE POST
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: () {
                    Get.to(() => PostDetailsPage(post: post, user: user));
                  },
                ),
                InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: const Text(
                        'View post',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onTap: () =>
                        Get.to(() => PostDetailsPage(post: post, user: user))),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        DateFormat.yMMMd().format(post.datePublished.toDate()),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
