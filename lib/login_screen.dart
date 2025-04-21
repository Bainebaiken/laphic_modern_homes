// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:laphic_app/services.dart';
// import 'package:laphic_app/signup_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final storage = const FlutterSecureStorage();
//   bool isLoading = false;
//   bool obscurePassword = true;

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
//         Uri.parse("http://127.0.0.1:5000/auth/login"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"email": email, "password": password}),
//       );

//       if (!mounted) return;

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);

//         if (responseData.containsKey('token')) {
//           String token = responseData['token'];
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
//                 image: AssetImage("assets/login1.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: Container(
//               color: Colors.black.withOpacity(0.3),
//             ),
//           ),
//           Center(
//             child: SingleChildScrollView(
//               child: Container(
//                 margin: const EdgeInsets.all(20.0),
//                 padding: const EdgeInsets.all(20.0),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.5),
//                   borderRadius: BorderRadius.circular(15.0),
//                   border: Border.all(color: Colors.white.withOpacity(0.2)),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Login",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
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
//                       obscureText: obscurePassword,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         labelStyle: const TextStyle(color: Colors.white70),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             obscurePassword ? Icons.visibility : Icons.visibility_off,
//                             color: Colors.white70,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               obscurePassword = !obscurePassword;
//                             });
//                           },
//                         ),
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
//                           backgroundColor: const Color.fromARGB(255, 232, 132, 10),
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
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
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => const SignUpScreen()),
//                             );
//                           },
//                           child: const Text(
//                             "Sign up",
//                             style: TextStyle(color: Color.fromARGB(255, 213, 122, 4)),
//                           ),
//                         ),
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

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();

  bool isLoading = false;
  bool obscurePassword = true;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog("Please enter email and password.");
      setState(() => isLoading = false);
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:5000/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData.containsKey('token')) {
          await storage.write(key: 'auth_token', value: responseData['token']);
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ServicesPage(token: responseData['token'])),
            );
          }
        } else {
          _showErrorDialog("Invalid server response: Token not found");
        }
      } else {
        final responseData = jsonDecode(response.body);
        _showErrorDialog(responseData["error"] ?? "Login failed");
      }
    } catch (e) {
      _showErrorDialog("Connection error: $e");
    }

    if (mounted) setState(() => isLoading = false);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double padding = constraints.maxWidth > 600 ? 100 : 20;

          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/login1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(color: const Color.fromARGB(255, 41, 40, 40).withOpacity(0.6)),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 29, 29, 29).withOpacity(0.75),
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
                                prefixIcon: const Icon(Icons.email, color: Colors.white70),
                                labelStyle: const TextStyle(color: Colors.white70),
                                filled: true,
                                fillColor: const Color.fromARGB(255, 34, 33, 33).withOpacity(0.4),
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
                                prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscurePassword ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.white70,
                                  ),
                                  onPressed: () => setState(() => obscurePassword = !obscurePassword),
                                ),
                                labelStyle: const TextStyle(color: Colors.white70),
                                filled: true,
                                fillColor: const Color.fromARGB(255, 30, 29, 29).withOpacity(0.4),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 232, 132, 10),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(color: Color.fromARGB(255, 213, 122, 4)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
