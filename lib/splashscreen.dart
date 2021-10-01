// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';


class MySplash extends StatefulWidget {
  
  @override
  _MySplashState createState() => _MySplashState();
}

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      //navigateAfterSeconds: ,
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
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF90CAF9),
          Color(0xFF1E88E5),
          Color(0xFF1976D2),
          Color(0xFF1565C0),
        ],
      ),
      loaderColor: Colors.white,
    );
  }
}
