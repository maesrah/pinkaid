import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:pinkaid/features/patientsFeatures/controller/reply_controller.dart';
import 'package:pinkaid/features/patientsFeatures/model/comment_model.dart';

class ReplyCard extends StatelessWidget {
  final Comment comment;
  const ReplyCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final ReplyController controller = Get.put(ReplyController());
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              comment.profImage,
            ),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: comment.fullName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const TextSpan(
                          text: '  ', // Add a space here
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: comment.comment,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      DateFormat.yMMMd().format(comment.datePublished.toDate()),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Delete Comment",
                middleText: "Are you sure you want to delete this comment?",
                textCancel: "No",
                textConfirm: "Yes",
                confirmTextColor: Colors.white,
                onConfirm: () {
                  
                  controller.deleteComments(comment.id);
                  Get.back();
                },
                onCancel: () {
                  Get.back(); 
                },
              );
            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }
}
