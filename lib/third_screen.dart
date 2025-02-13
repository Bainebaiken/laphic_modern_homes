import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:laphic_app/login_screen.dart';
import 'package:laphic_app/signup_screen.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  // Google Sign-In Function
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null; // User canceled sign-in
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Facebook Sign-In Function
  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    }
    return null;
  }

  // Apple Sign-In Function
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
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/painting 1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title text
                const Text(
                  'Discover Your Dream Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Login and Signup Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text('Login', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: const Text('Sign Up', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('or Login with', style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 20),
                // Social Media Login Buttons
                Column(
                  children: [
                    SocialLoginButton(
                      icon: Icons.email,
                      label: 'Continue with Google',
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      onPressed: () async {
                        await signInWithGoogle();
                      },
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      icon: Icons.apple,
                      label: 'Continue with Apple',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      onPressed: () async {
                        await signInWithApple();
                      },
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      icon: Icons.facebook,
                      label: 'Continue with Facebook',
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () async {
                        await signInWithFacebook();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: textColor),
      label: Text(
        label,
        style: TextStyle(color: textColor),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
      onPressed: onPressed,
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:laphic_app/login_screen.dart';

// import 'package:laphic_app/signup_screen.dart';


// class ThirdScreen extends StatelessWidget {
//   const ThirdScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/painting 1.jpg'), // Add your image asset here
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           // Gradient overlay for better text visibility
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.2)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           // Content
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Title text
//                 const Text(
//                   'Discover Your Dream Home',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 40),
//                 // Login and Signup buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Login button
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.black,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                         ),
//                         onPressed: () {
//                           // Navigate to LoginScreen
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => const LoginScreen()),
//                           );
//                         },
//                         child: const Text(
//                           'Login',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     // Signup button
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                         ),
//                         onPressed: () {
//                           // Navigate to SignUpScreen
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => const SignUpScreen()),
//                           );
//                         },
//                         child: const Text(
//                           'Sign Up',
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'or Login with',
//                   style: TextStyle(color: Colors.white70, fontSize: 14),
//                 ),
//                 const SizedBox(height: 20),
//                 // Social media login buttons
//                 Column(
//                   children: [
//                     SocialLoginButton(
//                       icon: Icons.email,
//                       label: 'Continue with Google',
//                       backgroundColor: Colors.white,
//                       textColor: Colors.black,
//                       onPressed: () {
//                         // Navigate to LoginScreen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const LoginScreen()),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 10),
//                     SocialLoginButton(
//                       icon: Icons.apple,
//                       label: 'Continue with Apple',
//                       backgroundColor: Colors.black,
//                       textColor: Colors.white,
//                       onPressed: () {
//                         // Navigate to LoginScreen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const LoginScreen()),
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 10),
//                     SocialLoginButton(
//                       icon: Icons.facebook,
//                       label: 'Continue with Facebook',
//                       backgroundColor: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: () {
//                         // Navigate to LoginScreen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const LoginScreen()),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
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
//       label: Text(
//         label,
//         style: TextStyle(color: textColor),
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



