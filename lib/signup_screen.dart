// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:laphic_app/login_screen.dart';
// import 'package:laphic_app/termsandconditions.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _isLoading = false;

//   Future<void> signUpUser() async {
//     try {
//       setState(() {
//         _isLoading = true;
//       });

//       String name = nameController.text.trim();
//       String email = emailController.text.trim();
//       String phone = phoneController.text.trim();
//       String password = passwordController.text.trim();

//       if (kDebugMode) {
//         print("Attempting to signup with email: $email");
//       }

//       // Validate all required fields
//       if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Please fill in all fields")),
//         );
//         return;
//       }

//       // Validate email format
//       bool isValidEmail(String email) {
//         return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
//       }

//       if (!isValidEmail(email)) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Please enter a valid email address")),
//         );
//         return;
//       }

//       // Validate phone number (basic check)
//       bool isValidPhone(String phone) {
//         return RegExp(r'^\+?1?\d{9,15}$').hasMatch(phone);
//       }

//       if (!isValidPhone(phone)) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Please enter a valid phone number")),
//         );
//         return;
//       }

//       final response = await http.post(
//         Uri.parse("http://127.0.0.1:5000/auth/register"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "name": name,
//           "email": email,
//           "phone": phone,
//           "password": password,
//           "user_type": "customer" // Default value since it's required by backend
//         }),
//       ).timeout(
//         const Duration(seconds: 10),
//         onTimeout: () => http.Response('{"error":"Connection timeout"}', 408),
//       );

//       if (kDebugMode) {
//         print("Response status: ${response.statusCode}");
//         print("Response body: ${response.body}");
//       }

//       if (response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Signup Successful! Please login")),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginScreen()),
//         );
//       } else {
//         var errorMessage = "Signup Failed";
//         try {
//           var errorData = jsonDecode(response.body);
//           errorMessage = errorData['error'] ?? errorMessage;
//         } catch (e) {
//           if (kDebugMode) {
//             print("Error parsing response: $e");
//           }
//         }
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(errorMessage)),
//         );
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("Exception occurred: $e");
//       }
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("An error occurred. Please try again")),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/kit.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Container(color: const Color.fromARGB(255, 37, 35, 35).withOpacity(0.5)),
//           Center(
//             child: SingleChildScrollView(
//               child: Container(
//                 margin: const EdgeInsets.all(20.0),
//                 padding: const EdgeInsets.all(20.0),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.8),
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Sign up",
//                       style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       "Let's create an account for you.",
//                       style: TextStyle(color: Colors.white70, fontSize: 16),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: nameController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         labelText: "Full Name",
//                         labelStyle: const TextStyle(color: Colors.white70),
//                         filled: true,
//                         fillColor: Colors.black.withOpacity(0.5),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: emailController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         labelText: "Email",
//                         labelStyle: const TextStyle(color: Colors.white70),
//                         filled: true,
//                         fillColor: Colors.black.withOpacity(0.5),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: phoneController,
//                       style: const TextStyle(color: Colors.white),
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         labelText: "Phone Number",
//                         labelStyle: const TextStyle(color: Colors.white70),
//                         filled: true,
//                         fillColor: Colors.black.withOpacity(0.5),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: passwordController,
//                       obscureText: true,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         labelStyle: const TextStyle(color: Colors.white70),
//                         filled: true,
//                         fillColor: Colors.black.withOpacity(0.5),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     RichText(
//                       text: TextSpan(
//                         text: "By selecting Agree and continue below,\nI agree to ",
//                         style: const TextStyle(color: Colors.white70, fontSize: 14),
//                         children: [
//                           WidgetSpan(
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => const TermsAndPrivacyScreen()),
//                                 );
//                               },
//                               child: const Text(
//                                 "Terms of Service ",
//                                 style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           const TextSpan(text: "and "),
//                           WidgetSpan(
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => const TermsAndPrivacyScreen()),
//                                 );
//                               },
//                               child: const Text(
//                                 "Privacy Policy",
//                                 style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.orange,
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                         onPressed: _isLoading ? null : signUpUser,
//                         child: _isLoading
//                             ? const CircularProgressIndicator(color: Colors.white)
//                             : const Text(
//                                 " Agree and continue",
//                                 style: TextStyle(color: Colors.white, fontSize: 16),
//                               ),
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

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:laphic_app/login_screen.dart';
import 'package:laphic_app/termsandconditions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key); // Updated from super.key

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> signUpUser() async {
    try {
      setState(() {
        _isLoading = true;
      });

      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (kDebugMode) {
        print("Attempting signup - Name: $name, Email: $email, Phone: $phone");
      }

      // Validate all required fields
      if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill in all fields")),
        );
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
        return;
      }

      // Validate phone number (basic check)
      bool isValidPhone(String phone) {
        return RegExp(r'^\+?1?\d{9,15}$').hasMatch(phone);
      }

      if (!isValidPhone(phone)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid phone number")),
        );
        return;
      }

      // Replace with your actual backend URL
      const String apiUrl = "http://127.0.0.1:5000/auth/register"; 
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
          "user_type": "customer",
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => http.Response('{"error":"Connection timeout"}', 408),
      );

      if (kDebugMode) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      }

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup Successful! Please login")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        String errorMessage = "Signup Failed";
        try {
          final errorData = jsonDecode(response.body) as Map<String, dynamic>;
          errorMessage = errorData['error']?.toString() ?? errorMessage;
        } catch (e) {
          if (kDebugMode) {
            print("Error parsing response: $e");
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception occurred: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred. Please try again")),
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
          Container(color: const Color.fromARGB(255, 37, 35, 35).withOpacity(0.5)),
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
                      "Let's create an account for you.",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Full Name",
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
                      controller: phoneController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
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
                          backgroundColor: _isLoading ? Colors.grey : Colors.orange,
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}








