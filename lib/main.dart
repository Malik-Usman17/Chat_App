import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registeration.dart';
import 'package:chat_app/screens/welcomeScreen.dart';
import 'package:flutter/material.dart';

void main () => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.greenAccent),
          titleMedium: TextStyle(color: Colors.black)  //text field typing text color
        ),
        hintColor: Colors.black38,
      ),
      //home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        Registeration.id: (context) => const Registeration()
      },
    );
  }
}
