// import 'package:flutter/material.dart';
// import 'package:laphic_app/booking.dart';

// import 'package:laphic_app/projects_designn.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:laphic_app/services.dart';


// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;
//   final storage = const FlutterSecureStorage();
//   String? token;
//   bool _isLoading = true;

//   // List of screens for navigation
//   late List<Widget> _pages;

//   @override
//   void initState() {
//     super.initState();
//     _loadToken();
//   }

//   // Load token from secure storage
//   Future<void> _loadToken() async {
//     // Try to get token from secure storage
//     token = await storage.read(key: 'auth_token');
    
//     // Initialize pages after getting token
//     setState(() {
//       _pages = [
//         const FeedbackInquiryScreen(),
//         ServicesPage(token: token ?? ''), // Provide token or empty string if null
//         const OngoingProjects(),
//         const BookingScreen(),
//       ];
//       _isLoading = false;
//     });
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Show loading indicator while token is being loaded
//     if (_isLoading) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed, // Important for more than 3 items
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.feedback),
//             label: "Feedback",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_repair_service),
//             label: "Services",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.construction),
//             label: "Projects",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book_online),
//             label: "Booking",
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FeedbackInquiryScreen extends StatefulWidget {
//   const FeedbackInquiryScreen({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _FeedbackInquiryScreenState createState() => _FeedbackInquiryScreenState();
// }

// class _FeedbackInquiryScreenState extends State<FeedbackInquiryScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _commentsController = TextEditingController();
//   int _rating = 0;

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _commentsController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Contact & Feedback'),
//         backgroundColor: Colors.orange,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Map Section
//               Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: const DecorationImage(
//                     image: AssetImage('assets/location.JPG'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),

//               // Contact Information
//               const Row(
//                 children: [
//                   Icon(Icons.location_pin, color: Colors.red),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'Kitende, Entebbe Road, Kampala, Uganda',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               const Row(
//                 children: [
//                   Icon(Icons.phone, color: Colors.green),
//                   SizedBox(width: 8),
//                   Text(
//                     '+256 705029291',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               const Row(
//                 children: [
//                   Icon(Icons.email, color: Colors.blue),
//                   SizedBox(width: 8),
//                   Text(
//                     'laphicmodernhomes@gmail.com',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // Inquiry / Feedback Title
//               const Text(
//                 'Inquiry / Feedback',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),

//               // Name Field
//               TextField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 10),

//               // Comments Field
//               TextField(
//                 controller: _commentsController,
//                 maxLines: 4,
//                 decoration: const InputDecoration(
//                   labelText: 'Comments',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Rate Us Section
//               const Text(
//                 'Rate us:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: List.generate(5, (index) {
//                   return IconButton(
//                     icon: Icon(
//                       index < _rating ? Icons.star : Icons.star_border,
//                       color: Colors.orange,
//                       size: 30,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _rating = index + 1;
//                       });
//                     },
//                   );
//                 }),
//               ),
//               const SizedBox(height: 20),

//               // Submit Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Validate inputs
//                     if (_nameController.text.isEmpty || _commentsController.text.isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Please fill in all fields')),
//                       );
//                       return;
//                     }
                    
//                     // Submit feedback
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Feedback submitted successfully!')),
//                     );
                    
//                     // Clear form
//                     _nameController.clear();
//                     _commentsController.clear();
//                     setState(() {
//                       _rating = 0;
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'Submit',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/foundation.dart' show kDebugMode;
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:laphic_app/booking.dart';
// import 'package:laphic_app/projects_designn.dart';
// import 'package:laphic_app/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;
//   final storage = const FlutterSecureStorage();
//   String? token;
//   bool _isLoading = true;

//   List<Widget> _pages = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadToken();
//   }

//   Future<void> _loadToken() async {
//     setState(() => _isLoading = true);
//     token = await storage.read(key: 'auth_token');
//     if (kDebugMode) print('Token loaded: $token');

//     setState(() {
//       _pages = [
//         const FeedbackInquiryScreen(),
//         ServicesPage(token: token ?? ''),
//         const OngoingProjects(),
//         const BookingScreen(),
//       ];
//       _isLoading = false;
//     });

//     if (token == null && mounted) {
//       Navigator.of(context).pushReplacementNamed('/login');
//     }
//   }

//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange))),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Laphic App', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//         elevation: 0,
//       ),
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.grey,
//         backgroundColor: const Color.fromARGB(255, 3, 7, 24),
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
//           BottomNavigationBarItem(icon: Icon(Icons.home_repair_service), label: "Services"),
//           BottomNavigationBarItem(icon: Icon(Icons.construction), label: "Projects"),
//           BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Booking"),
//         ],
//       ),
//     );
//   }
// }

// class FeedbackInquiryScreen extends StatefulWidget {
//   const FeedbackInquiryScreen({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _FeedbackInquiryScreenState createState() => _FeedbackInquiryScreenState();
// }

// class _FeedbackInquiryScreenState extends State<FeedbackInquiryScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _commentsController = TextEditingController();
//   int _rating = 0;
//   int _hoverRating = 0;
//   final Completer<GoogleMapController> _mapController = Completer();

//   static const LatLng _laphicLocation = LatLng(0.2279, 32.5325);

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _commentsController.dispose();
//     super.dispose();
//   }

//   bool _isValidEmail(String email) {
//     return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
//   }

//   void _submitFeedback() {
//     if (_nameController.text.isEmpty || 
//         _emailController.text.isEmpty || 
//         _commentsController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill in all fields'), backgroundColor: Colors.red),
//       );
//       return;
//     }

//     if (!_isValidEmail(_emailController.text)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter a valid email'), backgroundColor: Colors.red),
//       );
//       return;
//     }

//     if (kDebugMode) {
//       print('Feedback: Name: ${_nameController.text}, Email: ${_emailController.text}, Comments: ${_commentsController.text}, Rating: $_rating');
//     }

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text('Feedback submitted successfully!'),
//         backgroundColor: Colors.green,
//         action: SnackBarAction(label: 'OK', onPressed: () {}, textColor: Colors.white),
//       ),
//     );

//     _nameController.clear();
//     _emailController.clear();
//     _commentsController.clear();
//     setState(() => _rating = 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: const Color.fromARGB(255, 247, 248, 249),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildMap(),
//                 const SizedBox(height: 20),
//                 _buildContactInfo(),
//                 const SizedBox(height: 30),
//                 const Text(
//                   'Inquiry / Feedback',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 202, 126, 4)),
//                 ),
//                 const SizedBox(height: 20),
//                 _buildForm(),
//                 const SizedBox(height: 20),
//                 _buildRatingSection(),
//                 const SizedBox(height: 30),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _submitFeedback,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange,
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       elevation: 5,
//                     ),
//                     child: const Text('Submit', style: TextStyle(fontSize: 16, color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMap() {
//     return SizedBox(
//       height: 200,
//       child: GoogleMap(
//         onMapCreated: (GoogleMapController controller) {
//           _mapController.complete(controller);
//           if (kDebugMode) print('Map created successfully');
//         },
//         initialCameraPosition: const CameraPosition(
//           target: _laphicLocation,
//           zoom: 15,
//         ),
//         markers: {
//           const Marker(
//             markerId: MarkerId('laphic'),
//             position: _laphicLocation,
//             infoWindow: InfoWindow(title: 'Laphic Modern Homes'),
//           ),
//         },
//       ),
//     );
//   }

//   Widget _buildContactInfo() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             _buildContactRow(Icons.location_pin, 'Kitende, Entebbe Road, Kampala, Uganda', const Color.fromARGB(255, 224, 141, 7)),
//             const SizedBox(height: 10),
//             _buildContactRow(Icons.phone, '+256 705029291', const Color.fromARGB(255, 231, 147, 4)),
//             const SizedBox(height: 10),
//             _buildContactRow(Icons.email, 'laphicmodernhomes@gmail.com', const Color.fromARGB(255, 198, 127, 19)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContactRow(IconData icon, String text, Color iconColor) {
//     return Row(
//       children: [
//         Icon(icon, color: iconColor, size: 24),
//         const SizedBox(width: 12),
//         Expanded(child: Text(text, style: const TextStyle(fontSize: 16, color: Colors.black87))),
//       ],
//     );
//   }

//   Widget _buildForm() {
//     return Column(
//       children: [
//         TextField(
//           controller: _nameController,
//           decoration: InputDecoration(
//             labelText: 'Name',
//             labelStyle: const TextStyle(color: Colors.white),
//             filled: true,
//             fillColor: Colors.white.withOpacity(0.2),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.orange),
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           style: const TextStyle(color: Colors.white),
//         ),
//         const SizedBox(height: 15),
//         TextField(
//           controller: _emailController,
//           decoration: InputDecoration(
//             labelText: 'Email',
//             labelStyle: const TextStyle(color: Color.fromARGB(255, 32, 31, 31)),
//             filled: true,
//             fillColor: const Color.fromARGB(255, 27, 26, 26).withOpacity(0.2),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.orange),
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           style: const TextStyle(color: Color.fromARGB(255, 10, 10, 10)),
//           keyboardType: TextInputType.emailAddress,
//         ),
//         const SizedBox(height: 15),
//         TextField(
//           controller: _commentsController,
//           maxLines: 4,
//           decoration: InputDecoration(
//             labelText: 'Comments',
//             labelStyle: const TextStyle(color: Color.fromARGB(255, 15, 15, 15)),
//             filled: true,
//             fillColor: Colors.white.withOpacity(0.2),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.orange),
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           style: const TextStyle(color: Colors.white),
//         ),
//       ],
//     );
//   }

//   Widget _buildRatingSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Rate us:',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 189, 101, 7)),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           children: List.generate(5, (index) {
//             return GestureDetector(
//               onTap: () => setState(() => _rating = index + 1),
//               child: MouseRegion(
//                 onEnter: (_) => setState(() => _hoverRating = index + 1),
//                 onExit: (_) => setState(() => _hoverRating = 0),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   child: Icon(
//                     (index < _rating || index < _hoverRating) ? Icons.star : Icons.star_border,
//                     color: Colors.orange,
//                     size: 36,
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//         if (_rating > 0) ...[
//           const SizedBox(height: 10),
//           Text(
//             'You rated us $_rating star${_rating == 1 ? '' : 's'}!',
//             style: const TextStyle(color: Color.fromARGB(234, 246, 244, 244), fontSize: 16),
//           ),
//         ],
//       ],
//     );
//   }
// }
  

  //  below is the  code for the feedback screen 

import 'dart:async';
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';
import 'package:laphic_app/login_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isLoading = true;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    setState(() => _isLoading = true);
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null || !user.emailVerified) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } else {
      setState(() {
        _pages = [
          const FeedbackInquiryScreen(),
          const ServicesHomePage(),
          const OngoingProjects(),
          const BookingScreen(),
          const FeedbackHistoryScreen(),
        ];
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laphic App', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF8D5524),
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: const Color(0xFF080F2B),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
          BottomNavigationBarItem(icon: Icon(Icons.home_repair_service), label: "Services"),
          BottomNavigationBarItem(icon: Icon(Icons.construction), label: "Projects"),
          BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Booking"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        ],
      ),
    );
  }
}

