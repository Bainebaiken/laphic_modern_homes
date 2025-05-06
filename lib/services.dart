




// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// // import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// // import 'package:laphic_app/booking.dart';
// // import 'package:laphic_app/compound_design.dart';
// // import 'package:laphic_app/construction.dart';
// // import 'package:laphic_app/feedback.dart';
// // import 'package:laphic_app/funitures_designs.dart';
// // import 'package:laphic_app/gypsum_works.dart';
// // import 'package:laphic_app/interior_design.dart';
// // import 'package:laphic_app/metal_fabrication.dart';
// // import 'package:laphic_app/painting.dart';
// // import 'package:laphic_app/projects_designn.dart';

// // class ServicesPage extends StatefulWidget {
// //   final String token;

// //   const ServicesPage({Key? key, required this.token}) : super(key: key);

// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _ServicesPageState createState() => _ServicesPageState();
// // }

// // class _ServicesPageState extends State<ServicesPage> {
// //   final storage = const FlutterSecureStorage();
// //   int _currentImageIndex = 0;
// //   Timer? _imageTimer;
// //   bool _tokenStored = false;
// //   final PageController _pageController = PageController();

// //   final int _selectedIndex = 1; // Default to Services tab
// //   final Color backgroundColor = Colors.white;

// //   final List<String> headerImages = [
// //     "assets/interior7.jpeg",
// //     "assets/painting 1.jpg",
// //     "assets/interior3.jpeg",
// //     "assets/house5.jpeg",
// //     "assets/laphic2.PNG",
// //     "assets/SWIUXEXDJDK.jpg",
// //     "assets/painting2.jpeg",
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _storeToken();

// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       if (mounted) {
// //         _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
// //           if (mounted && _pageController.hasClients) {
// //             setState(() {
// //               _currentImageIndex = (_currentImageIndex + 1) % headerImages.length;
// //               _pageController.animateToPage(
// //                 _currentImageIndex,
// //                 duration: const Duration(milliseconds: 500),
// //                 curve: Curves.easeInOut,
// //               );
// //             });
// //           }
// //         });
// //       }
// //     });
// //   }

// //   Future<void> _storeToken() async {
// //     if (widget.token.isNotEmpty) {
// //       try {
// //         await storage.write(key: 'auth_token', value: widget.token);
// //         if (mounted) {
// //           setState(() {
// //             _tokenStored = true;
// //           });
// //         }
// //       } catch (e) {
// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(content: Text('Failed to store token: $e')),
// //           );
// //         }
// //       }
// //     }
// //   }

// //   void _onItemTapped(int index) {
// //     if (index != _selectedIndex) {
// //       switch (index) {
// //         case 0:
// //           Navigator.pushReplacement(
// //             context,
// //             MaterialPageRoute(builder: (context) => const FeedbackInquiryScreen()),
// //           );
// //           break;
// //         case 2:
// //           Navigator.pushReplacement(
// //             context,
// //             MaterialPageRoute(builder: (context) => const OngoingProjects()),
// //           );
// //           break;
// //         case 3:
// //           Navigator.pushReplacement(
// //             context,
// //             MaterialPageRoute(builder: (context) => const BookingScreen()),
// //           );
// //           break;
// //       }
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _imageTimer?.cancel();
// //     _pageController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         color: backgroundColor,
// //         child: _buildServicesContent(),
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         type: BottomNavigationBarType.fixed,
// //         currentIndex: _selectedIndex,
// //         onTap: _onItemTapped,
// //         selectedItemColor: Colors.orange,
// //         unselectedItemColor: Colors.grey,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
// //           BottomNavigationBarItem(icon: Icon(Icons.home_repair_service), label: "Services"),
// //           BottomNavigationBarItem(icon: Icon(Icons.construction), label: "Projects"),
// //           BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Booking"),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildServicesContent() {
// //     return SafeArea(
// //       child: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             _buildCarousel(),
// //             Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: _buildServicesGrid(),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildServicesGrid() {
// //     return GridView.custom(
// //       shrinkWrap: true,
// //       physics: const NeverScrollableScrollPhysics(),
// //       gridDelegate: SliverWovenGridDelegate.count(
// //         crossAxisCount: 2,
// //         mainAxisSpacing: 8,
// //         crossAxisSpacing: 8,
// //         pattern: [
// //           const WovenGridTile(1),
// //           const WovenGridTile(1),
// //         ],
// //       ),
// //       childrenDelegate: SliverChildBuilderDelegate(
// //         (context, index) {
// //           final service = services[index];
// //           final bool isFurnitureService = index == 6;

