import 'package:chat_app/constants/appConstants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/rounded_Button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class Registeration extends StatefulWidget {
  const Registeration({Key? key}) : super(key: key);

  static const String id = 'registeration';

  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {

  String email = '';
  String password = '';
  final _auth = FirebaseAuth.instance;
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loader,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                  // setState(){
                  //   email = value;
                  // }


                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email address'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                //style: TextStyle(color: Colors.black),
                decoration: kTextFieldDecoration,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                colour: Colors.blueAccent,
                onPressed: () async{
                  setState(() {
                    loader = true;
                  });
                  print(email);
                  print(password);
                  try{
                    final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if(newUser != null){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      loader = false;
                    });
                  }
                  catch(error){
                    print(error);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}