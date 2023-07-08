import 'package:flutter/material.dart';
import 'package:google_map_app/screens/homepage.dart';
import 'package:google_map_app/screens/login.dart';
import 'package:google_map_app/screens/map.dart';
import 'package:google_map_app/screens/register.dart';
import 'package:google_map_app/screens/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomePage(),
        '/map': (context) => MapPage(),
      //   '/data': (context) => AddDataPage(),
      //  '/mapscreen': (context) => MapScreen (),
      },
    );
  }
}