// //           final String title = service['title'] as String? ?? 'Unknown Service';
// //           final String image = service['image'] as String? ?? 'assets/placeholder.jpg';
// //           final Widget? page = service['page'] as Widget?;

// //           return GestureDetector(
// //             onTap: () {
// //               if (_tokenStored || widget.token.isEmpty) {
// //                 if (page != null) {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => page),
// //                   );
// //                 } else {
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     const SnackBar(content: Text('Service page not available')),
// //                   );
// //                 }
// //               } else {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(
// //                     content: Text('Please wait a moment while we authenticate your session.'),
// //                     duration: Duration(seconds: 2),
// //                   ),
// //                 );
// //               }
// //             },
// //             child: Card(
// //               color: Colors.white,
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //               elevation: 5,
// //               child: Stack(
// //                 children: [
// //                   ClipRRect(
// //                     borderRadius: BorderRadius.circular(10),
// //                     child: Image.asset(
// //                       image,
// //                       fit: BoxFit.cover,
// //                       width: double.infinity,
// //                       height: double.infinity,
// //                     ),
// //                   ),
// //                   Container(
// //                     decoration: BoxDecoration(
// //                       color: Colors.black.withOpacity(0.4),
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                   ),
// //                   Center(
// //                     child: Padding(
// //                       padding: EdgeInsets.all(isFurnitureService ? 16.0 : 8.0),
// //                       child: Text(
// //                         title,
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: isFurnitureService ? 22 : 16,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                         textAlign: TextAlign.center,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //         childCount: services.length,
// //       ),
// //     );
// //   }

