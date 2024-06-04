import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';

class ReplyController extends GetxController {
  final String postId;
  ReplyController(this.postId);

  final TextEditingController commentEditingController =
      TextEditingController();
  var user =
      UserModel.empty().obs; // Assuming you have a User.empty constructor
  var comments = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchComments();
    fetchUser();
  }

  void fetchUser() {
    // Replace with your user fetching logic
    // user.value = User(
    //   username: "username",
    //   uid: "uid",
    //   photoUrl: "photoUrl",
    // );
  }

  void fetchComments() {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .listen((snapshot) {
      comments.value = snapshot.docs;
    });
  }

  void postComment() async {
    try {
      // String res = await FireStoreMethods().postComment(
      //   postId,
      //   commentEditingController.text,
      //   user.value.uid,
      //   user.value.username,
      //   user.value.photoUrl,
      // );

      // if (res != 'success') {
      //   Get.snackbar('Error', res);
      // }
      commentEditingController.clear();
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }
}
