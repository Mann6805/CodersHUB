import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codershub/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChatroomScreen extends StatefulWidget {

  String chatroomName;
  String chatroomId;

  ChatroomScreen({super.key, required this.chatroomId, required this.chatroomName});

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  
  var db = FirebaseFirestore.instance;
  TextEditingController msgText = TextEditingController();

  Future<void> sendMessage() async {

    if(msgText.text.isEmpty){
      return;
    }

    Map<String, dynamic> messageTosend = {
      "text" : msgText.text,
      "sender_name" : Provider.of<UserProvider>(context, listen: false).userName,
      "sender_id" : Provider.of<UserProvider>(context, listen: false).userId,
      "chatroom_id" : widget.chatroomId,
      "timestamp" : FieldValue.serverTimestamp(),
    };

    msgText.text = "";

    await db.collection("msg").add(messageTosend);

  }

  // ignore: non_constant_identifier_names
  Widget singleChatItem({required String senderName, required String text, required String senderId}) {
    
    return Column(
      crossAxisAlignment: senderId == Provider.of<UserProvider>(context, listen: false).userId ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Text(
            senderName,
            style: const TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: senderId == Provider.of<UserProvider>(context, listen: false).userId ? Colors.white : Colors.black87,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(text, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: senderId == Provider.of<UserProvider>(context, listen: false).userId ? Colors.black87 : Colors.white),),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatroomName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: db.collection("msg").where("chatroom_id", isEqualTo: widget.chatroomId ).orderBy("timestamp", descending: true).snapshots(),
              builder: (context, value) {

                if(value.hasError){
                  print(value);
                  return const Text(
                    "Some error has occured",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold
                    ),
                  );
                }
                
                var allMsg = value.data?.docs ?? [];              
                
                if (allMsg.isEmpty){
                  return const Center(
                    child: Text(
                      "Start Discussion", 
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w300,
                        fontSize: 20
                      ),
                    )
                  );
                }
                
                return ListView.builder(
                  reverse: true,
                  itemCount: allMsg.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: singleChatItem(senderName: allMsg[index]["sender_name"], text: allMsg[index]["text"], senderId: allMsg[index]["sender_id"])
                    );
                  }
                );
              },
            )
          ),
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: msgText,
                      decoration: const InputDecoration(
                        hintText: "Write Message Here",
                        border: InputBorder.none,
                      ),
                    )
                  ),
                  InkWell(
                    onTap: () {
                      sendMessage();
                    },
                    child: const Icon(Icons.send)
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}