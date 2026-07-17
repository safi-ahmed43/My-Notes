import 'package:flutter/material.dart';
import 'package:my_notes/main.dart';

void showMessage(String? msg, [bool isError=true]){
 scaffoldMessengerKeys.currentState?.showSnackBar(
   SnackBar(
     content: Text(msg?? ''),
     backgroundColor: isError? Colors.red:Colors.green,
   )
 );
}
