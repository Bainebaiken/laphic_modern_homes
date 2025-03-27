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

import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode; // For debug logging
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key); // Updated from super.key

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final storage = const FlutterSecureStorage();
  String? token;
  bool _isLoading = true;

  // Initialize pages directly without late
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

    // Redirect to login if no token (assuming auth is required)
    if (token == null && mounted) {
      Navigator.of(context).pushReplacementNamed('/login'); // Adjust route as needed
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.blue[900], // Deep blue for consistency
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
  final TextEditingController _commentsController = TextEditingController();
  int _rating = 0;
  int _hoverRating = 0; // For hover effect on stars
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();

  final List<String> carouselImages = [
    'assets/location.JPG',
    'assets/interior3.jpeg',
    'assets/kit.jpg', // Add more relevant images
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
          if (mounted && _pageController.hasClients) {
            setState(() {
              _currentImageIndex = (_currentImageIndex + 1) % carouselImages.length;
              _pageController.animateToPage(
                _currentImageIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              if (kDebugMode) print('Carousel moved to index: $_currentImageIndex');
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _commentsController.dispose();
    _imageTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_nameController.text.isEmpty || _commentsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields'), backgroundColor: Colors.red),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Feedback submitted successfully!'),
        backgroundColor: Colors.green,
        action: SnackBarAction(label: 'OK', onPressed: () {}, textColor: Colors.white),
      ),
    );

    _nameController.clear();
    _commentsController.clear();
    setState(() => _rating = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900], // Deep blue background
      appBar: AppBar(
        title: const Text('Contact & Feedback', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel Section
              _buildCarousel(),
              const SizedBox(height: 20),
              // Contact Information
              _buildContactInfo(),
              const SizedBox(height: 30),
              // Inquiry / Feedback Title
              const Text(
                'Inquiry / Feedback',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),
              // Form Fields
              _buildForm(),
              const SizedBox(height: 20),
              // Rate Us Section
              _buildRatingSection(),
              const SizedBox(height: 30),
              // Submit Button
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

  Widget _buildCarousel() {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentImageIndex = index),
            itemCount: carouselImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(carouselImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              carouselImages.length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageIndex == index ? Colors.orange : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Card(
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildContactRow(Icons.location_pin, 'Kitende, Entebbe Road, Kampala, Uganda', Colors.red),
            const SizedBox(height: 10),
            _buildContactRow(Icons.phone, '+256 705029291', const Color.fromARGB(255, 176, 145, 22)),
            const SizedBox(height: 10),
            _buildContactRow(Icons.email, 'laphicmodernhomes@gmail.com', const Color.fromARGB(255, 177, 145, 17)),
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
            labelStyle: const TextStyle(color: Colors.white70),
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
          controller: _commentsController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Comments',
            labelStyle: const TextStyle(color: Colors.white70),
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
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
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ],
    );
  }
}