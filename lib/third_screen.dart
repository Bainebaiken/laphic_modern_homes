


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:twitter_login/twitter_login.dart';
// import 'package:laphic_app/services.dart';
// import 'package:laphic_app/login_screen.dart';
// import 'package:laphic_app/signup_screen.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter/foundation.dart' show kDebugMode; // For debug logging

// class ThirdScreen extends StatelessWidget {
//   const ThirdScreen({Key? key}) : super(key: key); // Updated from super.key

//   Future<void> handleAuthResult(BuildContext context, Future<UserCredential?> authFunction) async {
//     try {
//       final userCredential = await authFunction;
//       if (userCredential != null) {
//         final idToken = await userCredential.user?.getIdToken();
//         if (kDebugMode) {
//           print('User signed in: ${userCredential.user?.uid}, Token: $idToken');
//         }
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => ServicesPage(token: idToken ?? '')),
//         );
//       } else {
//         if (kDebugMode) print('Authentication returned null');
//       }
//     } catch (e) {
//       if (kDebugMode) print('Auth error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Login failed: ${e.toString()}")),
//       );
//     }
//   }

//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) {
//         if (kDebugMode) print('Google sign-in canceled by user');
//         return null;
//       }
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     } catch (e) {
//       if (kDebugMode) print('Google sign-in error: $e');
//       rethrow;
//     }
//   }

//   Future<UserCredential?> signInWithFacebook() async {
//     try {
//       final LoginResult result = await FacebookAuth.instance.login();
//       if (result.status == LoginStatus.success && result.accessToken != null) {
//         final OAuthCredential facebookAuthCredential =
//             FacebookAuthProvider.credential(result.accessToken!.tokenString);
//         return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//       } else {
//         if (kDebugMode) print('Facebook login failed: ${result.status}, ${result.message}');
//         return null;
//       }
//     } catch (e) {
//       if (kDebugMode) print('Facebook sign-in error: $e');
//       rethrow;
//     }
//   }

//   Future<UserCredential?> signInWithTwitter() async {
//     try {
//       // Replace these with your actual Twitter API credentials
//       const twitterApiKey = "YOUR_TWITTER_API_KEY"; // Replace
//       const twitterApiSecret = "YOUR_TWITTER_API_SECRET"; // Replace
//       const redirectURI = "YOUR_REDIRECT_URI"; // Replace (e.g., laphicapp://callback)

//       final twitterLogin = TwitterLogin(
//         apiKey: twitterApiKey,
//         apiSecretKey: twitterApiSecret,
//         redirectURI: redirectURI,
//       );

//       final authResult = await twitterLogin.login();
//       if (authResult.status == TwitterLoginStatus.loggedIn &&
//           authResult.authToken != null &&
//           authResult.authTokenSecret != null) {
//         final credential = TwitterAuthProvider.credential(
//           accessToken: authResult.authToken!,
//           secret: authResult.authTokenSecret!,
//         );
//         return await FirebaseAuth.instance.signInWithCredential(credential);
//       } else {
//         if (kDebugMode) print('Twitter login failed: ${authResult.status}, ${authResult.errorMessage}');
//         return null;
//       }
//     } catch (e) {
//       if (kDebugMode) print('Twitter sign-in error: $e');
//       throw Exception("Twitter login failed: $e");
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
//                 image: AssetImage('assets/THIRD SCREEN.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.2)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Discover Your Dream Home',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 30),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                                 side: const BorderSide(color: Color(0xFF0A1F44)),
//                               ),
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                             ),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => const LoginScreen()),
//                               );
//                             },
//                             child: const Text('Login', style: TextStyle(color: Color(0xFF0A1F44))),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                                 side: const BorderSide(color: Color(0xFF0A1F44)),
//                               ),
//                               padding: const EdgeInsets.symmetric(vertical: 12),
//                             ),
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => const SignUpScreen()),
//                               );
//                             },
//                             child: const Text('Sign Up', style: TextStyle(color: Color(0xFF0A1F44))),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'or continue with',
//                       style: TextStyle(color: Colors.white70, fontSize: 14),
//                     ),
//                     const SizedBox(height: 15),
//                     SocialLoginButton(
//                       label: 'Continue with Google',
//                       backgroundColor: Colors.white,
//                       textColor: Colors.black,
//                       icon: FontAwesomeIcons.google,
//                       iconColor: Colors.red,
//                       onPressed: () => handleAuthResult(context, signInWithGoogle()),
//                     ),
//                     const SizedBox(height: 10),
//                     SocialLoginButton(
//                       label: 'Continue with Twitter',
//                       backgroundColor: Colors.black,
//                       textColor: Colors.white,
//                       icon: FontAwesomeIcons.twitter,
//                       iconColor: Colors.white,
//                       onPressed: () => handleAuthResult(context, signInWithTwitter()),
//                     ),
//                     const SizedBox(height: 10),
//                     SocialLoginButton(
//                       label: 'Continue with Facebook',
//                       backgroundColor: const Color(0xFF1877F2),
//                       textColor: Colors.white,
//                       icon: FontAwesomeIcons.facebook,
//                       iconColor: Colors.white,
//                       onPressed: () => handleAuthResult(context, signInWithFacebook()),
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

