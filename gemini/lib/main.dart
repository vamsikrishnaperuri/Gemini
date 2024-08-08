import 'package:flutter/material.dart';
import 'Splashscreen.dart';
import 'mybot.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/':(context) => const Splash(),
       'welcome' :(context) => const Center(
           child: Chatbot()),
    },
  ));

}