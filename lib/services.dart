// import 'dart:async';
// import 'package:flutter/foundation.dart' show kDebugMode;
// import 'package:flutter/material.dart'; // Simplified import
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:laphic_app/booking.dart';
// import 'package:laphic_app/compound_design.dart';
// import 'package:laphic_app/construction.dart';
// import 'package:laphic_app/feedback.dart';
// import 'package:laphic_app/funitures_designs.dart';
// import 'package:laphic_app/gypsum_works.dart';
// import 'package:laphic_app/interior_design.dart';

// import 'package:laphic_app/metal_fabrication.dart';
// import 'package:laphic_app/painting.dart';
// import 'package:laphic_app/projects_designn.dart';

// class ServicesPage extends StatefulWidget {
//   final String token;

//   const ServicesPage({Key? key, required this.token}) : super(key: key); // Updated from super.key

//   @override
//   // ignore: library_private_types_in_public_api
//   _ServicesPageState createState() => _ServicesPageState();
// }

// class _ServicesPageState extends State<ServicesPage> {
//   final storage = const FlutterSecureStorage();
//   int _currentImageIndex = 0;
//   Timer? _imageTimer;
//   bool _tokenStored = false;
//   final PageController _pageController = PageController();

//   final int _selectedIndex = 1; // Default to Services tab
//   final Color deepNavyBlue = const Color.fromARGB(255, 8, 15, 43);

//   final List<String> headerImages = [
//     "assets/interior7.jpeg",
//     "assets/painting 1.jpg",
//     "assets/interior3.jpeg",
//     "assets/house5.jpeg",
//     "assets/laphic2.PNG",
//     "assets/SWIUXEXDJDK.jpg",
//     "assets/painting2.jpeg",
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _storeToken();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
//           if (mounted && _pageController.hasClients) {
//             setState(() {
//               _currentImageIndex = (_currentImageIndex + 1) % headerImages.length;
//               _pageController.animateToPage(
//                 _currentImageIndex,
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//               if (kDebugMode) {
//                 print('Carousel moved to index: $_currentImageIndex');
//               }
//             });
//           }
//         });
//       }
//     });
//   }

//   Future<void> _storeToken() async {
//     if (widget.token.isNotEmpty) {
//       try {
//         await storage.write(key: 'auth_token', value: widget.token);
//         if (mounted) {
//           setState(() {
//             _tokenStored = true;
//             if (kDebugMode) print('Token stored successfully: ${widget.token}');
//           });
//         }
//       } catch (e) {
//         if (mounted) {
//           if (kDebugMode) print('Token storage failed: $e');
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to store token: $e')),
//           );
//         }
//       }
//     } else {
//       if (kDebugMode) print('No token provided to store');
//     }
//   }

//   void _onItemTapped(int index) {
//     if (index != _selectedIndex) {
//       if (kDebugMode) print('Navigating to index: $index');
//       switch (index) {
//         case 0:
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const FeedbackInquiryScreen()),
//           );
//           break;
//         case 1:
//           break;
//         case 2:
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const OngoingProjects()),
//           );
//           break;
//         case 3:
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const BookingScreen()),
//           );
//           break;
//       }
//     }
//   }

//   void _navigateToPage(int index) {
//     Navigator.pop(context); // Close the drawer
//     if (index == 4) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Settings page is under development'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     } else {
//       _onItemTapped(index);
//     }
//   }

//   @override
//   void dispose() {
//     _imageTimer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       endDrawer: _buildDrawer(),
//       body: Container(
//         color: deepNavyBlue,
//         child: _buildServicesContent(),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
//           BottomNavigationBarItem(icon: Icon(Icons.home_repair_service), label: "Services"),
//           BottomNavigationBarItem(icon: Icon(Icons.construction), label: "Projects"),
//           BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Booking"),
//         ],
//       ),
//     );
//   }

