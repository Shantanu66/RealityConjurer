// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reality_conjurer/home.dart';
import 'package:splashscreen/splashscreen.dart';

final Shader linearGradient = LinearGradient(
	colors: <Color>[Colors.pink, Colors.green],
).createShader(
	Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
);


class MySplash extends StatefulWidget {
  
  @override
  _MySplashState createState() => _MySplashState();
}


class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      title: Text(
        'REALITY CONJURER',
        style: TextStyle(
          shadows: <Shadow>[
            Shadow(
              offset: Offset(4.0, 5.0),
              blurRadius: 10.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ],
          fontWeight: FontWeight.bold,
          letterSpacing: 1.7,
          fontSize: 24,
          color: Colors.white,
        ),
        
      ),
      gradientBackground: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFF48FB1),
          Color(0xFFF06292),
          Color(0xFFEC407A),
          Color(0xFFE91E63),
          Color(0xFFD81B60),
        ],
      ),
      loaderColor: Colors.white,
    );
  }
}
