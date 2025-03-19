// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:laphic_app/login_screen.dart';
// import 'package:laphic_app/signup_screen.dart';

// class ThirdScreen extends StatelessWidget {
//   const ThirdScreen({super.key});

//   // Google Sign-In Function
//   Future<UserCredential?> signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     if (googleUser == null) return null; 
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }

//   // Facebook Sign-In Function
//   Future<UserCredential?> signInWithFacebook() async {
//     final LoginResult result = await FacebookAuth.instance.login();
//     if (result.status == LoginStatus.success) {
//       final OAuthCredential facebookAuthCredential =
//           FacebookAuthProvider.credential(result.accessToken!.tokenString);
//       return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//     }
//     return null;
//   }

//   // Apple Sign-In Function
//   Future<UserCredential?> signInWithApple() async {
//     final appleCredential = await SignInWithApple.getAppleIDCredential(
//       scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
//     );
//     final oauthCredential = OAuthProvider("apple.com").credential(
//       idToken: appleCredential.identityToken,
//       accessToken: appleCredential.authorizationCode,
//     );
//     return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
//   }

//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Stack(
//       children: [
//         // Background Image
//         Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/painting 1.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         // Gradient overlay for better text visibility
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.2)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//         // Content
//         SafeArea(
//           child: Center( // Added Center widget here
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Title text
//                   const Text(
//                     'Discover Your Dream Home',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 40),
//                   // Login and Signup Buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color.fromARGB(255, 21, 22, 26), // Navy Blue
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 15),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => const LoginScreen()),
//                             );
//                           },
//                           child: const Text('Login', style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               side: const BorderSide(color: Color(0xFF0A1F44)), // Navy Blue Border
//                             ),
//                             padding: const EdgeInsets.symmetric(vertical: 15),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => const SignUpScreen()),
//                             );
//                           },
//                           child: const Text('Sign Up', style: TextStyle(color: Color(0xFF0A1F44))), // Navy Blue Text
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   const Center( // Added Center widget to ensure centering
//                     child: Text('or Login with', 
//                       style: TextStyle(color: Colors.white70, fontSize: 14),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Social Media Login Buttons
//                   Column(
//                     children: [
//                       SizedBox( // Added fixed width container for consistent button width
//                         width: double.infinity,
//                         child: SocialLoginButton(
//                           icon: Icons.email,
//                           label: 'Continue with Google',
//                           backgroundColor: Colors.white, // White Button
//                           textColor: Colors.black, // Black Text
//                           onPressed: () async {
//                             await signInWithGoogle();
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox( // Added fixed width container
//                         width: double.infinity,
//                         child: SocialLoginButton(
//                           icon: Icons.apple,
//                           label: 'Continue with Apple',
//                           backgroundColor: Colors.black, // Black Button
//                           textColor: Colors.white, // White Text
//                           onPressed: () async {
//                             await signInWithApple();
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       SizedBox( // Added fixed width container
//                         width: double.infinity,
//                         child: SocialLoginButton(
//                           icon: Icons.facebook,
//                           label: 'Continue with Facebook',
//                           backgroundColor: Color(0xFF1877F2), // Facebook Blue
//                           textColor: Colors.white, // White Text
//                           onPressed: () async {
//                             await signInWithFacebook();
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
// }

// class SocialLoginButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color backgroundColor;
//   final Color textColor;
//   final VoidCallback onPressed;

//   const SocialLoginButton({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.backgroundColor,
//     required this.textColor,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       icon: Icon(icon, color: textColor),
//       label: Expanded(
//         child: Text(
//           label,
//           style: TextStyle(color: textColor),
//           textAlign: TextAlign.center, // Center text horizontally
//         ),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: backgroundColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//       ),
//       onPressed: onPressed,
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:laphic_app/services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:laphic_app/login_screen.dart';
import 'package:laphic_app/signup_screen.dart';


class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  Future<void> handleAuthResult(BuildContext context, Future<UserCredential?> authFunction) async {
    try {
      final userCredential = await authFunction;
      if (userCredential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ServicesPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.toString()}")),
      );
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.tokenString);
      return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    }
    return null;
  }

  Future<UserCredential?> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/painting 1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Discover Your Dream Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Color(0xFF0A1F44)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text('Login', style: TextStyle(color: Color(0xFF0A1F44))),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Color(0xFF0A1F44)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: const Text('Sign Up', style: TextStyle(color: Color(0xFF0A1F44))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'or Login with',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 15),
                    SocialLoginButton(
                      label: 'Google',
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      onPressed: () => handleAuthResult(context, signInWithGoogle()),
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      label: 'Apple',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      onPressed: () => handleAuthResult(context, signInWithApple()),
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      label: 'Facebook',
                      backgroundColor: const Color(0xFF1877F2),
                      textColor: Colors.white,
                      onPressed: () => handleAuthResult(context, signInWithFacebook()),
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

class SocialLoginButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        onPressed: onPressed,
        child: Text(label, style: TextStyle(color: textColor)),
      ),
    );
  }
}
