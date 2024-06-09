import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/data/repositories/post/reply_repository.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
import 'package:pinkaid/features/patientsFeatures/model/comment_model.dart';
import 'package:pinkaid/utils/helpers/loaders.dart';
import 'package:pinkaid/utils/utils.dart';
import 'package:uuid/uuid.dart';

class ReplyController extends GetxController {
  static ReplyController get instance => Get.find();
  final TextEditingController comment = TextEditingController();
  var user = UserModel.empty().obs;
  var isLoading = false.obs;
  final replyRepository = Get.put(ReplyRepository());
  RxList<Comment> replies = <Comment>[].obs;
  final _postId = ''.obs;
  String get postId => _postId.value;
  set postId(String value) => _postId.value = value;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Comment>> fetchComment(String postId) async {
    try {
      isLoading.value = true;
      final commentList = await replyRepository.getReply(postId);
      replies.assignAll(commentList);
      return commentList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  void deleteComments(String postId) async {
    try {
      isLoading.value = true;
      await replyRepository.deletePost(postId);
    } catch (err) {
      KLoaders.errorSnackBar(title: err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> postComment(
      String replies, UserModel user, String postId) async {
    try {
      isLoading.value = true;

      String commentId = const Uuid().v1();

      var comment = Comment(
          id: commentId,
          fullName: user.fullName,
          postId: postId,
          comment: replies,
          datePublished: DateTime.now(),
          profImage: user.profilePicture);

      replyRepository.uploadReply(postId, comment);
    } catch (e) {
      KLoaders.errorSnackBar(title: 'Something went wrong');
    } finally {
      KLoaders.successSnackBar(
          title: 'Success', message: 'Your comment succesfully posted!');
      comment.clear();
      isLoading.value = false;
    }
  }
}
