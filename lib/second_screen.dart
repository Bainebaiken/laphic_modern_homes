import 'package:flutter/material.dart';
import 'third_screen.dart'; // Import the ThirdScreen file

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/interior7.jpeg'), // Add your image asset here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.2)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    color: Colors.yellow,
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
                    backgroundColor: Colors.yellow, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 15),
                  ),
                  onPressed: () {
                    // Navigate to ThirdScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ThirdScreen()),
                    );
                  },
                  child: const Text(
                    "Let's Get Started",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navigate to ThirdScreen
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
        ],
      ),
    );
  }
}






// import 'package:flutter/material.dart';



// class SecondScreen extends StatelessWidget {
//   const SecondScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/interior7.jpeg'), // Add your image asset here
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
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Make your home the',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 34,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const Text(
//                   'most comfortable',
//                   style: TextStyle(
//                     color: Colors.yellow,
//                     fontSize: 31,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const Text(
//                   'place to live',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
                
//                 const SizedBox(height: 23),
//                 const Text(
//                   'Designing an interior design creatively and professionally\nspecifically for customers.',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 50),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.yellow, // Background color
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 15),
//                   ),
//                   onPressed: () {
//                     // Handle Get Started action
//                   },
//                   child: const Text(
//                     "Let's Get Started",
//                     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextButton(
//                   onPressed: () {
//                     // Handle Skip action
//                   },
//                   child: const Text(
//                     'Skip',
//                     style: TextStyle(color: Colors.white70, fontSize: 16),
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
