import 'dart:developer';

import 'package:chat_app/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial()){getMessage();}
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  List<MessagesModel> messageList = [];
  sendMessage({required String message, required String email}) {
    messages.add(
      {
        kMessage: message,
        kCreatedAt: DateTime.now(),
        kSpecialId: email,
      },
    );
    
    
    print (messageList) ;
  }

  getMessage(){
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen(
      (event) {
        messageList.clear();
        for (var doc in event.docs) {
          messageList.add(MessagesModel.fromJson(doc));
        }
        emit(ChatSucceed());
        
        
      },
      onError: (error) {
        log("Error fetching messages: $error");
      },
    );
  }

}