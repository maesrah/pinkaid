import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/data/repositories/user/user_repository.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
import 'package:pinkaid/features/patientsFeatures/privatechatting/chat.dart';

class ChatService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final UserRepository userRepository = Get.put(UserRepository());

  Future<void> sendMessage(String receiverId,String receiverName,String message)async{
   final user = await userRepository.getUserDetails();
    final String currentUserId=_firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();
    
    Chat newMessage = Chat(senderId: currentUserId, receiverId: receiverId, message: message, timestamp: timestamp, senderName: user.fullName, receiverName: receiverName);

    List<String> ids = [currentUserId,receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore.collection("Chat_Rooms").doc(chatRoomId).collection('Messages').add(newMessage.toMap());

  }

  Stream<QuerySnapshot> getMessage(String userId,String otherUserId){
    List<String> ids = [userId,otherUserId];
    ids.sort();
    String chatRoomId=ids.join("_");

    return _firestore.collection("Chat_Rooms").doc(chatRoomId).collection('Messages').orderBy('timestamp',descending: false).snapshots();
  }
}