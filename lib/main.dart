import 'package:flutter/material.dart';
import 'package:laphic_app/first_screen.dart';
// import 'package:laphic_app/inspiration_design.dart';
// import 'package:laphic_app/construction.dart';
// import 'package:laphic_app/gypsum_works.dart';

// import 'package:laphic_app/services.dart';
// import 'package:laphic_app/second_screen.dart';
// import 'package:laphic_app/third_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LAPHIC Modern Homes',
      home: FirstSplashScreen(),
      // home: SecondScreen(),
      // home: ThirdScreen(),
      // home: ServicesPage(),
      // home: ConstructionPage(),
      // home: InspirationHall(),
    );
  }
}
