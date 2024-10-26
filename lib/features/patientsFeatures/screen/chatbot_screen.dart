import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/patientsFeatures/controller/chat_controller.dart';

class ChatbotScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title:
            const Text("Chat", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          // Chat messages
          Obx(() => ListView.builder(
                controller: chatController.scrollController,
                itemCount: chatController.messagesList.length,
                padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 120), // Adjusted bottom padding for the input area
                itemBuilder: (context, index) {
                  var chat = chatController.messagesList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 5.0),
                    child: Align(
                      alignment:
                          chat.isUser ? Alignment.topRight : Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: chat.isUser
                              ? Colors.blueAccent
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          chat.message,
                          style: TextStyle(
                              color: chat.isUser ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              )),

          // Positioned input area with message buttons and text input
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Predefined message buttons
                  Wrap(
                    spacing: 8.0,
                    children: [
                      for (var message in chatController.predefinedMessages)
                        ElevatedButton(
                          onPressed: () {
                            chatController.handleUserResponse(message);
                            Future.delayed(Duration(milliseconds: 300), () {
                              chatController.scrollController.animateTo(
                                chatController
                                    .scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: Text(
                            message,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 8), // Space between buttons and input

                  // Text input and send button
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: chatController.userInput,
                          decoration: const InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                          ),
                          autofocus: true,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.blueAccent),
                        onPressed: () {
                          final message = chatController.userInput.text.trim();
                          if (message.isNotEmpty) {
                            // chatController.handleUserResponse(message);
                            // chatController.userInput.clear(); // Clear the input field
                            final message =
                                chatController.userInput.text.trim();
                            if (message.isNotEmpty) {
                              chatController.messagesList.add(Message(
                                  isUser: true,
                                  message: message,
                                  date: DateTime.now()));
                              chatController.sendMessageToRasa(
                                  message); // Send message to Rasa
                              chatController.userInput.clear();
                            }

                            // Scroll to the bottom of the chat after sending a message
                            Future.delayed(Duration(milliseconds: 300), () {
                              chatController.scrollController.animateTo(
                                chatController
                                    .scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
