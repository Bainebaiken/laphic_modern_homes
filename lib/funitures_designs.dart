// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'package:laphic_app/compound_design.dart';
// import 'package:laphic_app/construction.dart';
// import 'package:laphic_app/feedback.dart';
// import 'package:laphic_app/gypsum_works.dart';
// import 'package:laphic_app/interior_design.dart';
// import 'package:laphic_app/metal_fabrication.dart';
// import 'package:laphic_app/painting.dart';
// import 'package:laphic_app/projects_designn.dart';
// import 'package:laphic_app/services.dart';
// import 'package:laphic_app/login_screen.dart'; // Import the login screen

// class MainScreen extends StatefulWidget {
//   final String? token;
  
//   const MainScreen({super.key, this.token});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;
//   final storage = const FlutterSecureStorage();
//   String? _token;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _checkToken();
//   }

//   // Check for token and redirect to login if not found
//   Future<void> _checkToken() async {
//     setState(() {
//       _isLoading = true;
//     });
    
//     // First check if token was passed directly
//     String? token = widget.token;
    
//     // If not, try to get it from secure storage
//     token ??= await storage.read(key: 'auth_token');
    
//     setState(() {
//       _token = token;
//       _isLoading = false;
//     });
    
//     // If no token found, redirect to login screen
//     if (token == null && mounted) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     }
//   }

//   // List of screens for navigation
//   List<Widget> get _pages => [
//     const FeedbackInquiryScreen(),
//     _token != null ? ServicesPage(token: _token!) : const Center(child: CircularProgressIndicator()),
//     const OngoingProjects(),
//     const GypsumWorksScreen(),
//     const FunitureDesignScreen(),
//     const ConstructionPage(),
//     const CompoundDesignPage(),
//     const InteriorGalleryScreen(),
//     const PaintingPage(),
//     const MetalFabricationPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Show loading indicator while checking for token
//     if (_isLoading) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
    
    

//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
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

// class FunitureDesignScreen extends StatefulWidget {
//   const FunitureDesignScreen({super.key});

//   @override
//   State<FunitureDesignScreen> createState() => _FunitureDesignScreenState();
// }

// class _FunitureDesignScreenState extends State<FunitureDesignScreen> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     // Handle navigation logic here
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Colors.grey[300],
//         title: const Text(
//           'construction Works',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Image
//             Container(
//               margin: const EdgeInsets.all(10),
//               height: 180,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: const DecorationImage(
//                   image: AssetImage('assets/bed.jpg'), 
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             // Title Section
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: Text(
//                 "contruction Works",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),

//             // Grid of bed Designs
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 3 / 4,
//                 ),
//                 itemCount: gypsumDesigns.length,
//                 itemBuilder: (context, index) {
//                   final design = gypsumDesigns[index];
//                   return Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 4,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         // Image Section
//                         ClipRRect(
//                           borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(10),
//                           ),
//                           child: Image.asset(
//                             design['image']!,
//                             height: 120,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         // Title and Price Section
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 design['title']!,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 design['price']!,
//                                 style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),

//       // Bottom Navigation Bar
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.category),
//             label: 'Categories',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// // compound Designs Data
// final List<Map<String, String>> gypsumDesigns = [
//   {
//     "title": "Simple & Affordable",
//     "price": "500,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Grey Lights",
//     "price": "400,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Humble Lights",
//     "price": "500,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Brown Design",
//     "price": "300,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Blue Design",
//     "price": "400,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Rectangle Design",
//     "price": "300,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Grey Design",
//     "price": "400,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Purple Design",
//     "price": "400,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Circular Lights",
//     "price": "400,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Deep Lights",
//     "price": "800,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Simple & Affordable",
//     "price": "500,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Grey Lights",
//     "price": "400,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Humble Lights",
//     "price": "500,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Brown Design",
//     "price": "300,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Blue Design",
//     "price": "400,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Rectangle Design",
//     "price": "300,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Grey Design",
//     "price": "400,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Purple Design",
//     "price": "400,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Circular Lights",
//     "price": "400,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
//   {
//     "title": "Deep Lights",
//     "price": "800,000 UGX",
//     "image": "assets/bed.jpg", 
//   },
// ];













