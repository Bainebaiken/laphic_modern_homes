

// //  below is the ccode for the splashscreen 

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'second_screen.dart';

// class FirstSplashScreen extends StatefulWidget {
//   const FirstSplashScreen({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _FirstSplashScreenState createState() => _FirstSplashScreenState();
// }

// class _FirstSplashScreenState extends State<FirstSplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 10), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const SecondScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/WhatsApp Image 2024-10-05 at 21.24.00_89194cc6.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Centered Logo and Text
//           Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image.asset(
//                   'assets/sharif-removebg-preview.png', // Logo Image
//                   height: 200, // Increased from 100 to 200 for better visibility
//                 ),
//                 const SizedBox(height: 15),
//                 const Text(
//                   'Think it, we create it.',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:laphic_app/second_screen.dart';


// First Splash Screen
class FirstSplashScreen extends StatefulWidget {
  const FirstSplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FirstSplashScreenState createState() => _FirstSplashScreenState();
}

class _FirstSplashScreenState extends State<FirstSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SecondSplashScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/WhatsApp Image 2024-10-05 at 21.24.00_89194cc6.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered Logo and Text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/sharif-removebg-preview.png', // Logo Image
                  height: 200,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Think it, we create it.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Second Splash Screen
class SecondSplashScreen extends StatefulWidget {
  const SecondSplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SecondSplashScreenState createState() => _SecondSplashScreenState();
}

class _SecondSplashScreenState extends State<SecondSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/INTERIOR.jpg'), // Add your second splash image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered Logo and Text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/sharif-removebg-preview.png', // Reuse logo or use a different one
                  height: 200,
                ),
                const SizedBox(height: 15),
                const Text(
                  'lets create heaven for u .',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}