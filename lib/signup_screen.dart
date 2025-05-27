

// // import 'dart:ui';
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:laphic_app/login_screen.dart';
// // import 'package:laphic_app/termsandconditions.dart';

// // class SignUpScreen extends StatefulWidget {
// //   const SignUpScreen({Key? key}) : super(key: key);

// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _SignUpScreenState createState() => _SignUpScreenState();
// // }

// // class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
// //   final TextEditingController nameController = TextEditingController();
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController phoneController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //   final TextEditingController confirmPasswordController = TextEditingController();
// //   bool _isLoading = false;
// //   bool _obscurePassword = true;
// //   bool _obscureConfirmPassword = true;
// //   late AnimationController _animationController;
// //   late Animation<Offset> _slideAnimation;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _animationController = AnimationController(
// //       vsync: this,
// //       duration: const Duration(milliseconds: 800),
// //     );
// //     _slideAnimation = Tween<Offset>(
// //       begin: const Offset(0, 1),
// //       end: Offset.zero,
// //     ).animate(CurvedAnimation(
// //       parent: _animationController,
// //       curve: Curves.easeOutCubic,
// //     ));

// //     // Start animation with a slight delay for smoother effect
// //     Future.delayed(const Duration(milliseconds: 100), () {
// //       _animationController.forward();
// //     });
// //   }

// //   Future<void> signUpUser() async {
// //     setState(() {
// //       _isLoading = true;
// //     });

// //     String name = nameController.text.trim();
// //     String email = emailController.text.trim();
// //     String phone = phoneController.text.trim();
// //     String password = passwordController.text.trim();
// //     String confirmPassword = confirmPasswordController.text.trim();

// //     // Validate inputs
// //     if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
// //       _showMessage("Please fill in all fields");
// //       setState(() => _isLoading = false);
// //       return;
// //     }

// //     if (password != confirmPassword) {
// //       _showMessage("Passwords do not match");
// //       setState(() => _isLoading = false);
// //       return;
// //     }

// //     // Validate email format
// //     bool isValidEmail(String email) => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
// //     if (!isValidEmail(email)) {
// //       _showMessage("Please enter a valid email address");
// //       setState(() => _isLoading = false);
// //       return;
// //     }

// //     // Validate phone number (stricter regex: starts with + and 10-15 digits)
// //     bool isValidPhone(String phone) => RegExp(r'^\+\d{10,15}$').hasMatch(phone);
// //     if (!isValidPhone(phone)) {
// //       _showMessage("Please enter a valid phone number (e.g., +1234567890)");
// //       setState(() => _isLoading = false);
// //       return;
// //     }

// //     // Validate password strength (e.g., minimum 6 characters)
// //     if (password.length < 6) {
// //       _showMessage("Password must be at least 6 characters long");
// //       setState(() => _isLoading = false);
// //       return;
// //     }

// //     try {
// //       // Create user with Firebase Authentication
// //       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
// //         email: email,
// //         password: password,
// //       );

// //       // Update user profile with name
// //       await userCredential.user?.updateDisplayName(name);

// //       // Send email verification
// //       await userCredential.user?.sendEmailVerification();

// //       // Store user data in Firestore with default role 'user'
// //       await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
// //         'name': name,
// //         'email': email,
// //         'phone': phone,
// //         'role': 'user',
// //         'createdAt': FieldValue.serverTimestamp(),
// //       });

// //       // Show success message
// //       _showMessage("Signup successful! A verification email has been sent to $email. Please verify your email before logging in.");

// //       // Navigate to LoginScreen
// //       if (mounted) {
// //         Navigator.pushReplacement(
// //           context,
// //           PageRouteBuilder(
// //             pageBuilder: (_, __, ___) => const LoginScreen(),
// //             transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
// //           ),
// //         );
// //       }
// //     } on FirebaseAuthException catch (e) {
// //       String errorMessage = "Signup failed";
// //       switch (e.code) {
// //         case 'email-already-in-use':
// //           errorMessage = "This email is already registered.";
// //           break;
// //         case 'invalid-email':
// //           errorMessage = "Invalid email address.";
// //           break;
// //         case 'weak-password':
// //           errorMessage = "Password is too weak.";
// //           break;
// //         case 'operation-not-allowed':
// //           errorMessage = "Email/password accounts are not enabled.";
// //           break;
// //         default:
// //           errorMessage = e.message ?? "An unexpected error occurred.";
// //       }
// //       _showMessage(errorMessage);
// //     } catch (e) {
// //       _showMessage("An error occurred: $e");
// //     } finally {
// //       if (mounted) setState(() => _isLoading = false);
// //     }
// //   }

