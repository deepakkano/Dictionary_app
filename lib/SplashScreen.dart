import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loginapp/SearchScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    timercontoler();
  }

  void timercontoler(){
    Timer.periodic(Duration(seconds: 5), (time){
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Searchscreen(),));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/splashicon.png", width: 180, height: 180),
            const SizedBox(height: 20),
            Text(
              "Shabdkosh",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 45,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "The more that you read, the more things you will know.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 40),
           LoadingAnimationWidget.twistingDots(
          leftDotColor: const Color(0xFF1A1A3F),
          rightDotColor: const Color(0xFFEA3799),
          size: 20,
        ),
          ],
        ),
      ),
    );
  }
}
