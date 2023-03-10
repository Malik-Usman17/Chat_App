import 'package:chat_app/constants/appConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  static const String id = 'chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  dynamic loggedInUser;
  late String messageText;
  final _firestore = FirebaseFirestore.instance;

  void getCurrentUser() async{
    try{
      //final user = await _auth.currentUser();
      var user = await _auth.currentUser ;
      if(user != null){
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch(e){
      print(e);
    }
  }

  void getMessages() async{
    final messages = await _firestore.collection('messages').get();
    for(var msg in messages.docs){
      print(msg.data());
    }
  }

  void messageStream() async {
    await for(var snapshot in _firestore.collection('messages').snapshots()){
      for(var msg in snapshot.docs){
        print("My Data: ${msg.data()}");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messageStream();
                //getMessages();
                // _auth.signOut();
                // Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email
                      });
                    },
                    child: Text('Send'),
                  )
                  // FlatButton(
                  //   onPressed: () {
                  //     //Implement send functionality.
                  //   },
                  //   child: Text(
                  //     'Send',
                  //     style: kSendButtonTextStyle,
                  //     //style: kSendButtonTextStyle,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
