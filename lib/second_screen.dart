
// import 'dart:ui'; // Required for ImageFilter
// import 'package:flutter/foundation.dart' show kDebugMode;
// import 'package:flutter/material.dart';
// import 'third_screen.dart';

// class SecondScreen extends StatelessWidget {
//   const SecondScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/SECOND PAGE.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           // Glassmorphic (blurred glass) overlay
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity here
//             child: Container(
//               color: Colors.black.withOpacity(0.2), // Slightly darken with transparent black
//             ),
//           ),

//           // Gradient overlay (optional, to add depth)
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.black.withOpacity(0.6),
//                   Colors.black.withOpacity(0.2),
//                 ],
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//               ),
//             ),
//           ),

//           // Main Content
//           SafeArea(
//             child: Center(
//               child: SingleChildScrollView(
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
//                           MaterialPageRoute(builder: (context) => const ZeroScreen()),
//                         );
//                       },
//                       child: const Text(
//                         " Let's Get Started",
//                         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextButton(
//                       onPressed: () {
//                         if (kDebugMode) print('Skip button pressed');
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const ZeroScreen()),
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
import 'package:laphic_app/third_screen.dart';


// OnboardingScreen manages the PageView for the three onboarding screens
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToMain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ThirdScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: const [
              FirstScreen(),
              SecondScreen(),
              ZeroScreen(),
            ],
          ),
          // Page indicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color.fromARGB(255, 190, 100, 16)
                        : Colors.white70,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// First Onboarding Screen
class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/IMG-20250324-WA0034.jpg'), // Add your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Glassmorphic overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          // Gradient overlay
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
                      'Welcome to Your',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'Dream Home',
                      style: TextStyle(
                        color: Color.fromARGB(255, 233, 147, 17),
                        fontSize: 31,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'Design',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 23),
                    const Text(
                      'Explore creative and professional interior design solutions.',
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
                        if (kDebugMode) print('Continue button pressed');
                        (context.findAncestorStateOfType<_OnboardingScreenState>())?._nextPage();
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        if (kDebugMode) print('Skip button pressed');
                        (context.findAncestorStateOfType<_OnboardingScreenState>())?._skipToMain();
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

// Second Onboarding Screen
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
                image: AssetImage('assets/IMG-20250324-WA0034.jpg'), // Add your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Glassmorphic overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          // Gradient overlay
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
                      'Transform Your',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'Living Space',
                      style: TextStyle(
                        color: Color.fromARGB(255, 233, 147, 17),
                        fontSize: 31,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'with Ease',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 23),
                    const Text(
                      'Personalized designs to match your style and needs.',
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
                        if (kDebugMode) print('Continue button pressed');
                        (context.findAncestorStateOfType<_OnboardingScreenState>())?._nextPage();
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        if (kDebugMode) print('Skip button pressed');
                        (context.findAncestorStateOfType<_OnboardingScreenState>())?._skipToMain();
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

// Third Onboarding Screen (Original SecondScreen modified)
class ZeroScreen extends StatelessWidget {
  const ZeroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Glassmorphic overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          // Gradient overlay
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const ThirdScreen()),
                        );
                      },
                      child: const Text(
                        "Let's Get Started",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        if (kDebugMode) print('Skip button pressed');
                        Navigator.pushReplacement(
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
