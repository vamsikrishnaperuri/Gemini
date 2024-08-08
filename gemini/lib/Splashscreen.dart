import 'dart:async';
// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:lottie/lottie.dart';


class Splash extends StatefulWidget {
  const Splash ({super.key});

  @override
  State<Splash> createState() => _State();
}

class _State extends State<Splash> {

  void initState(){
    super.initState();
    startTimer();
  }

  startTimer(){
    var duration = Duration(seconds: 5);
    return Timer(duration,route);
  }

  route(){
    Navigator.pushReplacementNamed(context, 'welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.amber,
              Colors.amber.shade800,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
          child: content()
      ),
    );
  }

  Widget content() {
    return Center(
      child: Container(
        child: Lottie.asset("assets/Animationlottie.json",width: 1000),
      ),
    );
  }
}
