import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:laphic_app/services.dart';
import 'package:laphic_app/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();
  bool isLoading = false;
  bool obscurePassword = true; // Added for password visibility toggle

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog("Please enter email and password.");
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:5000/api/v1/auth/login"), // Updated URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}), // Fixed key names
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        if (responseData.containsKey('token')) { // Updated to match Flask response
          String token = responseData['token'];
          
          await storage.write(key: 'auth_token', value: token);
          
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ServicesPage(token: token),
              ),
            );
          }
        } else {
          _showErrorDialog("Invalid server response: Token not found");
        }
      } else {
        try {
          final responseData = jsonDecode(response.body);
          _showErrorDialog(responseData["error"] ?? "Login failed with status: ${response.statusCode}");
        } catch (e) {
          _showErrorDialog("Login failed with status: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog("Connection error: ${e.toString()}");
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/hommie.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 53, 53, 57).withOpacity(0.5),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 29, 29, 31).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.5),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.white70),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 36, 35, 35).withOpacity(0.5),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 232, 147, 10),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: isLoading ? null : _login,
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Login", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?", style: TextStyle(color: Colors.white70)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(color: Color.fromARGB(255, 213, 133, 4)),
                          ),
                        ),
                      ],
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





// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:laphic_app/services.dart';
// import 'package:laphic_app/signup_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final storage = const FlutterSecureStorage();
//   bool isLoading = false;

//   Future<void> _login() async {
//     setState(() {
//       isLoading = true;
//     });

//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       _showErrorDialog("Please enter email and password.");
//       setState(() {
//         isLoading = false;
//       });
//       return;
//     }

//     try {
//       final response = await http.post(
//         Uri.parse("http://127.0.0.1:5000/api/v1/auth/login"), 
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"Email": email, "Password": password}),
//       );

//       // Check if widget is still mounted before proceeding
//       if (!mounted) return;

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
        
//         // Check if access_token exists in the response
//         if (responseData.containsKey('access_token')) {
//           String token = responseData['access_token'];
          
//           // Store the token securely
//           await storage.write(key: 'auth_token', value: token);
          
//           if (mounted) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ServicesPage(token: token),
//               ),
//             );
//           }
//         } else {
//           _showErrorDialog("Invalid server response: Token not found");
//         }
//       } else {
//         // Try to parse error message from response body
//         try {
//           final responseData = jsonDecode(response.body);
//           _showErrorDialog(responseData["error"] ?? "Login failed with status: ${response.statusCode}");
//         } catch (e) {
//           _showErrorDialog("Login failed with status: ${response.statusCode}");
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         _showErrorDialog("Connection error: ${e.toString()}");
//       }
//     }

//     if (mounted) {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Error"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Clean up controllers when the widget is disposed
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/hommie.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Container(
//             color: const Color.fromARGB(255, 53, 53, 57).withOpacity(0.5),
//           ),
//           Center(
//             child: SingleChildScrollView(
//               child: Container(
//                 margin: const EdgeInsets.all(20.0),
//                 padding: const EdgeInsets.all(20.0),
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 29, 29, 31).withOpacity(0.8),
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text("Login", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         labelText: "Email",
//                         labelStyle: const TextStyle(color: Colors.white70),
//                         filled: true,
//                         fillColor: Colors.black.withOpacity(0.5),
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
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
//                         suffixIcon: const Icon(Icons.visibility, color: Colors.white70),
//                         filled: true,
//                         fillColor: Colors.black.withOpacity(0.5),
//                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color.fromARGB(255, 232, 147, 10),
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//                         ),
//                         onPressed: isLoading ? null : _login,
//                         child: isLoading
//                             ? const CircularProgressIndicator(color: Colors.white)
//                             : const Text("Login", style: TextStyle(color: Colors.white, fontSize: 16)),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don't have an account?", style: TextStyle(color: Colors.white70)),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
//                           },
//                           child: const Text("Sign up", style: TextStyle(color: Color.fromARGB(255, 213, 133, 4)))),
//                       ],
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