// //   void _showMessage(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(message),
// //         duration: const Duration(seconds: 4),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     nameController.dispose();
// //     emailController.dispose();
// //     phoneController.dispose();
// //     passwordController.dispose();
// //     confirmPasswordController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final double width = MediaQuery.of(context).size.width;
// //     final bool isWide = width > 600;
// //     const Color dirtyOrange = Color(0xFF8D5524);

// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           Container(
// //             decoration: const BoxDecoration(
// //               image: DecorationImage(
// //                 image: AssetImage("assets/kit.jpg"),
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //           ),
// //           BackdropFilter(
// //             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //             child: Container(color: Colors.black.withOpacity(0.3)),
// //           ),
// //           Center(
// //             child: SlideTransition(
// //               position: _slideAnimation,
// //               child: SingleChildScrollView(
// //                 child: Container(
// //                   width: isWide ? 500 : null,
// //                   margin: EdgeInsets.all(isWide ? 40 : 20),
// //                   padding: EdgeInsets.all(isWide ? 40 : 20),
// //                   decoration: BoxDecoration(
// //                     color: Colors.black.withOpacity(0.5),
// //                     borderRadius: BorderRadius.circular(15.0),
// //                     border: Border.all(color: Colors.white.withOpacity(0.2)),
// //                   ),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const Text(
// //                         "Sign up",
// //                         style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
// //                       ),
// //                       const SizedBox(height: 10),
// //                       const Text(
// //                         "Create an account to get started.",
// //                         style: TextStyle(color: Colors.white70, fontSize: 16),
// //                       ),
// //                       const SizedBox(height: 20),
// //                       _buildTextField(nameController, "Full Name", Icons.person, dirtyOrange),
// //                       const SizedBox(height: 15),
// //                       _buildTextField(emailController, "Email", Icons.email, dirtyOrange, keyboardType: TextInputType.emailAddress),
// //                       const SizedBox(height: 15),
// //                       _buildTextField(
// //                         phoneController,
// //                         "Phone Number (e.g., +1234567890)",
// //                         Icons.phone,
// //                         dirtyOrange,
// //                         keyboardType: TextInputType.phone,
// //                       ),
// //                       const SizedBox(height: 15),
// //                       _buildPasswordField(passwordController, "Password", _obscurePassword, () {
// //                         setState(() => _obscurePassword = !_obscurePassword);
// //                       }),
// //                       const SizedBox(height: 15),
// //                       _buildPasswordField(confirmPasswordController, "Confirm Password", _obscureConfirmPassword, () {
// //                         setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
// //                       }),
// //                       const SizedBox(height: 20),
// //                       _buildAgreementText(),
// //                       const SizedBox(height: 20),
// //                       _buildSubmitButton(),
// //                       const SizedBox(height: 10),
// //                       _buildLoginLink(),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildTextField(
// //     TextEditingController controller,
// //     String label,
// //     IconData icon,
// //     Color color, {
// //     TextInputType? keyboardType,
// //   }) {
// //     return TextField(
// //       controller: controller,
// //       style: const TextStyle(color: Colors.white),
// //       keyboardType: keyboardType,
// //       decoration: InputDecoration(
// //         labelText: label,
// //         prefixIcon: Icon(icon, color: Colors.white70),
// //         labelStyle: const TextStyle(color: Colors.white70),
// //         filled: true,
// //         fillColor: Colors.black.withOpacity(0.5),
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(10.0),
// //           borderSide: BorderSide.none,
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(10.0),
// //           borderSide: BorderSide(color: color),
// //         ),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(10.0),
// //           borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildPasswordField(
// //     TextEditingController controller,
// //     String label,
// //     bool obscureText,
// //     VoidCallback onToggle,
// //   ) {
// //     return TextField(
// //       controller: controller,
// //       obscureText: obscureText,
// //       style: const TextStyle(color: Colors.white),
// //       decoration: InputDecoration(
// //         labelText: label,
// //         prefixIcon: const Icon(Icons.lock, color: Colors.white70),
// //         labelStyle: const TextStyle(color: Colors.white70),
// //         suffixIcon: IconButton(
// //           icon: Icon(
// //             obscureText ? Icons.visibility : Icons.visibility_off,
// //             color: Colors.white70,
// //           ),
// //           onPressed: onToggle,
// //         ),
// //         filled: true,
// //         fillColor: Colors.black.withOpacity(0.5),
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(10.0),
// //           borderSide: BorderSide.none,
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(10.0),
// //           borderSide: const BorderSide(color: Color(0xFF8D5524)),
// //         ),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(10.0),
// //           borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildAgreementText() {
// //     return RichText(
// //       text: TextSpan(
// //         text: "By selecting Agree and continue, I agree to the ",
// //         style: const TextStyle(color: Colors.white70, fontSize: 14),
// //         children: [
// //           WidgetSpan(
// //             child: GestureDetector(
// //               onTap: () => Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const TermsAndPrivacyScreen()),
// //               ),
// //               child: const Text(
// //                 "Terms of Service",
// //                 style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
// //               ),
// //             ),
// //           ),
// //           const TextSpan(text: " and "),
// //           WidgetSpan(
// //             child: GestureDetector(
// //               onTap: () => Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const TermsAndPrivacyScreen()),
// //               ),
// //               child: const Text(
// //                 "Privacy Policy",
// //                 style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSubmitButton() {
// //     return SizedBox(
// //       width: double.infinity,
// //       child: ElevatedButton(
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: _isLoading ? Colors.grey : const Color(0xFF8D5524),
// //           padding: const EdgeInsets.symmetric(vertical: 15),
// //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
// //         ),
// //         onPressed: _isLoading ? null : signUpUser,
// //         child: _isLoading
// //             ? const CircularProgressIndicator(color: Colors.white)
// //             : const Text(
// //                 "Agree and continue",
// //                 style: TextStyle(color: Colors.white, fontSize: 16),
// //               ),
// //       ),
// //     );
// //   }

