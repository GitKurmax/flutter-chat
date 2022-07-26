import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';

  void _sendMessage () async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    final userObj = await userData.data();

    print('====================================================');
    print(userObj);
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user?.uid,
      'userImage': userObj!['image_url']
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller ,
              decoration: const InputDecoration(label: Text('Send message...')),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },),
          ),
          IconButton(color: Theme.of(context).primaryColor, onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage, icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
