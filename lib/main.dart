import 'package:flutter/material.dart';
// import 'package:laphic_app/booking.dart';
// import 'package:laphic_app/admindashboard.dart';
// import 'package:laphic_app/first_screen.dart';
import 'package:laphic_app/services.dart';
import 'package:flutter/material.dart' hide CarouselController;

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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LAPHIC Modern Homes',
      // home: FirstSplashScreen(),
      home: ServicesPage(token: '',),
      // home: BookingScreen(),
      // home: DashboardScreen(),
    );
  }
}
