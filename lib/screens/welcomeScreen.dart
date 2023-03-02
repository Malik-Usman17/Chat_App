import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/registeration.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  //final String id = 'welcome_Screen';
  static const String id = 'welcome_Screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      //upperBound: 100.0, //value must be in between 0 to 1 when using curved animation
      duration: const Duration(seconds: 1),
      vsync: this, //reference the object made from the class in the class own code, we use the keyword 'this'
    );

    //parent means what animation will be applying to this CurvedAnimation
    //animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(controller);

    controller.forward();
    // controller.reverse(from: 1.0);
    // animation.addStatusListener((status) {
    //   print(status);
    //   if(status == AnimationStatus.completed){
    //     controller.reverse(from: 1.0);
    //   }
    //   else if(status == AnimationStatus.dismissed){
    //     controller.forward();
    //   }
    // });
    controller.addListener(() {
      setState(() {});
      print(controller.value);
      print(animation.value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.red.withOpacity(controller.value),
      //backgroundColor: Colors.white,
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: <Widget> [
                Hero(
                  tag: 'logo',
                  child: Container(
                    // height: animation.value * 100,
                    //height: controller.value,
                    height: 60.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                // const Text(
                //  // '${controller.value.toInt()}%',
                //   'Flash Chat',
                //   style: TextStyle(
                //     color: Colors.black54,
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //   ),
                // ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash',
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black
                      )
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Registeration.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