//   Widget _buildDrawer() {
//     return Drawer(
//       width: MediaQuery.of(context).size.width * 0.75,
//       child: Container(
//         color: deepNavyBlue,
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: const BoxDecoration(color: Colors.orange),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const CircleAvatar(
//                     radius: 40,
//                     backgroundColor: Colors.white,
//                     child: Icon(Icons.person, size: 40, color: Colors.orange),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Laphic Services',
//                     style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     'Welcome!',
//                     style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//             _buildDrawerItem(0, Icons.feedback, 'Feedback'),
//             _buildDrawerItem(1, Icons.home_repair_service, 'Services'),
//             _buildDrawerItem(2, Icons.construction, 'Projects'),
//             _buildDrawerItem(3, Icons.book_online, 'Booking'),
//             const Divider(color: Colors.white24),
//             _buildDrawerItem(4, Icons.settings, 'Settings'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDrawerItem(int index, IconData icon, String title) {
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: index == _selectedIndex ? Colors.orange : Colors.white70,
//         size: 24,
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: index == _selectedIndex ? Colors.orange : Colors.white70,
//           fontSize: 16,
//         ),
//       ),
//       selected: index == _selectedIndex,
//       onTap: () => _navigateToPage(index),
//     );
//   }

//   Widget _buildServicesContent() {
//     return SafeArea(
//       child: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 _buildCarousel(),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: _buildServicesGrid(),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 10,
//             right: 10,
//             child: Builder(
//               builder: (context) => Container(
//                 decoration: BoxDecoration(
//                   color: Colors.orange,
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.menu, color: Colors.white),
//                   onPressed: () {
//                     Scaffold.of(context).openEndDrawer();
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildServicesGrid() {
//     return GridView.custom(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: SliverWovenGridDelegate.count(
//         crossAxisCount: 2,
//         mainAxisSpacing: 8,
//         crossAxisSpacing: 8,
//         pattern: [
//           const WovenGridTile(1),
//           const WovenGridTile(1),
//         ],
//       ),
//       childrenDelegate: SliverChildBuilderDelegate(
//         (context, index) {
//           final service = services[index];
//           final bool isFurnitureService = index == 6;

//           final String title = service['title'] as String? ?? 'Unknown Service';
//           final String image = service['image'] as String? ?? 'assets/placeholder.jpg'; // Add a fallback image
//           final Widget? page = service['page'] as Widget?;

//           return GestureDetector(
//             onTap: () {
//               if (_tokenStored || widget.token.isEmpty) {
//                 if (page != null) {
//                   if (kDebugMode) print('Navigating to: $title');
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => page),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Service page not available')),
//                   );
//                 }
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Please wait a moment while we authenticate your session.'),
//                     duration: Duration(seconds: 2),
//                   ),
//                 );
//               }
//             },
//             child: Card(
//               color: Colors.white,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               elevation: 5,
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.asset(
//                       image,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       height: double.infinity,
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.4),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(isFurnitureService ? 16.0 : 8.0),
//                       child: Text(
//                         title,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: isFurnitureService ? 22 : 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//         childCount: services.length,
//       ),
//     );
//   }

//   Widget _buildCarousel() {
//     return Stack(
//       children: [
//         SizedBox(
//           height: 200,
//           child: PageView.builder(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentImageIndex = index;
//               });
//             },
//             itemCount: headerImages.length,
//             itemBuilder: (context, index) {
//               return Stack(
//                 children: [
//                   Image.asset(
//                     headerImages[index],
//                     height: 200,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                   Container(
//                     height: 200,
//                     width: double.infinity,
//                     color: Colors.black.withOpacity(0.4),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//         const Positioned(
//           bottom: 20,
//           left: 20,
//           child: Text(
//             'Services',
//             style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
//           ),
//         ),
//         Positioned(
//           left: 10,
//           top: 80,
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//             onPressed: () {
//               int newIndex = (_currentImageIndex - 1) % headerImages.length;
//               if (newIndex < 0) newIndex = headerImages.length - 1;
//               _pageController.animateToPage(
//                 newIndex,
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//             },
//           ),
//         ),
//         Positioned(
//           right: 10,
//           top: 80,
//           child: IconButton(
//             icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
//             onPressed: () {
//               int newIndex = (_currentImageIndex + 1) % headerImages.length;
//               _pageController.animateToPage(
//                 newIndex,
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//             },
//           ),
//         ),
//         Positioned(
//           bottom: 10,
//           left: 0,
//           right: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               headerImages.length,
//               (index) => Container(
//                 width: 8,
//                 height: 8,
//                 margin: const EdgeInsets.symmetric(horizontal: 4),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _currentImageIndex == index
//                       ? Colors.orange
//                       : Colors.white.withOpacity(0.5),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   final List<Map<String, dynamic>> services = [
//     {"title": "Compound Design", "image": "assets/compound 1.jpg", "page": const CompoundDesignPage()},
//     {"title": "Construction", "image": "assets/SWIUXEXDJDK.jpg", "page": const ConstructionPage()},
//     {"title": "Painting", "image": "assets/painting2.jpeg", "page": const PaintingPage()},
//     {"title": "Interior Design", "image": "assets/design.jpeg", "page": const InteriorGalleryScreen()},
//     {"title": "Metal Fabrication", "image": "assets/metal.jpeg", "page": const MetalFabricationPage()},
//     {"title": "Gypsum Works", "image": "assets/gypsum6.webp", "page": const GypsumWorksScreen()},
//     {"title": "Furniture Works", "image": "assets/gypsum6.webp", "page": const FurnitureDesignScreen()},
//   ];
// }





