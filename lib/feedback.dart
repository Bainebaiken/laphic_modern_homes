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


import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final storage = const FlutterSecureStorage();
  String? token;
  bool _isLoading = true;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    setState(() => _isLoading = true);
    token = await storage.read(key: 'auth_token');
    if (kDebugMode) print('Token loaded: $token');

    setState(() {
      _pages = [
        const FeedbackInquiryScreen(),
        ServicesPage(token: token ?? ''),
        const OngoingProjects(),
        const BookingScreen(),
      ];
      _isLoading = false;
    });

    if (token == null && mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
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
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color.fromARGB(255, 2, 5, 20),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
          BottomNavigationBarItem(icon: Icon(Icons.home_repair_service), label: "Services"),
          BottomNavigationBarItem(icon: Icon(Icons.construction), label: "Projects"),
          BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Booking"),
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
  int _hoverRating = 0;
  final Completer<GoogleMapController> _mapController = Completer();

  static const LatLng _laphicLocation = LatLng(0.2279, 32.5325);

  @override
  void initState() {
    super.initState();
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

  void _submitFeedback() {
    if (_nameController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _commentsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields'), backgroundColor: Colors.red),
      );
      return;
    }

    if (!_isValidEmail(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email'), backgroundColor: Colors.red),
      );
      return;
    }

    if (kDebugMode) {
      print('Feedback: Name: ${_nameController.text}, Email: ${_emailController.text}, Comments: ${_commentsController.text}, Rating: $_rating');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Feedback submitted successfully!'),
        backgroundColor: Colors.green,
        action: SnackBarAction(label: 'OK', onPressed: () {}, textColor: Colors.white),
      ),
    );

    _nameController.clear();
    _emailController.clear();
    _commentsController.clear();
    setState(() => _rating = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 247, 248, 249),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMap(),
              const SizedBox(height: 20),
              _buildContactInfo(),
              const SizedBox(height: 30),
              const Text(
                'Inquiry / Feedback',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 202, 126, 4)),
              ),
              const SizedBox(height: 20),
              _buildForm(),
              const SizedBox(height: 20),
              _buildRatingSection(),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                  ),
                  child: const Text('Submit', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return SizedBox(
      height: 200,
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
          if (kDebugMode) print('Map created successfully');
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
      ),
    );
  }

  Widget _buildContactInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildContactRow(Icons.location_pin, 'Kitende, Entebbe Road, Kampala, Uganda', const Color.fromARGB(255, 224, 141, 7)),
            const SizedBox(height: 10),
            _buildContactRow(Icons.phone, '+256 705029291', const Color.fromARGB(255, 231, 147, 4)),
            const SizedBox(height: 10),
            _buildContactRow(Icons.email, 'laphicmodernhomes@gmail.com', const Color.fromARGB(255, 198, 127, 19)),
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
        Expanded(child: Text(text, style: const TextStyle(fontSize: 16, color: Colors.black87))),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: const TextStyle(color: Color.fromARGB(255, 32, 31, 31)),
            filled: true,
            fillColor: const Color.fromARGB(255, 27, 26, 26).withOpacity(0.2),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(color: Color.fromARGB(255, 10, 10, 10)),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _commentsController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Comments',
            labelStyle: const TextStyle(color: Color.fromARGB(255, 15, 15, 15)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(10),
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
          'Rate us:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 189, 101, 7)),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => setState(() => _rating = index + 1),
              child: MouseRegion(
                onEnter: (_) => setState(() => _hoverRating = index + 1),
                onExit: (_) => setState(() => _hoverRating = 0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    (index < _rating || index < _hoverRating) ? Icons.star : Icons.star_border,
                    color: Colors.orange,
                    size: 36,
                  ),
                ),
              ),
            );
          }),
        ),
        if (_rating > 0) ...[
          const SizedBox(height: 10),
          Text(
            'You rated us $_rating star${_rating == 1 ? '' : 's'}!',
            style: const TextStyle(color: Color.fromARGB(234, 246, 244, 244), fontSize: 16),
          ),
        ],
      ],
    );
  }
}