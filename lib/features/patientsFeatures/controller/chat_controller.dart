import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'package:pinkaid/features/patientsFeatures/controller/chatbot/keyword.dart';
import 'package:pinkaid/features/patientsFeatures/controller/chatbot/response.dart';

class ChatController extends GetxController {
  RxList<Map<String, dynamic>> chatHistory = <Map<String, dynamic>>[].obs;
  TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final apiKey = 'AIzaSyAfbm7WQFZ4Ln-i7peunbCNrDY4sR8gEKI';
  TextEditingController userInput = TextEditingController();
  final RxList<Message> messagesList = <Message>[].obs;
  final String rasaUrl = 'https://e866-180-75-238-10.ngrok-free.app/webhooks/rest/webhook';
  //  var focusNode = FocusNode();
  //  var nodeFocus = FocusNode();
  final predefinedMessages = [
    "Hello",
    "How can I track my health?",
    "How to make consultation session?",
    "How can I join the forum?",
    "Help",
    "How to play the game?",
    "Thank you!",
    
  ];


  int _findMatchingKeyword(String response) {
    for (int i = 0; i < keywords.length; i++) {
      if (response.contains(keywords[i])) {
        return i;
      }
    }
    return -1;
  }

  void handleUserResponse(String response) {
    final lowerCaseResponse = response.trim().toLowerCase();
    //focusNode.dispose();
    

    String reply;
    String userSelectedOption;
    String defaultResponse = 'I apologize for the inconvenience, but I’m not able to understand your question. Could you kindly rephrase or ask something else?';


    messagesList
        .add(Message(isUser: true, message: response, date: DateTime.now()));
    final int index = _findMatchingKeyword(lowerCaseResponse);
    if (index != -1) {
      userSelectedOption = response;
      reply = responses[index];
    } else {
      userSelectedOption = "";
      reply = defaultResponse;
    }

    // if(userSelectedOption.isNotEmpty){
    //   messagesList.add(Message(isUser: true, message:userInput.text , date: DateTime.now()));
    // }

    Future.delayed(Duration(seconds: 1), () {
      messagesList
          .add(Message(isUser: false, message: reply, date: DateTime.now()));
    });
    userInput.clear();

    scrollToBottom();
  }

  // Scroll to the bottom when a new message is added
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
      );
    }
  }

   Future<void> sendMessageToRasa(String message) async {
    try {
      final response = await http.post(
        Uri.parse(rasaUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"sender": "user", "message": message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rasaReply = data[0]["text"];
        messagesList.add(Message(isUser: false, message: rasaReply, date: DateTime.now()));
      } else {
        messagesList.add(Message(isUser: false, message: "Error: Could not reach Rasa server.", date: DateTime.now()));
      }
    } catch (e) {
      messagesList.add(Message(isUser: false, message: "Error: $e", date: DateTime.now()));
    }
  }

  Future<void> talkWithChatbot() async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 1,
        topK: 64,
        topP: 0.95,
        maxOutputTokens: 8192,
        responseMimeType: 'application/json',
      ),
    );

    if (userInput.text.isNotEmpty) {
      messagesList.add(
          Message(isUser: true, message: userInput.text, date: DateTime.now()));
    }

    final content = Content.text(userInput.text);

    final response = await model.generateContent([content]);

    messagesList.add(Message(
        isUser: false, message: response.text ?? '', date: DateTime.now()));
    scrollToBottom();
    userInput.clear();
  }
}

class Message {
  bool isUser;
  String message;
  DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}