class FeedbackInquiryScreen extends StatefulWidget {
  const FeedbackInquiryScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FeedbackInquiryScreenState createState() => _FeedbackInquiryScreenState();
}

class _FeedbackInquiryScreenState extends State<FeedbackInquiryScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();
  int _rating = 0;
  bool _isLoading = false;
  File? _image;
  PlatformFile? _webImage;
  final ImagePicker _picker = ImagePicker();
  final Completer<GoogleMapController> _mapController = Completer();

  static const LatLng _laphicLocation = LatLng(0.2279, 32.5325);
  static const String _backendUrl = 'https://your-ngrok-url.ngrok.io'; // Replace with actual ngrok URL
  static const String _mapStyle = '''
    [
      {"elementType": "geometry", "stylers": [{"color": "#212121"}]},
      {"elementType": "labels.text.fill", "stylers": [{"color": "#757575"}]},
      {"elementType": "labels.text.stroke", "stylers": [{"color": "#212121"}]},
      {"featureType": "road", "elementType": "geometry", "stylers": [{"color": "#424242"}]},
      {"featureType": "water", "elementType": "geometry", "stylers": [{"color": "#1976D2"}]}
    ]
  ''';

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _emailController.text = user.email ?? '';
      _nameController.text = user.displayName ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _pickImage() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.bytes != null) {
        setState(() => _webImage = result.files.single);
      }
    } else {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() => _image = File(image.path));
      }
    }
  }

  Future<String?> _uploadImage() async {
    if (kIsWeb && _webImage != null) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) throw Exception('User not logged in');
        final ref = FirebaseStorage.instance
            .ref()
            .child('feedback_images')
            .child('${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await ref.putData(_webImage!.bytes!);
        return await ref.getDownloadURL();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload image: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
        return null;
      }
    } else if (_image != null) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) throw Exception('User not logged in');
        final ref = FirebaseStorage.instance
            .ref()
            .child('feedback_images')
            .child('${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await ref.putFile(_image!);
        return await ref.getDownloadURL();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload image: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
        return null;
      }
    }
    return null;
  }

  Future<void> _submitFeedback() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _commentsController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    if (_commentsController.text.trim().length > 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comments must be 500 characters or less'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide a rating'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      String? imageUrl = await _uploadImage();
      User? user = FirebaseAuth.instance.currentUser;
      final response = await http.post(
        Uri.parse('$_backendUrl/feedback/submit'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': user?.uid,
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'comment': _commentsController.text.trim(),
          'rating': _rating,
          'imageUrl': imageUrl,
        }),
      );

      if (response.statusCode == 200) {
        _showSuccessDialog();
      } else {
        final error = jsonDecode(response.body)['error'] ?? 'Failed to submit feedback';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection error: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _commentsController.clear();
    setState(() {
      _rating = 0;
      _image = null;
      _webImage = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form cleared'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 5),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thank You!'),
        content: const Text('Your feedback has been submitted successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ServicesHomePage()),
              );
            },
            child: const Text('Back to Services', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF080F2B),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isWide ? 32.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMap(),
              const SizedBox(height: 24),
              _buildContactInfo(),
              const SizedBox(height: 32),
              Text(
                'Share Your Feedback',
                style: TextStyle(
                  fontSize: isWide ? 28 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 16),
              _buildForm(isWide),
              const SizedBox(height: 24),
              _buildRatingSection(),
              const SizedBox(height: 24),
              _buildImageUpload(),
              const SizedBox(height: 32),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap() {
    if (kIsWeb) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'Map not supported on web yet',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
            controller.setMapStyle(_mapStyle);
          },
          initialCameraPosition: const CameraPosition(
            target: _laphicLocation,
            zoom: 15,
          ),
          markers: {
            const Marker(
              markerId: MarkerId('laphic'),
              position: _laphicLocation,
              infoWindow: InfoWindow(title: 'Laphic Modern Homes'),
            ),
          },
          zoomControlsEnabled: true,
          myLocationButtonEnabled: false,
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Card(
      color: Colors.white.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildContactRow(Icons.location_pin, 'Kitende, Entebbe Road, Kampala, Uganda', Colors.orange),
            const SizedBox(height: 12),
            _buildContactRow(Icons.phone, '+256 705029291', Colors.orange),
            const SizedBox(height: 12),
            _buildContactRow(Icons.email, 'laphicmodernhomes@gmail.com', Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(bool isWide) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.orange),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.orange),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _commentsController,
          maxLines: 4,
          maxLength: 500,
          decoration: InputDecoration(
            labelText: 'Comments',
            labelStyle: const TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.orange),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rate Us',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.orange),
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => setState(() => _rating = index + 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.orange,
                  size: 36,
                ),
              ),
            );
          }),
        ),
        if (_rating > 0) ...[
          const SizedBox(height: 12),
          Text(
            'You rated us $_rating star${_rating == 1 ? '' : 's'}!',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ],
    );
  }

  Widget _buildImageUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attach Image (Optional)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.orange),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _pickImage,
              icon: const Icon(Icons.image, color: Colors.white),
              label: const Text('Pick Image', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(width: 16),
            if (_image != null || _webImage != null)
              Text(
                'Image selected',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _submitFeedback,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 5,
            ),
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Submit', style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            onPressed: _isLoading ? null : _clearForm,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.orange),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Clear Form', style: TextStyle(fontSize: 16, color: Colors.orange)),
          ),
        ),
      ],
    );
  }
}

