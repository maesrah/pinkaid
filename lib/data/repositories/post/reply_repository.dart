import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/patientsFeatures/model/comment_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/post_model.dart';
import 'package:pinkaid/utils/exception/exceptions/firebase_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/format_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/platform_exceptions.dart';

class ReplyRepository extends GetxController {
  static ReplyRepository get instance => Get.find();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> uploadReply(String postId, Comment comment) async {
    try {
      await _firebaseFirestore
          .collection("comment")
          .doc(comment.id)
          .set(comment.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<Comment>> getReply(String postId) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection("comment")
          .where('postId', isEqualTo: postId)
          .get();
      return querySnapshot.docs
          .map((doc) => Comment.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Delete Post
  Future<String> deletePost(String commentId) async {
    String res = "Some error occurred";
    try {
      await _firebaseFirestore.collection('comment').doc(commentId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
