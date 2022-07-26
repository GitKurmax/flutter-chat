import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.message, required this.isMe, required this.userId}) : super(key: key);

  final String message;
  final bool isMe;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [Container(
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isMe ? Colors.grey[300] :Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isMe ? const Radius.circular(15) : const Radius.circular(0),
            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(15),
          ),
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16
        ),
        margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end: CrossAxisAlignment.start ,
          children: [
            FutureBuilder(
              future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }

                  return Text(snapshot.data['username'], style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.black : Theme.of(context).colorScheme.onSecondary
                  ),);
              },
            ),
            Text(message, style: TextStyle(
              color: isMe ? Colors.black : Theme.of(context).colorScheme.onSecondary
            ),
            textAlign: isMe ? TextAlign.end : TextAlign.start,
            ),
          ],
        ),
      ),]
    );
  }
}
