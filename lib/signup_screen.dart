
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:laphic_app/login_screen.dart';
// import 'package:laphic_app/termsandconditions.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

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
//   bool _obscurePassword = true; // Added for password visibility toggle

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
//         print("Attempting signup - Name: $name, Email: $email, Phone: $phone");
//       }

//       if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Please fill in all fields")),
//         );
//         return;
//       }

//       bool isValidEmail(String email) {
//         return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
//       }

//       if (!isValidEmail(email)) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Please enter a valid email address")),
//         );
//         return;
//       }

//       bool isValidPhone(String phone) {
//         return RegExp(r'^\+?1?\d{9,15}$').hasMatch(phone);
//       }

//       if (!isValidPhone(phone)) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Please enter a valid phone number")),
//         );
//         return;
//       }

//       const String apiUrl = "http://127.0.0.1:5000/auth/register";
//       final requestBody = jsonEncode({
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "password": password,
//         "user_type": "user",
//       });

//       if (kDebugMode) {
//         print("Request URL: $apiUrl");
//         print("Request Headers: {'Content-Type': 'application/json'}");
//         print("Request Body: $requestBody");
//       }

//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: requestBody,
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
//         String errorMessage = "Signup Failed";
//         try {
//           final errorData = jsonDecode(response.body) as Map<String, dynamic>;
//           errorMessage = errorData['error']?.toString() ?? errorMessage;
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
//     // Define "dirty orange" color
//     const Color dirtyOrange = Color(0xFF8D5524); // Custom shade, adjust as needed

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
//                           borderSide: const BorderSide(color: Colors.white70),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: const BorderSide(color: Colors.white70),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: const BorderSide(color: dirtyOrange),
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
//                           borderSide: const BorderSide(color: Colors.white70),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: const BorderSide(color: Colors.white70),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: const BorderSide(color: dirtyOrange),
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
//                           borderSide: const BorderSide(color: Colors.white70),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: const BorderSide(color: Colors.white70),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: const BorderSide(color: dirtyOrange),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: passwordController,
//                       obscureText: _obscurePassword, // Toggle visibility
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         labelText: "Password",
//                         labelStyle: const TextStyle(color: Colors.white70),
//                         filled: true,
//                         fillColor: Colors.black.withOpacity(0.5),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: const BorderSide(color: Colors.white70),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: const BorderSide(color: Colors.white70),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: const BorderSide(color: dirtyOrange),
//                         ),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscurePassword ? Icons.visibility : Icons.visibility_off,
//                             color: Colors.white70,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscurePassword = !_obscurePassword;
//                             });
//                           },
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
//                           backgroundColor: _isLoading ? Colors.grey : const Color.fromARGB(255, 158, 97, 5),
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

import 'dart:convert';
import 'dart:ui';

// ignore: unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:laphic_app/login_screen.dart';
import 'package:laphic_app/termsandconditions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  Future<void> signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showMessage("Please fill in all fields");
      setState(() => _isLoading = false);
      return;
    }

    if (password != confirmPassword) {
      _showMessage("Passwords do not match");
      setState(() => _isLoading = false);
      return;
    }

    bool isValidEmail(String email) => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(email);
    if (!isValidEmail(email)) {
      _showMessage("Please enter a valid email address");
      setState(() => _isLoading = false);
      return;
    }

    bool isValidPhone(String phone) => RegExp(r'^\+?1?\d{9,15}\$').hasMatch(phone);
    if (!isValidPhone(phone)) {
      _showMessage("Please enter a valid phone number");
      setState(() => _isLoading = false);
      return;
    }

    const String apiUrl = "http://127.0.0.1:5000/auth/register";
    final requestBody = jsonEncode({
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "user_type": "user",
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: requestBody,
    ).timeout(
      const Duration(seconds: 10),
      onTimeout: () => http.Response('{"error":"Connection timeout"}', 408),
    );

    if (response.statusCode == 201) {
      _showMessage("Signup Successful! Please login");
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginScreen(),
          transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
        ),
      );
    } else {
      String errorMessage = "Signup Failed";
      try {
        final errorData = jsonDecode(response.body) as Map<String, dynamic>;
        errorMessage = errorData['error']?.toString() ?? errorMessage;
      } catch (_) {}
      _showMessage(errorMessage);
    }

    setState(() => _isLoading = false);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isWide = width > 600;
    const Color dirtyOrange = Color(0xFF8D5524);

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
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          Center(
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                child: Container(
                  width: isWide ? 500 : null,
                  margin: EdgeInsets.all(isWide ? 40 : 20),
                  padding: EdgeInsets.all(isWide ? 40 : 20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Sign up", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text("Let's create an account for you.", style: TextStyle(color: Colors.white70, fontSize: 16)),
                      const SizedBox(height: 20),
                      _buildTextField(nameController, "Full Name", Icons.person, dirtyOrange),
                      const SizedBox(height: 15),
                      _buildTextField(emailController, "Email", Icons.email, dirtyOrange),
                      const SizedBox(height: 15),
                      _buildTextField(phoneController, "Phone Number", Icons.phone, dirtyOrange, keyboardType: TextInputType.phone),
                      const SizedBox(height: 15),
                      _buildPasswordField(passwordController, "Password"),
                      const SizedBox(height: 15),
                      _buildPasswordField(confirmPasswordController, "Confirm Password"),
                      const SizedBox(height: 20),
                      _buildAgreementText(),
                      const SizedBox(height: 20),
                      _buildSubmitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, Color color, {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.white70),
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: color),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      obscureText: _obscurePassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock, color: Colors.white70),
        labelStyle: const TextStyle(color: Colors.white70),
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off, color: Colors.white70),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildAgreementText() {
    return RichText(
      text: TextSpan(
        text: "By selecting Agree and continue below,\nI agree to ",
        style: const TextStyle(color: Colors.white70, fontSize: 14),
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TermsAndPrivacyScreen()),
              ),
              child: const Text("Terms of Service ", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            ),
          ),
          const TextSpan(text: "and "),
          WidgetSpan(
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TermsAndPrivacyScreen()),
              ),
              child: const Text("Privacy Policy", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _isLoading ? Colors.grey : const Color.fromARGB(255, 158, 97, 5),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onPressed: _isLoading ? null : signUpUser,
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text("Agree and continue", style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
