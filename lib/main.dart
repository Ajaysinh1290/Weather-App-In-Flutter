

import 'package:flutter/material.dart';
import 'package:weather_app/splash_screen.dart';

import 'home_page.dart';

void main() {
  runApp(MaterialApp(

    initialRoute: '/',
    debugShowCheckedModeBanner: false,
    routes: {
      '/':(context)=>SplashScreen(),
      '/home':(context)=>Home(),
    },
    theme: ThemeData(accentColor: Colors.grey[800]),
  ));
}
