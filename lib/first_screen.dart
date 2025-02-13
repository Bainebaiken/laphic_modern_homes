import 'dart:async';
import 'package:flutter/material.dart';
import 'second_screen.dart';

class FirstSplashScreen extends StatefulWidget {
  const FirstSplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FirstSplashScreenState createState() => _FirstSplashScreenState();
}

class _FirstSplashScreenState extends State<FirstSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SecondScreen()),
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
          // Logo and Text Positioned at the Top
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100), // Adjust top padding as needed
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/sharif-removebg-preview.png', // Logo Image
                    height: 100,
                  ),
                  const SizedBox(height: 10),
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
          ),
        ],
      ),
    );
  }
}



// import 'dart:async'; // Import the Timer package
// import 'package:flutter/material.dart';
// import 'second_screen.dart'; // Import the SecondScreen file

// class FirstSplashScreen extends StatefulWidget {
//   const FirstSplashScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _FirstSplashScreenState createState() => _FirstSplashScreenState();
// }

// class _FirstSplashScreenState extends State<FirstSplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Set the timer for 1 minute (60 seconds)
//     Timer(const Duration(seconds: 10), () {
//       // Navigate to the SecondScreen after the timer ends
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
//                 image: AssetImage('assets/WhatsApp Image 2024-10-05 at 21.24.00_89194cc6.jpg'), // Add your building image here
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Logo Overlay
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/sharif-removebg-preview.png', // Add your logo image
//                   height: 100,
//                 ),
//                 const SizedBox(height: 10),
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






// // import 'package:flutter/material.dart';


// // class FirstSplashScreen extends StatelessWidget {
// //   const FirstSplashScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           // Background Image
// //           Container(
// //             decoration: const BoxDecoration(
// //               image: DecorationImage(
// //                 image: AssetImage('assets/WhatsApp Image 2024-10-05 at 21.24.00_89194cc6.jpg'), // Add your building image here
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //           ),
// //           // Logo Overlay
// //           Center(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Image.asset(
// //                   'assets/sharif-removebg-preview.png', // Add your logo image
// //                   height: 100,
// //                 ),
// //                 const SizedBox(height: 10),
// //                 const Text(
// //                   'Think it, we create it.',
// //                   style: TextStyle(
// //                     fontSize: 18,
// //                     color: Colors.white,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
