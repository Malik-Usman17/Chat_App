import 'package:chat_app/screens/welcomeScreen.dart';
import 'package:flutter/material.dart';

void main () => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.greenAccent),
        )
      ),
      //home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen()
      },
    );
  }
}