// //   Widget _buildCarousel() {
// //     return Stack(
// //       children: [
// //         SizedBox(
// //           height: 200,
// //           child: PageView.builder(
// //             controller: _pageController,
// //             onPageChanged: (index) {
// //               setState(() {
// //                 _currentImageIndex = index;
// //               });
// //             },
// //             itemCount: headerImages.length,
// //             itemBuilder: (context, index) {
// //               return Stack(
// //                 children: [
// //                   Image.asset(
// //                     headerImages[index],
// //                     height: 200,
// //                     width: double.infinity,
// //                     fit: BoxFit.cover,
// //                   ),
// //                   Container(
// //                     height: 200,
// //                     width: double.infinity,
// //                     color: Colors.black.withOpacity(0.4),
// //                   ),
// //                 ],
// //               );
// //             },
// //           ),
// //         ),
// //         const Positioned(
// //           bottom: 20,
// //           left: 20,
// //           child: Text(
// //             'Services',
// //             style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
// //           ),
// //         ),
// //         Positioned(
// //           left: 10,
// //           top: 80,
// //           child: IconButton(
// //             icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
// //             onPressed: () {
// //               int newIndex = (_currentImageIndex - 1) % headerImages.length;
// //               if (newIndex < 0) newIndex = headerImages.length - 1;
// //               _pageController.animateToPage(
// //                 newIndex,
// //                 duration: const Duration(milliseconds: 500),
// //                 curve: Curves.easeInOut,
// //               );
// //             },
// //           ),
// //         ),
// //         Positioned(
// //           right: 10,
// //           top: 80,
// //           child: IconButton(
// //             icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
// //             onPressed: () {
// //               int newIndex = (_currentImageIndex + 1) % headerImages.length;
// //               _pageController.animateToPage(
// //                 newIndex,
// //                 duration: const Duration(milliseconds: 500),
// //                 curve: Curves.easeInOut,
// //               );
// //             },
// //           ),
// //         ),
// //         Positioned(
// //           bottom: 10,
// //           left: 0,
// //           right: 0,
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: List.generate(
// //               headerImages.length,
// //               (index) => Container(
// //                 width: 8,
// //                 height: 8,
// //                 margin: const EdgeInsets.symmetric(horizontal: 4),
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   color: _currentImageIndex == index
// //                       ? Colors.orange
// //                       : Colors.white.withOpacity(0.5),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   final List<Map<String, dynamic>> services = [
// //     {"title": "Compound Design", "image": "assets/compound 1.jpg", "page": const CompoundDesignPage()},
// //     {"title": "Construction", "image": "assets/SWIUXEXDJDK.jpg", "page": const ConstructionPage()},
// //     {"title": "Painting", "image": "assets/painting2.jpeg", "page": const PaintingPage()},
// //     {"title": "Interior Design", "image": "assets/design.jpeg", "page": const InteriorGalleryScreen()},
// //     {"title": "Metal Fabrication", "image": "assets/metal.jpeg", "page": const MetalFabricationPage()},
// //     {"title": "Gypsum Works", "image": "assets/gypsum6.webp", "page": const GypsumWorksScreen()},
// //     {"title": "Furniture Works", "image": "assets/gypsum6.webp", "page": const FurnitureDesignScreen()},
// //   ];
// // }


// import 'package:flutter/material.dart';
// import 'package:laphic_app/booking.dart';
// import 'package:laphic_app/feedback.dart';
// import 'package:laphic_app/livechat.dart';
// import 'package:laphic_app/settings_screen.dart';


// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Services App',
// //       theme: ThemeData(
// //         primaryColor: const Color(0xFF080F2B),
// //         scaffoldBackgroundColor: Colors.white,
// //         useMaterial3: true,
// //       ),
// //       home: const ServicesHomePage(),
// //       debugShowCheckedModeBanner: false,
// //     );
// //   }
// // }



// // below is the code for the services  wic links to the other service galleries

// class ServicesHomePage extends StatelessWidget {
//   const ServicesHomePage({Key? key}) : super(key: key);

//   final Color deepBlue = const Color(0xFF080F2B);
//   final Color orange = Colors.orange;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(color: deepBlue),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   CircleAvatar(radius: 28, backgroundColor: Colors.white),
//                   SizedBox(height: 8),
//                   Text("Hello, User", style: TextStyle(color: Colors.white)),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('Settings'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => SettingsScreen(
//                       onThemeChanged: (bool isDark) {
//                         // Handle theme change here
//                       },
//                       isDarkMode: false, // Fixed: No longer passing null
//                     ),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.feedback),
//               title: const Text('Feedback'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const FeedbackInquiryScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.chat),
//               title: const Text('Chat'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const ChatPage()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.book),
//               title: const Text('Bookings'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const BookingScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor: deepBlue,
//         title: Row(
//           children: [
//             const Icon(Icons.location_on, color: Colors.orange, size: 20),
//             const SizedBox(width: 4),
//             Text('kitende, kampala', style: TextStyle(color: Colors.white)),
//             const Icon(Icons.keyboard_arrow_down, color: Colors.white),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications, color: Colors.white),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildSearchBar(),
//             _buildBannerCarousel(),
//             _buildSectionTitle('Categories', onSeeAll: () {}),
//             _buildCategories(context),
//             _buildSectionTitle('Popular Services', onSeeAll: () {}),
//             _buildPopularServices(context),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: orange,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
//           BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
//           BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         decoration: BoxDecoration(
//           color: Colors.grey.shade100,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: const Row(
//           children: [
//             Icon(Icons.search, color: Colors.grey),
//             SizedBox(width: 8),
//             Expanded(
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search',
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             Icon(Icons.filter_list, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBannerCarousel() {
//     return SizedBox(
//       height: 160,
//       child: PageView(
//         children: List.generate(
//           3,
//           (index) => Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               image: const DecorationImage(
//                 image: AssetImage("assets/cleaning.jpg"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.black.withOpacity(0.4),
//                   ),
//                 ),
//                 const Positioned(
//                   left: 16,
//                   top: 16,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Limited time!",
//                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 8),
//                       Text("Get Special Offer 40%",
//                           style: TextStyle(color: Colors.white, fontSize: 16)),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 16,
//                   right: 16,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
//                     onPressed: () {},
//                     child: const Text("Claim"),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title, {required VoidCallback onSeeAll}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//           GestureDetector(
//             onTap: onSeeAll,
//             child: const Text('See all', style: TextStyle(color: Colors.orange)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategories(BuildContext context) {
//     final categories = [
//       {"icon": Icons.construction, "label": "Construction"},
//       {"icon": Icons.format_paint, "label": "Painting"},
//       {"icon": Icons.chair, "label": "Furniture"},
//       {"icon": Icons.landscape, "label": "Compound Design"},
//       {"icon": Icons.home_work, "label": "Interior Design"},
//       {"icon": Icons.layers, "label": "Gypsum Work"},
//       {"icon": Icons.precision_manufacturing, "label": "Metal Fabrication"},
//     ];

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Wrap(
//         spacing: 20,
//         runSpacing: 16,
//         children: categories.map((cat) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => ServiceDetailPage(
//                     title: cat["label"] as String, // Fixed: Cast to String
//                   ),
//                 ),
//               );
//             },
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircleAvatar(
//                   backgroundColor: deepBlue,
//                   radius: 30,
//                   child: Icon(cat["icon"] as IconData, color: Colors.white),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(cat["label"] as String),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildPopularServices(BuildContext context) {
//     final popular = ["Painting", "Construction", "Furniture"];
//     return SizedBox(
//       height: 140,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: popular.length,
//         itemBuilder: (context, index) => GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => ServiceDetailPage(title: popular[index]),
//               ),
//             );
//           },
//           child: Container(
//             width: 120,
//             margin: const EdgeInsets.only(right: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.grey.shade300,
//                     blurRadius: 6,
//                     offset: const Offset(0, 2)),
//               ],
//             ),
//             child: Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                   child: Image.asset(
//                     "assets/cleaning.jpg",
//                     height: 80,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text("4.8", style: TextStyle(fontWeight: FontWeight.bold)),
//                       Icon(Icons.star, color: Colors.orange, size: 16),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ServiceDetailPage extends StatelessWidget {
//   final String title;

//   const ServiceDetailPage({Key? key, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: Center(child: Text('Details about $title')),
//     );
//   }
// }




 


import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/compound_design.dart';
import 'package:laphic_app/construction.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/funitures_designs.dart';
import 'package:laphic_app/gypsum_works.dart';
import 'package:laphic_app/interior_design.dart';
import 'package:laphic_app/livechat.dart';
import 'package:laphic_app/metal_fabrication.dart';
import 'package:laphic_app/notification.dart';
import 'package:laphic_app/painting.dart';
import 'package:laphic_app/settings_screen.dart';

class ServicesHomePage extends StatefulWidget {
  const ServicesHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ServicesHomePageState createState() => _ServicesHomePageState();
}

class _ServicesHomePageState extends State<ServicesHomePage> {
  final Color deepBlue = const Color(0xFF080F2B);
  final Color orange = Colors.orange;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final List<String> _searchHistory = [];
  int _currentNavIndex = 0;
  final PageController _pageController = PageController();
  Timer? _carouselTimer;
  int _currentPage = 0;

  // List of categories with their titles, icons, screens, and image paths
  final List<Map<String, dynamic>> _allCategories = [
    {
      'title': 'Construction',
      'icon': Icons.construction,
      'screen': const ConstructionPage(),
      'imagePath': 'assets/construction.jpg',
    },
    {
      'title': 'Painting',
      'icon': Icons.format_paint,
      'screen': const PaintingPage(),
      'imagePath': 'assets/painting.jpg',
    },
    {
      'title': 'Furniture',
      'icon': Icons.chair,
      'screen': const FurnitureDesignScreen(),
      'imagePath': 'assets/interior3.jpeg',
    },
    {
      'title': 'Compound Design',
      'icon': Icons.landscape,
      'screen': const CompoundDesignPage(),
      'imagePath': ' assets/interior3.jpeg',
    },
    {
      'title': 'Interior Design',
      'icon': Icons.home_work,
      'screen': const InteriorGalleryScreen(),
      'imagePath': 'assets/interior_design.jpg',
    },
    {
      'title': 'Gypsum Work',
      'icon': Icons.layers,
      'screen': const GypsumWorksScreen(),
      'imagePath': 'assets/gypsum_work.jpg',
    },
    {
      'title': 'Metal Fabrication',
      'icon': Icons.precision_manufacturing,
      'screen': const MetalFabricationPage(),
      'imagePath': 'assets/metal_fabrication.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
    // Start auto-scrolling carousel
    _startCarouselTimer();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    _carouselTimer?.cancel();
    super.dispose();
  }

  void _startCarouselTimer() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % 7; // 7 banners
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _pauseCarouselTimer() {
    _carouselTimer?.cancel();
    // Restart after a delay to allow manual scrolling
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        _startCarouselTimer();
      }
    });
  }

  void _addToSearchHistory(String query) {
    if (query.isNotEmpty && !_searchHistory.contains(query)) {
      setState(() {
        _searchHistory.insert(0, query);
        if (_searchHistory.length > 5) {
          _searchHistory.removeLast(); // Limit to 5 recent searches
        }
      });
    }
  }

  void _showSearchHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search History'),
        content: _searchHistory.isEmpty
            ? const Text('No recent searches')
            : SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _searchHistory.length,
                  itemBuilder: (context, index) {
                    final query = _searchHistory[index];
                    return ListTile(
                      title: Text(query),
                      onTap: () {
                        setState(() {
                          _searchController.text = query;
                          _searchQuery = query.toLowerCase();
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter categories based on search query
    final filteredCategories = _searchQuery.isEmpty
        ? _allCategories
        : _allCategories
            .where((category) => category['title'].toLowerCase().contains(_searchQuery))
            .toList();

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: deepBlue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(radius: 28, backgroundColor: Colors.white),
                  SizedBox(height: 8),
                  Text("Hello, User", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsScreen(
                      onThemeChanged: (bool isDark) {},
                      isDarkMode: false,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FeedbackInquiryScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Chat'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Bookings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BookingScreen()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: deepBlue,
        title: Row(
          children: const [
            Icon(Icons.location_on, color: Colors.orange, size: 20),
            SizedBox(width: 4),
            Text('Kitende, Kampala', style: TextStyle(color: Colors.white)),
            Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            _buildBannerCarousel(),
            _buildSectionTitle('Services', onSeeAll: () {}),
            _buildCategories(context, filteredCategories),
            _buildSectionTitle('Popular Services', onSeeAll: () {}),
            _buildPopularServices(context, filteredCategories),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: orange,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentNavIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          switch (index) {
            case 0:
              // Already on Home, do nothing
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ChatPage()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BookingScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsScreen(
                    onThemeChanged: (bool isDark) {},
                    isDarkMode: false,
                  ),
                ),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MoreScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search for a service',
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  _addToSearchHistory(value);
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.history, color: Colors.grey),
              onPressed: () => _showSearchHistory(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
    final banners = [
      'assets/location.JPG',
      'assets/hommie.jpg',
      'assets/kit.jpg',
      'assets/SECOND PAGE.jpg',
      'assets/THIRD SCREEN.jpg',
      'assets/login.jpeg',
      'assets/login1.jpg',
    ];

    return SizedBox(
      height: 160,
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
          _pauseCarouselTimer();
        },
        children: banners.map((imagePath) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  if (kDebugMode) {
                    print('Error loading carousel image: $imagePath, Error: $exception');
                  }
                },
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                const Positioned(
                  left: 16,
                  top: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Limited time!",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Get Special Offer 40%",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: orange),
                    onPressed: () {},
                    child: const Text("Claim"),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {required VoidCallback onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              'See all',
              style: TextStyle(color: orange),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context, List<Map<String, dynamic>> categories) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => category['screen']),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: orange,
                    radius: 30,
                    child: Icon(
                      category['icon'] as IconData,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['title'] as String,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularServices(BuildContext context, List<Map<String, dynamic>> categories) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => category['screen']),
              );
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      category['imagePath'] as String,
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        if (kDebugMode) {
                          print('Error loading popular service image: ${category['imagePath']}, Error: $error');
                        }
                        return Container(
                          height: 80,
                          color: Colors.grey.shade300,
                          child: Center(
                            child: Text(
                              '${category['title']}\nImage Missing',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "4.8",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Placeholder screen for the "More" tab
class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        backgroundColor: const Color(0xFF080F2B),
      ),
      body: const Center(
        child: Text(
          'More Options',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}