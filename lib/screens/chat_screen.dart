import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/widgets/chat/messages.dart';

import '../widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fluttr chat'), actions: [
        DropdownButton(
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).primaryIconTheme.color,
          ),
          items: [
            DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app, color: Colors.black,),
                    SizedBox(width: 8),
                    Text('Logout')
                  ],
                ))
          ],
          onChanged: (itemId) {
            if (itemId == 'logout') {
              FirebaseAuth.instance.signOut();
            }
          },
        )
      ]),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(child: Messages()),
            NewMessage()
          ],
        ),
      ),
    );
  }
}