// //   Widget _buildLoginLink() {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: [
// //         const Text(
// //           "Already have an account? ",
// //           style: TextStyle(color: Colors.white70),
// //         ),
// //         GestureDetector(
// //           onTap: () => Navigator.push(
// //             context,
// //             MaterialPageRoute(builder: (_) => const LoginScreen()),
// //           ),
// //           child: const Text(
// //             "Log in",
// //             style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }







// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http/http.dart' as http;
// import 'package:laphic_app/login_screen.dart';
// import 'package:laphic_app/termsandconditions.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   bool _isLoading = false;
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//   late AnimationController _animationController;
//   late Animation<Offset> _slideAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeOutCubic,
//     ));

//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (mounted) _animationController.forward();
//     });
//   }

//   Future<void> signUpUser() async {
//     if (_isLoading) return;
//     setState(() => _isLoading = true);

//     String name = nameController.text.trim();
//     String email = emailController.text.trim();
//     String phone = phoneController.text.trim();
//     String password = passwordController.text.trim();
//     String confirmPassword = confirmPasswordController.text.trim();

//     // Validate inputs
//     if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
//       _showMessage("Please fill in all fields");
//       setState(() => _isLoading = false);
//       return;
//     }

//     if (password != confirmPassword) {
//       _showMessage("Passwords do not match");
//       setState(() => _isLoading = false);
//       return;
//     }

//     // Validate email format
//     bool isValidEmail(String email) => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
//     if (!isValidEmail(email)) {
//       _showMessage("Please enter a valid email address (e.g., user@example.com)");
//       setState(() => _isLoading = false);
//       return;
//     }

//     // Normalize and validate phone number
//     phone = phone.replaceAll(RegExp(r'\s+|-'), ''); // Remove spaces and hyphens
//     if (!phone.startsWith('+')) phone = '+$phone'; // Add + if missing
//     bool isValidPhone(String phone) => RegExp(r'^\+\d{10,15}$').hasMatch(phone);
//     if (!isValidPhone(phone)) {
//       _showMessage("Please enter a valid phone number (e.g., +1234567890)");
//       setState(() => _isLoading = false);
//       return;
//     }

//     // Validate password strength
//     bool isValidPassword(String password) =>
//         password.length >= 8 && RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$').hasMatch(password);
//     if (!isValidPassword(password)) {
//       _showMessage("Password must be at least 8 characters long and include letters and numbers");
//       setState(() => _isLoading = false);
//       return;
//     }

//     try {
//       // Create user with Firebase Authentication
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // Update user profile with name
//       await userCredential.user?.updateDisplayName(name);

//       // Send email verification
//       await userCredential.user?.sendEmailVerification();

//       // Store user data in Firestore
//       await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
//         'name': name,
//         'email': email,
//         'phone': phone,
//         'role': 'user',
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       // Optional: Sync with custom backend (uncomment if needed)
      
