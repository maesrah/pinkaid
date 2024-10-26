import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinkaid/features/patientsFeatures/model/appointment_model.dart';
import 'package:pinkaid/features/patientsFeatures/privatechatting/chat_service.dart';
import 'package:pinkaid/theme/theme.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key,required this.receiverId,required this.receiverName});
  final String receiverId;
  final String receiverName;

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
   
    
    

    return Scaffold(
      appBar: AppBar(
        title: const Text("Consultation Session", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(),
          
          ),
          _buildMessageInput(messageController)
        ],
      ),
    );
  }

  Widget _buildMessageList(){
   final ChatService chatService=ChatService();
   final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
    return StreamBuilder(stream:chatService.getMessage(firebaseAuth.currentUser!.uid, receiverId) , builder: (context,snapshot){
      if(snapshot.hasError){
        return Text('Error${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.waiting){
        return const Text('Loading');
      }

      return ListView(children: snapshot.data!.docs.map((document)=> _buildMessageItem(document)).toList());
    });
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    Map<String,dynamic> data = document.data() as Map<String,dynamic>;

    var alignment = (data['senderId']==firebaseAuth.currentUser!.uid)? Alignment.centerRight :Alignment.centerLeft;
    Color colorText = (data['senderId']==firebaseAuth.currentUser!.uid)? kColorPrimary:Colors.grey.shade300;

    
    return Container(alignment: alignment,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: colorText,borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(data['senderName'],style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(data['message'])
            ],
          ),
        ),
      ),
    ),);

  }


  Widget _buildMessageInput(TextEditingController messageController){
     final ChatService chatService=ChatService();
     //final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

    void sendMessage() async{
      if(messageController.text.isNotEmpty){
        await chatService.sendMessage(receiverId,receiverName, messageController.text,);
      }

      messageController.clear();
    }
    return Row(
      children: [
        Expanded(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: messageController,
             decoration: const InputDecoration(
                          hintText: "Type a message",
                          border: InputBorder.none,
                        ),
                        obscureText: false,
          ),
        )),
        IconButton(onPressed:(){
          sendMessage();
        } , icon: const Icon(Icons.send,size: 20,color: Colors.blueAccent))
      ],
    );
  }
}