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
            color: Colors.black.withOpacity(0.5),
          ),
          // Login form
          Center(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
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
                      fillColor: Colors.black.withOpacity(0.5),
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
                      fillColor: Colors.black.withOpacity(0.5),
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
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
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
                          style: TextStyle(color: Colors.green),
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

// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Sign Up')),
//       body: Center(
//         child: const Text('Sign Up Screen Content Goes Here'),
//       ),
//     );
//   }
// }








// import 'package:flutter/material.dart';
// import 'package:laphic_app/signup_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginScreen(),
//     );
//   }
// }

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
//                 color: Colors.black.withOpacity(0.8),
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
//                       fillColor: Colors.black.withOpacity(0.5),
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
//                         style: TextStyle(color: Colors.green),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Login button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                       onPressed: () {
//                         // Handle Login action
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
//                           // Handle Sign Up navigation
                        
//                         child: const Text(
//                           "Sign up",
//                           style: TextStyle(color: Colors.green),
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

// class SignupScreen {
//   const SignupScreen();
// }