// class SocialLoginButton extends StatelessWidget {
//   final String label;
//   final Color backgroundColor;
//   final Color textColor;
//   final IconData icon;
//   final Color iconColor;
//   final VoidCallback onPressed;

//   const SocialLoginButton({
//     Key? key, // Updated from super.key
//     required this.label,
//     required this.backgroundColor,
//     required this.textColor,
//     required this.icon,
//     required this.iconColor,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 250,
//       child: ElevatedButton.icon(
//         icon: FaIcon(icon, color: iconColor),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         ),
//         onPressed: onPressed,
//         label: Text(label, style: TextStyle(color: textColor, fontSize: 14)),
//       ),
//     );
//   }
// }


import 'dart:ui'; // For ImageFilter
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:laphic_app/services.dart';
import 'package:laphic_app/login_screen.dart';
import 'package:laphic_app/signup_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  Future<void> handleAuthResult(BuildContext context, Future<UserCredential?> authFunction) async {
    try {
      final userCredential = await authFunction;
      if (userCredential != null) {
        final idToken = await userCredential.user?.getIdToken();
        if (kDebugMode) {
          print('User signed in: ${userCredential.user?.uid}, Token: $idToken');
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ServicesPage(token: idToken ?? '')),
        );
      } else {
        if (kDebugMode) print('Authentication returned null');
      }
    } catch (e) {
      if (kDebugMode) print('Auth error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.toString()}")),
      );
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        if (kDebugMode) print('Google sign-in canceled by user');
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      if (kDebugMode) print('Google sign-in error: $e');
      rethrow;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success && result.accessToken != null) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      } else {
        if (kDebugMode) print('Facebook login failed: ${result.status}, ${result.message}');
        return null;
      }
    } catch (e) {
      if (kDebugMode) print('Facebook sign-in error: $e');
      rethrow;
    }
  }

  Future<UserCredential?> signInWithTwitter() async {
    try {
      const twitterApiKey = "YOUR_TWITTER_API_KEY"; // Replace
      const twitterApiSecret = "YOUR_TWITTER_API_SECRET"; // Replace
      const redirectURI = "YOUR_REDIRECT_URI"; // Replace (e.g., laphicapp://callback)

      final twitterLogin = TwitterLogin(
        apiKey: twitterApiKey,
        apiSecretKey: twitterApiSecret,
        redirectURI: redirectURI,
      );

      final authResult = await twitterLogin.login();
      if (authResult.status == TwitterLoginStatus.loggedIn &&
          authResult.authToken != null &&
          authResult.authTokenSecret != null) {
        final credential = TwitterAuthProvider.credential(
          accessToken: authResult.authToken!,
          secret: authResult.authTokenSecret!,
        );
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        if (kDebugMode) print('Twitter login failed: ${authResult.status}, ${authResult.errorMessage}');
        return null;
      }
    } catch (e) {
      if (kDebugMode) print('Twitter sign-in error: $e');
      throw Exception("Twitter login failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/THIRD SCREEN.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Glassmorphic overlay: Blur + dim
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              color: Colors.black.withOpacity(0.25),
            ),
          ),

          // Optional gradient for extra depth
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Main content
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 142, 83, 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(color: Color.fromARGB(255, 181, 116, 5)),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                            },
                            child: const Text('Login', style: TextStyle(color: Color.fromARGB(255, 200, 200, 201))),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 164, 94, 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(color: Color.fromARGB(255, 146, 103, 2)),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: const Text('Sign Up', style: TextStyle(color: Color.fromARGB(255, 208, 209, 211))),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'or continue with',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 15),
                    SocialLoginButton(
                      label: 'Continue with Google',
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      icon: FontAwesomeIcons.google,
                      iconColor: Colors.red,
                      onPressed: () => handleAuthResult(context, signInWithGoogle()),
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      label: 'Continue with Twitter',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      icon: FontAwesomeIcons.twitter,
                      iconColor: Colors.white,
                      onPressed: () => handleAuthResult(context, signInWithTwitter()),
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      label: 'Continue with Facebook',
                      backgroundColor: const Color(0xFF1877F2),
                      textColor: Colors.white,
                      icon: FontAwesomeIcons.facebook,
                      iconColor: Colors.white,
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
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  const SocialLoginButton({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton.icon(
        icon: FaIcon(icon, color: iconColor),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        onPressed: onPressed,
        label: Text(label, style: TextStyle(color: textColor, fontSize: 14)),
      ),
    );
  }
}
