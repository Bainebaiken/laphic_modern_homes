import 'package:flutter/material.dart';
import 'package:laphic_app/login_screen.dart';
import 'package:laphic_app/termsandconditions.dart'; // Ensure this path is correct

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override   
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/interior3.jpeg"), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Black overlay for dimming the background
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Sign up form
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
                    "Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Subtitle
                  const Text(
                    "Looks like you don't have an account.\nLet's create a new account for you.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
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
                  // Terms and Privacy Policy with clickable text
                  RichText(
                    text: TextSpan(
                      text: "By selecting Agree and continue below,\nI agree to ",
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                      children: [
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const TermsAndPrivacyScreen()),
                              );
                            },
                            child: const Text(
                              "Terms of Service ",
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const TextSpan(text: "and "),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const TermsAndPrivacyScreen()),
                              );
                            },
                            child: const Text(
                              "Privacy Policy",
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Agree and Continue button
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
                        // Navigate to the LoginScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Agree and continue",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
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







// import 'package:flutter/material.dart';


// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/interior3.jpeg"), // Replace with your image path
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Black overlay for dimming the background
//           Container(
//             color: Colors.black.withOpacity(0.5),
//           ),
//           // Sign up form
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
//                     "Sign up",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Subtitle
//                   const Text(
//                     "Looks like you don't have an account.\nLet's create a new account for",
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
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
//                   // Terms and Privacy Policy
//                   RichText(
//                     text: const TextSpan(
//                       text: "By selecting Agree and continue below,\nI agree to ",
//                       style: TextStyle(color: Colors.white70, fontSize: 14),
//                       children: [
//                         TextSpan(
//                           text: "Terms of Service ",
//                           style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//                         ),
//                         TextSpan(text: "and "),
//                         TextSpan(
//                           text: "Privacy Policy",
//                           style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Agree and Continue button
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
//                         // Handle Agree and Continue action
//                       },
//                       child: const Text(
//                         "Agree and continue",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
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







