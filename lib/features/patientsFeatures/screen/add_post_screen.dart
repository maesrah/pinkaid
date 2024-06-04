import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:pinkaid/features/authentication/widget/appbar.dart';
import 'package:pinkaid/features/patientsFeatures/controller/add_post_controller.dart';
import 'package:pinkaid/features/patientsFeatures/controller/post_controller.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/utils/helpers/pickImage.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Post to'),
        actions: [
          TextButton(
            onPressed: () {
              controller.postData(controller.title.text,
                  controller.caption.text, controller.selectedImage.value!);
              Navigator.of(context).pop();
            },
            child: const Text(
              'Post',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: TextFormField(
                controller: controller.title,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                      controller: controller.caption,
                      decoration: const InputDecoration(
                        hintText: 'Write caption...',
                        border: InputBorder.none,
                      ),
                      maxLines: 10,
                    ),
                  ),
                  if (controller.selectedImage.value != null)
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  MemoryImage(controller.selectedImage.value!),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
            IconButton(
              onPressed: () {
                controller.selectImage();
              },
              icon: const Icon(Iconsax.add),
            ),
          ],
        ),
      ),
    );
  }
}
