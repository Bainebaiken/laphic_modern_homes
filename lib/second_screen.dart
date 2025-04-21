





// import 'package:flutter/foundation.dart' show kDebugMode; // For debug logging
// import 'package:flutter/material.dart';
// import 'third_screen.dart'; // Import the ThirdScreen file

// class SecondScreen extends StatelessWidget {
//   const SecondScreen({Key? key}) : super(key: key); // Updated from super.key

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/SECOND PAGE.jpg'), // Ensure this is in pubspec.yaml
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Gradient overlay
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.2)],
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//               ),
//             ),
//           ),
//           // Content
//           SafeArea( // Added SafeArea to prevent overlap with system UI
//             child: Center(
//               child: SingleChildScrollView( // Added to handle overflow on small screens
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Make your home the',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 34,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const Text(
//                       'most comfortable',
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 233, 147, 17),
//                         fontSize: 31,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const Text(
//                       'place to live',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 23),
//                     const Text(
//                       'Designing an interior design creatively and professionally\nspecifically for customers.',
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 14,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 50),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(255, 190, 100, 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 15),
//                       ),
//                       onPressed: () {
//                         if (kDebugMode) print('Get Started button pressed');
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const ThirdScreen()),
//                         );
//                       },
//                       child: const Text(
//                         " Let's Get Started", // Shortened for brevity
//                         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextButton(
//                       onPressed: () {
//                         if (kDebugMode) print('Skip button pressed');
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const ThirdScreen()),
//                         );
//                       },
//                       child: const Text(
//                         'Skip',
//                         style: TextStyle(color: Colors.white70, fontSize: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'dart:ui'; // Required for ImageFilter
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'third_screen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/SECOND PAGE.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Glassmorphic (blurred glass) overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity here
            child: Container(
              color: Colors.black.withOpacity(0.2), // Slightly darken with transparent black
            ),
          ),

          // Gradient overlay (optional, to add depth)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.2),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Make your home the',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'most comfortable',
                      style: TextStyle(
                        color: Color.fromARGB(255, 233, 147, 17),
                        fontSize: 31,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'place to live',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 23),
                    const Text(
                      'Designing an interior design creatively and professionally\nspecifically for customers.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 190, 100, 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 15),
                      ),
                      onPressed: () {
                        if (kDebugMode) print('Get Started button pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ThirdScreen()),
                        );
                      },
                      child: const Text(
                        " Let's Get Started",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        if (kDebugMode) print('Skip button pressed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ThirdScreen()),
                        );
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
