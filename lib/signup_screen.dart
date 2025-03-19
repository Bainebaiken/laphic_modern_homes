// import 'package:flutter/material.dart';
// import 'package:laphic_app/login_screen.dart';
// import 'package:laphic_app/termsandconditions.dart'; // Ensure this path is correct

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
//                 image: AssetImage("assets/kit.jpg"), // Replace with your image path
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Black overlay for dimming the background
//           Container(
//             color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
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
//                     "Looks like you don't have an account.\nLet's create a new account for you.",
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 16,
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
//                   // Terms and Privacy Policy with clickable text
//                   RichText(
//                     text: TextSpan(
//                       text: "By selecting Agree and continue below,\nI agree to ",
//                       style: const TextStyle(color: Colors.white70, fontSize: 14),
//                       children: [
//                         WidgetSpan(
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => const TermsAndPrivacyScreen()),
//                               );
//                             },
//                             child: const Text(
//                               "Terms of Service ",
//                               style: TextStyle(color: Color.fromARGB(255, 113, 80, 7), fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         const TextSpan(text: "and "),
//                         WidgetSpan(
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => const TermsAndPrivacyScreen()),
//                               );
//                             },
//                             child: const Text(
//                               "Privacy Policy",
//                               style: TextStyle(color: Color.fromARGB(255, 123, 85, 9), fontWeight: FontWeight.bold),
//                             ),
//                           ),
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
//                         backgroundColor: const Color(0xFFF5A623), // Gold/Yellow
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                       onPressed: () {
//                         // Navigate to the LoginScreen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const LoginScreen(),
//                           ),
//                         );
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











import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:laphic_app/login_screen.dart';
import 'package:laphic_app/termsandconditions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> signUpUser() async {
    try {
      setState(() {
        _isLoading = true;
      });
      
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (kDebugMode) {
        print("Attempting to signup with email: $email");
      }
      
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill in all fields")),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Validate email format
      bool isValidEmail(String email) {
        return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
      }

      if (!isValidEmail(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid email address")),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      if (kDebugMode) {
        print("Sending request to API...");
      }
      final response = await http.post(
        Uri.parse("http://localhost:5000/api/v1/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          if (kDebugMode) {
            print("Request timed out");
          }
          return http.Response('{"message":"Connection timeout"}', 408);
        },
      );

      if (kDebugMode) {
        print("Response received. Status code: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("Response body: ${response.body}");
      }

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup Successful!")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        var errorMessage = "Signup Failed";
        try {
          var errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? errorMessage;
        } catch (e) {
          if (kDebugMode) {
            print("Error parsing response: $e");
          }
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$errorMessage (${response.statusCode})")),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception occurred: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/kit.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          Center(
            child: SingleChildScrollView(
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
                    const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Looks like you don't have an account.\nLet's create a new account for you.",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: emailController,
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
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
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
                                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: _isLoading ? null : signUpUser,
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                "Agree and continue",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
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