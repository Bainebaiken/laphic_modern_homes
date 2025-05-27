// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// // import 'package:laphic_app/first_screen.dart';
// // import 'package:laphic_app/booking.dart';
// // import 'package:laphic_app/admindashboard.dart';
// // import 'package:laphic_app/first_screen.dart';
// // import 'package:laphic_app/services.dart';
// import 'package:flutter/material.dart' hide CarouselController;

// // import 'package:laphic_app/inspiration_design.dart';
// // import 'package:laphic_app/construction.dart';
// // import 'package:laphic_app/gypsum_works.dart';

// import 'package:laphic_app/services.dart';
// // import 'package:laphic_app/second_screen.dart';
// // import 'package:laphic_app/third_screen.dart';


// // ignore: non_constant_identifier_names
// void main(dynamic DefaultFirebaseOptions) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }

// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'LAPHIC Modern Homes',
// //       // home: FirstSplashScreen(),
// //       home: ServicesPage(token: '',),
// //       // home: BookingScreen(),
// //       // home: DashboardScreen(),
// //     );
// //   }
// // }


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Services App',
//       theme: ThemeData(
//         primaryColor: const Color(0xFF080F2B),
//         scaffoldBackgroundColor: Colors.white,
//         useMaterial3: true,
//       ),
//       home: const ServicesHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }



// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:laphic_app/admindashboard.dart';
// // import 'package:laphic_app/metal_fabrication.dart';
// // import 'package:laphic_app/booking.dart';
// // import 'package:laphic_app/projects_designn.dart';
// // import 'package:laphic_app/feedback.dart';
// // import 'package:laphic_app/livechat.dart';
// // import 'package:laphic_app/services.dart';
// // import 'package:laphic_app/feedback_screen.dart'; // Import MainScreen
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   if (kIsWeb) {
//     await Firebase.initializeApp(
//       options: FirebaseOptions(
//         apiKey: DefaultFirebaseOptions.web.apiKey,
//         authDomain: DefaultFirebaseOptions.web.authDomain,
//         projectId: DefaultFirebaseOptions.web.projectId,
//         storageBucket: DefaultFirebaseOptions.web.storageBucket,
//         messagingSenderId: DefaultFirebaseOptions.web.messagingSenderId,
//         appId: DefaultFirebaseOptions.web.appId,
//       ),
//     );
//   } else {
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   }
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Laphic App',
//       theme: ThemeData(
//         primaryColor: const Color(0xFF080F2B),
//         scaffoldBackgroundColor: Colors.white,
//         useMaterial3: true,
//       ),
//       home: const AuthWrapper(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:laphic_app/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'admindashboard.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: DefaultFirebaseOptions.web.apiKey,
        authDomain: DefaultFirebaseOptions.web.authDomain,
        projectId: DefaultFirebaseOptions.web.projectId,
        storageBucket: DefaultFirebaseOptions.web.storageBucket,
        messagingSenderId: DefaultFirebaseOptions.web.messagingSenderId,
        appId: DefaultFirebaseOptions.web.appId,
      ),
    );
  } else {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
      child: MaterialApp(
        title: 'Laphic App',
        theme: ThemeData(
          primaryColor: const Color(0xFF080F2B),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF080F2B)),
            headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF080F2B)),
            bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF080F2B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
        ),
        home: const ServicesHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.init();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(child: Text('Initialization error: $e')),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userType;
  String? _userId; // Added userId
  bool _isLoading = false;
  String? _error;
  final String _baseUrl = 'http://127.0.0.1:5000';

  String get baseUrl => _baseUrl;
  String? get token => _token;
  String? get userType => _userType;
  String? get userId => _userId; // Expose userId
  bool get isAuthenticated => _token != null && _userType != null && ['admin', 'super_admin', 'provider'].contains(_userType);
  bool get isLoading => _isLoading;
  String? get error => _error;

  get userEmail => null;

  get email => null;

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      _userType = prefs.getString('user_type');
      _userId = prefs.getString('user_id'); // Load userId
      notifyListeners();
    } catch (e) {
      _error = 'Failed to initialize auth: $e';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        _token = data['token'] as String?;
        _userType = data['user']?['user_type'] as String?;
        _userId = data['user']?['id']?.toString(); // Store userId
        final prefs = await SharedPreferences.getInstance();
        if (_token != null) await prefs.setString('token', _token!);
        if (_userType != null) await prefs.setString('user_type', _userType!);
        if (_userId != null) await prefs.setString('user_id', _userId!); // Save userId
      } else {
        final errorBody = response.body.isNotEmpty ? jsonDecode(response.body) : {};
        throw Exception(errorBody['error'] ?? 'Login failed: ${response.statusCode}');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      _token = null;
      _userType = null;
      _userId = null; // Clear userId
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user_type');
      await prefs.remove('user_id'); // Remove userId
      notifyListeners();
    } catch (e) {
      _error = 'Logout failed: $e';
      notifyListeners();
    }
  }

  Future<dynamic> makeRequest({
    required String method,
    required String endpoint,
    Map<String, String>? headers,
    dynamic body,
    File? file,
    Map<String, String>? fields,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final client = http.Client();
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      headers = {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
        ...?headers,
      };

      http.Response response;
      if (file != null) {
        var request = http.MultipartRequest(method, uri)
          ..headers.addAll(headers)
          ..fields.addAll(fields ?? {})
          ..files.add(await http.MultipartFile.fromPath('file', file.path));
        response = await http.Response.fromStream(await request.send());
      } else if (method == 'GET') {
        response = await client.get(uri, headers: headers);
      } else if (method == 'POST') {
        response = await client.post(uri, headers: headers, body: jsonEncode(body));
      } else if (method == 'PUT') {
        response = await client.put(uri, headers: headers, body: jsonEncode(body));
      } else if (method == 'DELETE') {
        response = await client.delete(uri, headers: headers, body: body != null ? jsonEncode(body) : null);
      } else {
        throw Exception('Unsupported method');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body.isNotEmpty ? jsonDecode(response.body) : {};
      } else {
        final errorBody = response.body.isNotEmpty ? jsonDecode(response.body) : {};
        throw Exception(errorBody['message'] ?? 'Request failed: ${response.statusCode}');
      }
    } catch (e) {
      _error = e is SocketException ? 'No internet connection' : e.toString();
      return null;
    } finally {
      client.close();
      _isLoading = false;
      notifyListeners();
    }
  }
}