//       try {
//         final response = await http.post(
//           Uri.parse('http://127.0.0.1:5000/auth/register'),
//           headers: {'Content-Type': 'application/json'},
//           body: jsonEncode({'email': email, 'password': password, 'name': name, 'phone': phone}),
//         );
//         if (response.statusCode != 200) {
//           throw Exception('Backend sync failed: ${response.body}');
//         }
//       } catch (e) {
//         if (kDebugMode) print('Custom backend error: $e');
//         // Continue despite backend failure, as Firebase is primary
//       }
      

//       // Show verification prompt
//       if (mounted) {
//         await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Email Verification Required'),
//             content: Text(
//               'A verification email has been sent to $email. Please verify your email before logging in.',
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }

//       // Navigate to LoginScreen
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           PageRouteBuilder(
//             pageBuilder: (_, __, ___) => const LoginScreen(),
//             transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
//           ),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       String errorMessage = "Signup failed";
//       switch (e.code) {
//         case 'email-already-in-use':
//           errorMessage = "This email is already registered. Try logging in or use a different email.";
//           break;
//         case 'invalid-email':
//           errorMessage = "Invalid email address. Please check the format.";
//           break;
//         case 'weak-password':
//           errorMessage = "Password is too weak. Use at least 8 characters with letters and numbers.";
//           break;
//         case 'operation-not-allowed':
//           errorMessage = "Email/password accounts are not enabled. Contact support.";
//           break;
//         default:
//           errorMessage = e.message ?? "An unexpected error occurred.";
//       }
//       _showMessage(errorMessage);
//     } on SocketException {
//       _showMessage("No internet connection. Please check your network and try again.");
//     } catch (e) {
//       _showMessage("An error occurred: $e");
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   void _showMessage(String message) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 5),
//         action: SnackBarAction(
//           label: 'Dismiss',
//           onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     nameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     final bool isWide = width > 600;
//     const Color dirtyOrange = Color(0xFF8D5524);

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
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: Container(color: Colors.black.withOpacity(0.3)),
//           ),
//           if (_isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: const Center(child: CircularProgressIndicator(color: Colors.orange)),
//             ),
//           Center(
//             child: SlideTransition(
//               position: _slideAnimation,
//               child: SingleChildScrollView(
//                 child: Container(
//                   width: isWide ? 500 : null,
//                   margin: EdgeInsets.all(isWide ? 40 : 20),
//                   padding: EdgeInsets.all(isWide ? 40 : 20),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(15.0),
//                     border: Border.all(color: Colors.white.withOpacity(0.2)),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Sign up",
//                         style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 10),
//                       const Text(
//                         "Create an account to get started.",
//                         style: TextStyle(color: Colors.white70, fontSize: 16),
//                       ),
//                       const SizedBox(height: 20),
//                       _buildTextField(nameController, "Full Name", Icons.person, dirtyOrange),
//                       const SizedBox(height: 15),
//                       _buildTextField(emailController, "Email", Icons.email, dirtyOrange, keyboardType: TextInputType.emailAddress),
//                       const SizedBox(height: 15),
//                       _buildTextField(
//                         phoneController,
//                         "Phone Number (e.g., +1234567890)",
//                         Icons.phone,
//                         dirtyOrange,
//                         keyboardType: TextInputType.phone,
//                       ),
//                       const SizedBox(height: 15),
//                       _buildPasswordField(passwordController, "Password", _obscurePassword, () {
//                         setState(() => _obscurePassword = !_obscurePassword);
//                       }),
//                       const SizedBox(height: 15),
//                       _buildPasswordField(confirmPasswordController, "Confirm Password", _obscureConfirmPassword, () {
//                         setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
//                       }),
//                       const SizedBox(height: 20),
//                       _buildAgreementText(),
//                       const SizedBox(height: 20),
//                       _buildSubmitButton(),
//                       const SizedBox(height: 10),
//                       _buildLoginLink(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField(
//     TextEditingController controller,
//     String label,
//     IconData icon,
//     Color color, {
//     TextInputType? keyboardType,
//   }) {
//     return TextField(
//       controller: controller,
//       style: const TextStyle(color: Colors.white),
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.white70),
//         labelStyle: const TextStyle(color: Colors.white70),
//         filled: true,
//         fillColor: Colors.black.withOpacity(0.5),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(color: color),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
//         ),
//       ),
//     );
//   }

