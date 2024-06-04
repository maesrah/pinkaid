import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:pinkaid/features/patientsFeatures/controller/post_controller.dart';
import 'package:pinkaid/features/patientsFeatures/model/postModel.dart';
import 'package:pinkaid/features/patientsFeatures/screen/post_details_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/replies.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final controller = PostController.instance;

    final user = controller.user.value;
    //final List<Post> posts = controller.posts;

    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: kSpaceScreenPadding),
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
                    //backgroundImage: NetworkImage(post.profImage),
                    backgroundImage: AssetImage(post.profImage),
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
                            showDialog(
                              useRootNavigator: false,
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: ListView(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shrinkWrap: true,
                                      children: [
                                        'Delete',
                                      ]
                                          .map(
                                            (e) => InkWell(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 12,
                                                      horizontal: 16),
                                                  child: Text(e),
                                                ),
                                                onTap: () {
                                                  controller
                                                      .deletePost(post.postId);
                                                  Navigator.of(context).pop();
                                                }),
                                          )
                                          .toList()),
                                );
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
            GestureDetector(
              onDoubleTap: () {
                Get.to(() => PostDetailsPage(post: post));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    // child: Image.network(
                    //   post.postUrl, // Access postUrl from the post object
                    //   fit: BoxFit.cover,
                    // ),
                    child: Image.asset(
                      post.postUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Add like animation widget here
                ],
              ),
            ),
            // LIKE, COMMENT SECTION OF THE POST
            Row(
              children: [
                // Like button
                Obx(() {
                  if (controller.isLikeAnimating.isTrue) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return IconButton(
                    icon: Icon(
                      post.likes.contains(user.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: post.likes.contains(user.id) ? Colors.red : null,
                    ),
                    onPressed: () {
                      controller.likePost(post.postId, user.id, post.likes);
                      //controller.update();
                    },
                  );
                }),
                // Comment button
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: () {
                    // Add comment functionality here
                  },
                ),
                // Bookmark button
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

            Text(post.title,
                style: KTextTheme.lightTextTheme.headlineSmall!
                    .copyWith(fontSize: 16)),
            Text(post.caption, style: KTextTheme.lightTextTheme.bodySmall),
            InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: const Text(
                    'View all replies',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                onTap: () => Get.to(() => ReplyScreen(postId: post.postId)))
          ],
        ),
      ),
    );
  }
}