import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode; // For debug logging
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:laphic_app/compound_design.dart';
import 'package:laphic_app/construction.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/gypsum_works.dart';
import 'package:laphic_app/interior_design.dart';
import 'package:laphic_app/metal_fabrication.dart';
import 'package:laphic_app/painting.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:laphic_app/services.dart';
import 'package:laphic_app/login_screen.dart';

class MainScreen extends StatefulWidget {
  final String? token;

  const MainScreen({Key? key, this.token}) : super(key: key); // Updated from super.key

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final storage = const FlutterSecureStorage();
  String? _token;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    setState(() => _isLoading = true);
    String? token = widget.token ?? await storage.read(key: 'auth_token');
    if (kDebugMode) print('Token retrieved: $token');

    setState(() {
      _token = token;
      _isLoading = false;
    });

    if (token == null && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  List<Widget> get _pages => [
        const FeedbackInquiryScreen(),
        _token != null ? ServicesPage(token: _token!) : const Center(child: CircularProgressIndicator()),
        const OngoingProjects(),
        const GypsumWorksScreen(),
        const FurnitureDesignScreen(), // Fixed typo
        const ConstructionPage(),
        const CompoundDesignPage(),
        const InteriorGalleryScreen(),
        const PaintingPage(),
        const MetalFabricationPage(),
      ];

  void _onItemTapped(int index) {
    if (index < _pages.length) { // Prevent out-of-bounds
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_token == null) {
      return const LoginScreen(); // Direct redirect instead of message
    }

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
          BottomNavigationBarItem(icon: Icon(Icons.home_repair_service), label: "Services"),
          BottomNavigationBarItem(icon: Icon(Icons.construction), label: "Projects"),
          BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Booking"),
          // Add more items to match _pages if needed
        ],
      ),
    );
  }
}

class FurnitureDesignScreen extends StatefulWidget {
  const FurnitureDesignScreen({Key? key}) : super(key: key); // Fixed typo in name

  @override
  // ignore: library_private_types_in_public_api
  _FurnitureDesignScreenState createState() => _FurnitureDesignScreenState();
}

class _FurnitureDesignScreenState extends State<FurnitureDesignScreen> {
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();

  final List<String> carouselImages = [
    'assets/bed.jpg',
    'assets/interior3.jpeg',
    'assets/kit.jpg', // Add more furniture-related images
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
    _imageTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 24, 48), // Deep blue background
      appBar: AppBar(
        title: const Text('Furniture Designs', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Section
            _buildCarousel(),
            // Title Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "Furniture Designs",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            // Grid of Furniture Designs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: furnitureDesigns.length,
                itemBuilder: (context, index) {
                  final design = furnitureDesigns[index];
                  final String image = design['image'] ?? 'assets/bed.jpg';
                  final String title = design['title'] ?? 'Unknown Design';
                  final String price = design['price'] ?? 'N/A';

                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                          child: Image.asset(
                            image,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              if (kDebugMode) print('Failed to load image: $image, error: $error');
                              return const Center(child: Icon(Icons.error));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                price,
                                style: const TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Stack(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentImageIndex = index),
            itemCount: carouselImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(10),
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
          bottom: 20,
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
}

// Furniture Designs Data (Reduced Duplicates)
final List<Map<String, String>> furnitureDesigns = [
  {"title": "Simple Bed", "price": "500,000 UGX", "image": "assets/bed.jpg"},
  {"title": "Modern Sofa", "price": "400,000 UGX", "image": "assets/bed.jpg"},
  {"title": "Elegant Chair", "price": "500,000 UGX", "image": "assets/bed.jpg"},
  {"title": "Wooden Table", "price": "300,000 UGX", "image": "assets/bed.jpg"},
  {"title": "Blue Couch", "price": "400,000 UGX", "image": "assets/bed.jpg"},
  {"title": "Minimal Shelf", "price": "300,000 UGX", "image": "assets/bed.jpg"},
  {"title": "Grey Ottoman", "price": "400,000 UGX", "image": "assets/bed.jpg"},
  {"title": "Luxury Desk", "price": "800,000 UGX", "image": "assets/bed.jpg"},
];