//   Widget _buildPasswordField(
//     TextEditingController controller,
//     String label,
//     bool obscureText,
//     VoidCallback onToggle,
//   ) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: const Icon(Icons.lock, color: Colors.white70),
//         labelStyle: const TextStyle(color: Colors.white70),
//         suffixIcon: IconButton(
//           icon: Icon(
//             obscureText ? Icons.visibility : Icons.visibility_off,
//             color: Colors.white70,
//           ),
//           onPressed: onToggle,
//         ),
//         filled: true,
//         fillColor: Colors.black.withOpacity(0.5),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: const BorderSide(color: Color(0xFF8D5524)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
//         ),
//       ),
//     );
//   }

//   Widget _buildAgreementText() {
//     return RichText(
//       text: TextSpan(
//         text: "By selecting Agree and continue, I agree to the ",
//         style: const TextStyle(color: Colors.white70, fontSize: 14),
//         children: [
//           WidgetSpan(
//             child: GestureDetector(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const TermsAndPrivacyScreen()),
//               ),
//               child: const Text(
//                 "Terms of Service and Privacy Policy",
//                 style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSubmitButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: _isLoading ? Colors.grey : const Color(0xFF8D5524),
//           padding: const EdgeInsets.symmetric(vertical: 15),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//         ),
//         onPressed: _isLoading ? null : signUpUser,
//         child: _isLoading
//             ? const CircularProgressIndicator(color: Colors.white)
//             : const Text(
//                 "Agree and continue",
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//       ),
//     );
//   }

//   Widget _buildLoginLink() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           "Already have an account? ",
//           style: TextStyle(color: Colors.white70),
//         ),
//         GestureDetector(
//           onTap: () => Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const LoginScreen()),
//           ),
//           child: const Text(
//             "Log in",
//             style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }




