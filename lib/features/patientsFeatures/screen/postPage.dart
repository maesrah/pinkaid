import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinkaid/features/patientsFeatures/controller/post_controller.dart';

import 'package:pinkaid/features/patientsFeatures/screen/post_card.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key, required this.categoryId});
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return FutureBuilder(
        future: controller.fetchPosts(categoryId),
        builder: ((context, snapshot) {
          return ListView.builder(
            itemCount: controller.posts.length,
            itemBuilder: (_, index) => PostCard(
              post: controller.posts[index],
            ),
          );
        }),
      );
    });
  }
}