class FeedbackHistoryScreen extends StatefulWidget {
  const FeedbackHistoryScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FeedbackHistoryScreenState createState() => _FeedbackHistoryScreenState();
}

class _FeedbackHistoryScreenState extends State<FeedbackHistoryScreen> {
  bool _isLoading = false;
  List<dynamic> _feedbackList = [];
  static const String _backendUrl = 'https://your-ngrok-url.ngrok.io'; // Replace with actual ngrok URL

  @override
  void initState() {
    super.initState();
    _fetchFeedbackHistory();
  }

  Future<void> _fetchFeedbackHistory() async {
    setState(() => _isLoading = true);
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');
      final response = await http.get(
        Uri.parse('$_backendUrl/feedback/history/${user.uid}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _feedbackList = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception(jsonDecode(response.body)['error'] ?? 'Failed to fetch feedback');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 228, 227),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : _feedbackList.isEmpty
              ? const Center(
                  child: Text(
                    'No feedback submitted yet',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchFeedbackHistory,
                  color: Colors.orange,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _feedbackList.length,
                    itemBuilder: (context, index) {
                      final feedback = _feedbackList[index];
                      return Card(
                        color: Colors.white.withOpacity(0.1),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                feedback['name'],
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                feedback['email'],
                                style: const TextStyle(color: Colors.white70, fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                feedback['comment'],
                                style: const TextStyle(color: Colors.white70, fontSize: 16),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: List.generate(5, (i) {
                                  return Icon(
                                    i < feedback['rating'] ? Icons.star : Icons.star_border,
                                    color: Colors.orange,
                                    size: 20,
                                  );
                                }),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Submitted: ${feedback['timestamp']}',
                                style: const TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}