import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:laphic_app/login_screen.dart';
import 'package:laphic_app/termsandconditions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
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
  bool _obscureConfirmPassword = true;
  bool _isVerificationSent = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _animationController.forward();
    });
  }

  Future<void> signUpUser() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Validate inputs
    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showMessage("Please fill in all fields", isError: true);
      setState(() => _isLoading = false);
      return;
    }

    if (password != confirmPassword) {
      _showMessage("Passwords do not match", isError: true);
      setState(() => _isLoading = false);
      return;
    }

    // Validate email format
    bool isValidEmail(String email) => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
    if (!isValidEmail(email)) {
      _showMessage("Please enter a valid email address (e.g., user@example.com)", isError: true);
      setState(() => _isLoading = false);
      return;
    }

    // Normalize and validate phone number
    phone = phone.replaceAll(RegExp(r'\s+|-'), ''); // Remove spaces and hyphens
    if (!phone.startsWith('+')) phone = '+$phone'; // Add + if missing
    bool isValidPhone(String phone) => RegExp(r'^\+\d{10,15}$').hasMatch(phone);
    if (!isValidPhone(phone)) {
      _showMessage("Please enter a valid phone number (e.g., +1234567890)", isError: true);
      setState(() => _isLoading = false);
      return;
    }

    // Validate password strength
    bool isValidPassword(String password) =>
        password.length >= 8 && RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$').hasMatch(password);
    if (!isValidPassword(password)) {
      _showMessage("Password must be at least 8 characters long and include letters and numbers", isError: true);
      setState(() => _isLoading = false);
      return;
    }

    try {
      // Create user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user profile with name
      await userCredential.user?.updateDisplayName(name);

      // Send email verification with custom action code settings
      var actionCodeSettings = ActionCodeSettings(
        url: 'https://your-app-domain.com/verify-email', // Replace with your domain
        handleCodeInApp: true,
        iOSBundleId: 'com.yourcompany.laphicapp', // Replace with your iOS bundle ID
        androidPackageName: 'com.yourcompany.laphicapp', // Replace with your Android package name
        androidInstallApp: true,
        androidMinimumVersion: '12',
      );

      await userCredential.user?.sendEmailVerification(actionCodeSettings);

      // Store user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'role': 'user',
        'emailVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
        'lastVerificationSent': FieldValue.serverTimestamp(),
      });

      // Optional: Sync with custom backend
      try {
        final response = await http.post(
          Uri.parse('http://127.0.0.1:5000/auth/register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email, 
            'password': password, 
            'name': name, 
            'phone': phone,
            'emailVerified': false
          }),
        );
        if (response.statusCode != 200) {
          throw Exception('Backend sync failed: ${response.body}');
        }
      } catch (e) {
        if (kDebugMode) print('Custom backend error: $e');
        // Continue despite backend failure, as Firebase is primary
      }

      setState(() {
        _isVerificationSent = true;
        _isLoading = false;
      });

      // Show enhanced verification dialog
      if (mounted) {
        await _showVerificationDialog(email, userCredential.user!);
      }

    } on FirebaseAuthException catch (e) {
      String errorMessage = "Signup failed";
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "This email is already registered. Try logging in or use a different email.";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email address. Please check the format.";
          break;
        case 'weak-password':
          errorMessage = "Password is too weak. Use at least 8 characters with letters and numbers.";
          break;
        case 'operation-not-allowed':
          errorMessage = "Email/password accounts are not enabled. Contact support.";
          break;
        case 'network-request-failed':
          errorMessage = "Network error. Please check your internet connection and try again.";
          break;
        default:
          errorMessage = e.message ?? "An unexpected error occurred during signup.";
      }
      _showMessage(errorMessage, isError: true);
    } on SocketException {
      _showMessage("No internet connection. Please check your network and try again.", isError: true);
    } catch (e) {
      _showMessage("An unexpected error occurred: $e", isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _showVerificationDialog(String email, User user) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Row(
            children: [
              Icon(Icons.email_outlined, color: Colors.orange, size: 28),
              SizedBox(width: 10),
              Text(
                'Verify Your Email',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Laphic App! 🎉',
                style: TextStyle(
                  color: Colors.orange[300],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We\'ve sent a verification email to:',
                style: TextStyle(color: Colors.grey[300], fontSize: 14),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  email,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Please check your email and click the verification link to activate your account. You must verify your email before you can log in.',
                style: TextStyle(color: Colors.grey[300], fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                '📧 Don\'t forget to check your spam folder!',
                style: TextStyle(color: Colors.orange[200], fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await user.sendEmailVerification();
                  _showMessage("Verification email sent again!", isError: false);
                } catch (e) {
                  _showMessage("Failed to resend verification email", isError: true);
                }
              },
              child: const Text(
                'Resend Email',
                style: TextStyle(color: Colors.orange),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8D5524),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const LoginScreen(),
                    transitionsBuilder: (_, anim, __, child) => 
                        FadeTransition(opacity: anim, child: child),
                  ),
                );
              },
              child: const Text(
                'Go to Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message, {required bool isError}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: isError ? Colors.red[300] : Colors.green[300],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.red[700] : Colors.green[700],
        duration: Duration(seconds: isError ? 6 : 4),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
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
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.orange),
                    SizedBox(height: 16),
                    Text(
                      'Creating your account...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
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
                      const Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Create an account to get started.",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      if (_isVerificationSent) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green.withOpacity(0.5)),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green, size: 20),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Verification email sent! Check your inbox.",
                                  style: TextStyle(color: Colors.green, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                      _buildTextField(nameController, "Full Name", Icons.person, dirtyOrange),
                      const SizedBox(height: 15),
                      _buildTextField(emailController, "Email", Icons.email, dirtyOrange, keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 15),
                      _buildTextField(
                        phoneController,
                        "Phone Number (e.g., +1234567890)",
                        Icons.phone,
                        dirtyOrange,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 15),
                      _buildPasswordField(passwordController, "Password", _obscurePassword, () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      }),
                      const SizedBox(height: 15),
                      _buildPasswordField(confirmPasswordController, "Confirm Password", _obscureConfirmPassword, () {
                        setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                      }),
                      const SizedBox(height: 20),
                      _buildAgreementText(),
                      const SizedBox(height: 20),
                      _buildSubmitButton(),
                      const SizedBox(height: 10),
                      _buildLoginLink(),
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

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    Color color, {
    TextInputType? keyboardType,
  }) {
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
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: color),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    TextEditingController controller,
    String label,
    bool obscureText,
    VoidCallback onToggle,
  ) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock, color: Colors.white70),
        labelStyle: const TextStyle(color: Colors.white70),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.white70,
          ),
          onPressed: onToggle,
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFF8D5524)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
      ),
    );
  }

  Widget _buildAgreementText() {
    return RichText(
      text: TextSpan(
        text: "By selecting Agree and continue, I agree to the ",
        style: const TextStyle(color: Colors.white70, fontSize: 14),
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TermsAndPrivacyScreen()),
              ),
              child: const Text(
                "Terms of Service and Privacy Policy",
                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
              ),
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
          backgroundColor: _isLoading ? Colors.grey : const Color(0xFF8D5524),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onPressed: _isLoading ? null : signUpUser,
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "Agree and continue",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          ),
          child: const Text(
            "Log in",
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}