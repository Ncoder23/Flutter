import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _controller = TextEditingController();

  void _send() async {
    final message = _controller.text;
    if (message.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _controller.clear();
    final currUser = FirebaseAuth.instance.currentUser;

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currUser!.uid)
        .get();

    FirebaseFirestore.instance.collection('chats').add({
      'userID': currUser.uid,
      'message': message,
      'createdAt': Timestamp.now(),
      'userName': userData.data()!['username'],
      'userImg': userData.data()!['imgURL'],
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
        right: 10,
        left: 10,
        top: 10,
      ),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              label: Text('Type Your Message...'),
            ),
          ),
        ),
        IconButton(
          onPressed: _send,
          icon: Icon(Icons.send),
        ),
      ]),
    );
  }
}
