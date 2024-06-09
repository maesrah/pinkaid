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
    //controller.categoryId = categoryId;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center();
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

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:pinkaid/features/patientsFeatures/controller/post_controller.dart';

// import 'package:pinkaid/features/patientsFeatures/screen/post_card.dart';

// class PostsPage extends StatelessWidget {
//   const PostsPage({super.key, required this.categoryId});
//   final String categoryId;
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(PostController());
//     //final posts = controller.fetchPosts(categoryId);

//     return FutureBuilder(
//       future: controller.fetchPosts(categoryId),
//       builder: ((context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Something went wrong: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('No posts available'));
//         } else {
//           return ListView.builder(
//             itemCount: controller.posts.length,
//             itemBuilder: (_, index) => PostCard(
//               post: controller.posts[index],
//             ),
//           );
//         }
//       }),
//     );
//   }
// }
