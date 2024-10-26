import 'package:bubble/bubble.dart';
import 'package:dialogflow_flutter_plus/googleAuth.dart';
import 'package:flutter/material.dart';
import 'package:dialogflow_flutter_plus/dialogflowFlutter.dart';

class TestChat extends StatefulWidget {
  @override
  TestChatState createState() => TestChatState();
}

class TestChatState extends State<TestChat> {
  final messageInsert = TextEditingController();
  List<Map> messsages = [];
  void response(query) async {
    try {
      AuthGoogle authGoogle =
          await AuthGoogle(fileJson: "assets/stats/pinkaid.json").build();
      DialogFlow dialogflow =
          DialogFlow(authGoogle: authGoogle, language: "en");

      AIResponse aiResponse = await dialogflow.detectIntent(query);

      // Check if aiResponse is null or valid
      if (aiResponse == null || aiResponse.getMessage() == null) {
        throw Exception("Received null response from Dialogflow.");
      }

      setState(() {
        messsages.insert(0, {
          "data": 0,
          "message":
              aiResponse.getMessage() ?? "Sorry, I couldn't understand that."
        });
      });
    } catch (e) {
      // Log error for debugging
      print("Error occurred: $e");

      setState(() {
        messsages.insert(0, {
          "data": 0,
          "message":
              "$e"
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        elevation: 10,
        title: Text("Dailog Flow Chatbot"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
            Divider(
              height: 6.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                    controller: messageInsert,
                    decoration: InputDecoration.collapsed(
                        hintText: "Send your message",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                  )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 30.0,
                        ),
                        onPressed: () {
                          if (messageInsert.text.isEmpty) {
                            print("empty message");
                          } else {
                            setState(() {
                              messsages.insert(0,
                                  {"data": 1, "message": messageInsert.text});
                            });
                            response(messageInsert.text);
                            messageInsert.clear();
                          }
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  Widget chat(String message, int data) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Bubble(
          radius: Radius.circular(15.0),
          color: data == 0 ? Colors.blue : Colors.orangeAccent,
          elevation: 0.0,
          alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
          nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(data == 0
                      ? "assets/icons/badge.png"
                      : "assets/icons/games.png"),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
              ],
            ),
          )),
    );
  }
}
