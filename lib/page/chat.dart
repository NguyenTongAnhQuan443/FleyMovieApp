import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return _chatState();
  }
}

class _chatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Chat'),
      ),
    );
  }
}