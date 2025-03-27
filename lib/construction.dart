// import 'package:flutter/material.dart';

// import 'package:laphic_app/compound_design.dart';
// import 'package:laphic_app/feedback.dart';
// import 'package:laphic_app/funitures_designs.dart';
// import 'package:laphic_app/gypsum_works.dart';
// import 'package:laphic_app/interior_design.dart';
// import 'package:laphic_app/metal_fabrication.dart';
// import 'package:laphic_app/painting.dart';
// import 'package:laphic_app/projects_designn.dart';
// import 'package:laphic_app/services.dart';


// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key); 

//   @override
//   // ignore: library_private_types_in_public_api
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;

//   // List of screens for navigation
//   late final List<Widget> _pages;
  
//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       const FeedbackInquiryScreen(),
//       const ServicesPage(token: '',), // Now this works because token is optional
//       const OngoingProjects(),
//       // For the pages beyond the navigation bar items, ensure they're included
//       // only if they can be accessed through other navigation methods
//       const GypsumWorksScreen(),
//       const FurnitureDesignScreen(),
//       const ConstructionPage(),
//       const CompoundDesignPage(),
//       const InteriorGalleryScreen(),
//       const PaintingPage(),
//       const MetalFabricationPage(),
//     ];
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Make sure _selectedIndex doesn't exceed available pages
//     final safePage = _selectedIndex < _pages.length 
//         ? _pages[_selectedIndex]
//         : _pages[0]; // Default to first page if out of bounds
        
//     return Scaffold(
//       body: safePage,
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

// class ConstructionPage extends StatefulWidget {
//   const ConstructionPage({Key? key}) : super(key: key); 
//   @override
//   State<ConstructionPage> createState() => _ConstructionPageState();
// }

// class _ConstructionPageState extends State<ConstructionPage> {

 

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
//                   image: AssetImage('assets/house5.jpeg'), 
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

//             // Grid of Construction Designs
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

      
//     );
//   }
// }

// // Gypsum Designs Data
// final List<Map<String, String>> gypsumDesigns = [
//   {
//     "title": "Simple & Affordable",
//     "price": "500,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Grey Lights",
//     "price": "400,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Humble Lights",
//     "price": "500,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Brown Design",
//     "price": "300,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Blue Design",
//     "price": "400,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Rectangle Design",
//     "price": "300,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Grey Design",
//     "price": "400,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Purple Design",
//     "price": "400,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Circular Lights",
//     "price": "400,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Deep Lights",
//     "price": "800,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//    {
//     "title": "Simple & Affordable",
//     "price": "500,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Grey Lights",
//     "price": "400,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Humble Lights",
//     "price": "500,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Brown Design",
//     "price": "300,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Blue Design",
//     "price": "400,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Rectangle Design",
//     "price": "300,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Grey Design",
//     "price": "400,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Purple Design",
//     "price": "400,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Circular Lights",
//     "price": "400,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
//   {
//     "title": "Deep Lights",
//     "price": "800,000 UGX",
//     "image": "assets/house5.jpeg", 
//   },
// ];



import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode; // For debug logging
import 'package:flutter/material.dart';
import 'package:laphic_app/compound_design.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/funitures_designs.dart';
import 'package:laphic_app/gypsum_works.dart';
import 'package:laphic_app/interior_design.dart';
import 'package:laphic_app/metal_fabrication.dart';
import 'package:laphic_app/painting.dart';
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

  // List of screens for navigation
  final List<Widget> _pages = [
    const FeedbackInquiryScreen(),
    const ServicesPage(token: ''), // Empty token; adjust if auth is needed
    const OngoingProjects(),
    const ConstructionPage(), // Moved to index 3 for "Booking"
    const GypsumWorksScreen(),
    const FurnitureDesignScreen(),
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
    return Scaffold(
      body: _pages[_selectedIndex], // Simplified from safePage logic
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.blue[900], // Deep blue for consistency
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
          BottomNavigationBarItem(icon: Icon(Icons.home_repair_service), label: "Services"),
          BottomNavigationBarItem(icon: Icon(Icons.construction), label: "Projects"),
          BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Booking"), // Maps to ConstructionPage
        ],
      ),
    );
  }
}

class ConstructionPage extends StatefulWidget {
  const ConstructionPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ConstructionPageState createState() => _ConstructionPageState();
}

class _ConstructionPageState extends State<ConstructionPage> {
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();

  final List<String> carouselImages = [
    'assets/house5.jpeg',
    'assets/interior7.jpeg',
    'assets/SWIUXEXDJDK.jpg', // Add more construction-related images
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
      appBar: AppBar(
        title: const Text('Construction Works', style: TextStyle(color: Colors.white)),
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
                "Construction Works",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Grid of Construction Designs
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
                itemCount: constructionDesigns.length,
                itemBuilder: (context, index) {
                  final design = constructionDesigns[index];
                  final String image = design['image'] ?? 'assets/house5.jpeg';
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

// Construction Designs Data (Reduced Duplicates)
final List<Map<String, String>> constructionDesigns = [
  {"title": "Simple & Affordable", "price": "500,000 UGX", "image": "assets/house5.jpeg"},
  {"title": "Modern Villa", "price": "400,000 UGX", "image": "assets/house5.jpeg"},
  {"title": "Humble Home", "price": "500,000 UGX", "image": "assets/house5.jpeg"},
  {"title": "Brick Design", "price": "300,000 UGX", "image": "assets/house5.jpeg"},
  {"title": "Blue Facade", "price": "400,000 UGX", "image": "assets/house5.jpeg"},
  {"title": "Compact Build", "price": "300,000 UGX", "image": "assets/house5.jpeg"},
  {"title": "Grey Structure", "price": "400,000 UGX", "image": "assets/house5.jpeg"},
  {"title": "Luxury Mansion", "price": "800,000 UGX", "image": "assets/house5.jpeg"},
];




