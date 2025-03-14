import 'package:flutter/material.dart';
import 'package:laphic_app/services.dart';
import 'package:laphic_app/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/house5.jpeg"), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Black overlay for dimming the background
          Container(
            color: const Color.fromARGB(255, 53, 53, 57).withOpacity(0.5),
          ),
          // Login form
          Center(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 9, 45).withOpacity(0.8),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email field
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 13, 14, 14).withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password field
                  TextField(
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.white70),
                      suffixIcon: const Icon(Icons.visibility, color: Colors.white70),
                      filled: true,
                      fillColor: const Color.fromARGB(74, 75, 66, 66).withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Forgot Password link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle Forgot Password action
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Color.fromARGB(255, 7, 18, 38)), // Navy Blue
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5A623), // Gold/Yellow
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to ServicesPage after login
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ServicesPage()),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Sign up link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to SignupScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Color.fromARGB(255, 11, 31, 66)), // Navy Blue
                        ),
                      ),
                    ],
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






// import 'package:flutter/material.dart';
// import 'package:laphic_app/services.dart';
// import 'package:laphic_app/signup_screen.dart';



// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/house5.jpeg"), // Replace with your image path
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Black overlay for dimming the background
//           Container(
//             color: Colors.black.withOpacity(0.5),
//           ),
//           // Login form
//           Center(
//             child: Container(
//               margin: const EdgeInsets.all(20.0),
//               padding: const EdgeInsets.all(20.0),
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 46, 45, 45).withOpacity(0.8),
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Title
//                   const Text(
//                     "Login",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Email field
//                   TextField(
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: "Email",
//                       labelStyle: const TextStyle(color: Colors.white70),
//                       filled: true,
//                       fillColor: Colors.black.withOpacity(0.5),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Password field
//                   TextField(
//                     obscureText: true,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                       labelStyle: const TextStyle(color: Colors.white70),
//                       suffixIcon: const Icon(Icons.visibility, color: Colors.white70),
//                       filled: true,
//                       fillColor: const Color.fromARGB(74, 75, 66, 66).withOpacity(0.5),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Forgot Password link
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {
//                         // Handle Forgot Password action
//                       },
//                       child: const Text(
//                         "Forgot Password?",
//                         style: TextStyle(color: Color.fromARGB(255, 9, 23, 70)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Login button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(255, 152, 110, 19),
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                       onPressed: () {
//                         // Navigate to ServicesPage after login
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const ServicesPage()),
//                         );
//                       },
//                       child: const Text(
//                         "Login",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   // Sign up link
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Don't have an account?",
//                         style: TextStyle(color: Colors.white70),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           // Navigate to SignupScreen
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => const SignUpScreen()),
//                           );
//                         },
//                         child: const Text(
//                           "Sign up",
//                           style: TextStyle(color: Color.fromARGB(255, 22, 15, 83)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