import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:laphic_app/booking.dart';
import 'package:laphic_app/compound_design.dart';
import 'package:laphic_app/construction.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/funitures_designs.dart';
import 'package:laphic_app/gypsum_works.dart';
import 'package:laphic_app/interior_design.dart';
import 'package:laphic_app/metal_fabrication.dart';
import 'package:laphic_app/painting.dart';
import 'package:laphic_app/projects_designn.dart';

class ServicesPage extends StatefulWidget {
  final String token;

  const ServicesPage({Key? key, required this.token}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final storage = const FlutterSecureStorage();
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  bool _tokenStored = false;
  final PageController _pageController = PageController();

  final int _selectedIndex = 1; // Default to Services tab
  final Color backgroundColor = Colors.white;

  final List<String> headerImages = [
    "assets/interior7.jpeg",
    "assets/painting 1.jpg",
    "assets/interior3.jpeg",
    "assets/house5.jpeg",
    "assets/laphic2.PNG",
    "assets/SWIUXEXDJDK.jpg",
    "assets/painting2.jpeg",
  ];

  @override
  void initState() {
    super.initState();
    _storeToken();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
          if (mounted && _pageController.hasClients) {
            setState(() {
              _currentImageIndex = (_currentImageIndex + 1) % headerImages.length;
              _pageController.animateToPage(
                _currentImageIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            });
          }
        });
      }
    });
  }

  Future<void> _storeToken() async {
    if (widget.token.isNotEmpty) {
      try {
        await storage.write(key: 'auth_token', value: widget.token);
        if (mounted) {
          setState(() {
            _tokenStored = true;
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to store token: $e')),
          );
        }
      }
    }
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FeedbackInquiryScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OngoingProjects()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BookingScreen()),
          );
          break;
      }
    }
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
      body: Container(
        color: backgroundColor,
        child: _buildServicesContent(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
          BottomNavigationBarItem(icon: Icon(Icons.home_repair_service), label: "Services"),
          BottomNavigationBarItem(icon: Icon(Icons.construction), label: "Projects"),
          BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Booking"),
        ],
      ),
    );
  }

  Widget _buildServicesContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCarousel(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildServicesGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesGrid() {
    return GridView.custom(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        pattern: [
          const WovenGridTile(1),
          const WovenGridTile(1),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          final service = services[index];
          final bool isFurnitureService = index == 6;

          final String title = service['title'] as String? ?? 'Unknown Service';
          final String image = service['image'] as String? ?? 'assets/placeholder.jpg';
          final Widget? page = service['page'] as Widget?;

          return GestureDetector(
            onTap: () {
              if (_tokenStored || widget.token.isEmpty) {
                if (page != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => page),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Service page not available')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please wait a moment while we authenticate your session.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(isFurnitureService ? 16.0 : 8.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isFurnitureService ? 22 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: services.length,
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
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemCount: headerImages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.asset(
                    headerImages[index],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ],
              );
            },
          ),
        ),
        const Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            'Services',
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          left: 10,
          top: 80,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              int newIndex = (_currentImageIndex - 1) % headerImages.length;
              if (newIndex < 0) newIndex = headerImages.length - 1;
              _pageController.animateToPage(
                newIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
        Positioned(
          right: 10,
          top: 80,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onPressed: () {
              int newIndex = (_currentImageIndex + 1) % headerImages.length;
              _pageController.animateToPage(
                newIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
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
              headerImages.length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageIndex == index
                      ? Colors.orange
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  final List<Map<String, dynamic>> services = [
    {"title": "Compound Design", "image": "assets/compound 1.jpg", "page": const CompoundDesignPage()},
    {"title": "Construction", "image": "assets/SWIUXEXDJDK.jpg", "page": const ConstructionPage()},
    {"title": "Painting", "image": "assets/painting2.jpeg", "page": const PaintingPage()},
    {"title": "Interior Design", "image": "assets/design.jpeg", "page": const InteriorGalleryScreen()},
    {"title": "Metal Fabrication", "image": "assets/metal.jpeg", "page": const MetalFabricationPage()},
    {"title": "Gypsum Works", "image": "assets/gypsum6.webp", "page": const GypsumWorksScreen()},
    {"title": "Furniture Works", "image": "assets/gypsum6.webp", "page": const FurnitureDesignScreen()},
  ];
}
