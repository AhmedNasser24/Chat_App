import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/message_model.dart';
import '../widgets/chat_bubble.dart';
import 'login_view.dart';

class ChatView extends StatelessWidget {
  static String id = 'chat view';
  TextEditingController textController = TextEditingController();
  // final CollectionReference messages =
  //     FirebaseFirestore.instance.collection(kMessageCollection);
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    String messageData = '';
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title:const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            CircleAvatar(
              maxRadius: 20,
              foregroundImage: AssetImage(kLogo),
            ),
            Text(
              "  Chat",
              style: TextStyle(color: kSecondaryColor),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                List < MessagesModel > messageList = BlocProvider.of<ChatCubit>(context).messageList ;
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    if (messageList[index].specialId == email) {
                      return ChatBubble(
                        textMessage: messageList[index].message,
                        isMe: true,
                      );
                    } else {
                      return ChatBubble(
                        textMessage: messageList[index].message,
                        isMe: false,
                      );
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              onChanged: (value) {
                messageData = value;
              },
              onSubmitted: (messageData) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: messageData, email: email as String);

                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
                textController.clear();
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    BlocProvider.of<ChatCubit>(context).sendMessage(
                        message: messageData, email: email as String);
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );

                    textController.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  ),
                ),
                hintText: 'enter message',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
