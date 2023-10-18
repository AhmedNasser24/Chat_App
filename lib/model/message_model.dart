import 'dart:developer';

import 'package:chat_app/constants.dart';

class MessagesModel {
  final String message ;
  final String specialId;
  MessagesModel(this.message, this.specialId) ;

  factory MessagesModel.fromJson( jsonData){
    log(jsonData.toString()) ;
    return MessagesModel(jsonData[kMessage] , jsonData['specialId']) ;
  }
}