



// import 'dart:async';
// import 'package:flutter/foundation.dart' show kDebugMode;
// import 'package:flutter/material.dart';

// class MetalFabricationPage extends StatefulWidget {
//   const MetalFabricationPage({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _MetalFabricationPageState createState() => _MetalFabricationPageState();
// }

// class _MetalFabricationPageState extends State<MetalFabricationPage> {
//   int _currentImageIndex = 0;
//   Timer? _imageTimer;
//   final PageController _pageController = PageController();

//   final List<String> carouselImages = [
//     'assets/metal.jpeg',
//     'assets/SWIUXEXDJDK.jpg',
//     'assets/interior7.jpeg',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
//           if (mounted && _pageController.hasClients) {
//             setState(() {
//               _currentImageIndex = (_currentImageIndex + 1) % carouselImages.length;
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

//   @override
//   void dispose() {
//     _imageTimer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Metal Fabrication',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildCarousel(),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: Text(
//                 "Metal Fabrication Works",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
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
//                 itemCount: metalWorks.length,
//                 itemBuilder: (context, index) {
//                   final work = metalWorks[index];
//                   final String image = work['image'] ?? 'assets/metal.jpeg';
//                   final String title = work['title'] ?? 'Unknown Work';
//                   final String price = work['price'] ?? 'N/A';

//                   return Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 4,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(10),
//                           ),
//                           child: Image.asset(
//                             image,
//                             height: 120,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               if (kDebugMode) print('Failed to load image: $image, error: $error');
//                               return const Center(child: Icon(Icons.error));
//                             },
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 title,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 price,
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

//   Widget _buildCarousel() {
//     return Stack(
//       children: [
//         SizedBox(
//           height: 180,
//           child: PageView.builder(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentImageIndex = index;
//               });
//             },
//             itemCount: carouselImages.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: DecorationImage(
//                     image: AssetImage(carouselImages[index]),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Positioned(
//           bottom: 20,
//           left: 0,
//           right: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               carouselImages.length,
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
// }

// final List<Map<String, String>> metalWorks = [
//   {"title": "Steel Gate", "price": "8,000,000 UGX", "image": "assets/metal.jpeg"},
//   {"title": "Iron Railings", "price": "7,000,000 UGX", "image": "assets/metal.jpeg"},
//   {"title": "Metal Frame", "price": "6,000,000 UGX", "image": "assets/metal.jpeg"},
//   {"title": "Custom Grill", "price": "9,000,000 UGX", "image": "assets/metal.jpeg"},
//   {"title": "Steel Stairs", "price": "3,000,000 UGX", "image": "assets/metal.jpeg"},
//   {"title": "Metal Shelf", "price": "6,000,000 UGX", "image": "assets/metal.jpeg"},
//   {"title": "Wrought Iron", "price": "3,000,000 UGX", "image": "assets/metal.jpeg"},
//   {"title": "Basic Frame", "price": "2,000,000 UGX", "image": "assets/metal.jpeg"},
//   {"title": "Ornate Gate", "price": "9,000,000 UGX", "image": "assets/metal.jpeg"},
//   {"title": "Heavy Duty", "price": "12,000,000 UGX", "image": "assets/metal.jpeg"},
// ];




import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/livechat.dart';
import 'package:laphic_app/metalDetails.dart';

import 'package:laphic_app/profile_screen.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';

class MetalFabricationPage extends StatefulWidget {
  const MetalFabricationPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MetalFabricationPageState createState() => _MetalFabricationPageState();
}

class _MetalFabricationPageState extends State<MetalFabricationPage> {
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();
  int _navIndex = 0; // Metal Fabrication is index 0

  final List<String> carouselImages = [
    'assets/metal.jpeg',
    'assets/SWIUXEXDJDK.jpg',
    'assets/interior7.jpeg',
  ];

  final List<Map<String, String>> metalWorks = [
    {
      'title': 'Steel Gate',
      'price': '8,000,000 UGX',
      'image': 'assets/metal.jpeg',
      'description': 'A durable steel gate designed for security and aesthetic appeal, suitable for residential and commercial properties.'
    },
    {
      'title': 'Iron Railings',
      'price': '7,000,000 UGX',
      'image': 'assets/metal.jpeg',
      'description': 'Custom iron railings for staircases or balconies, crafted with precision for safety and elegance.'
    },
    {
      'title': 'Metal Frame',
      'price': '6,000,000 UGX',
      'image': 'assets/metal.jpeg',
      'description': 'Sturdy metal frame for structural support, ideal for construction projects or furniture.'
    },
    {
      'title': 'Custom Grill',
      'price': '9,000,000 UGX',
      'image': 'assets/metal.jpeg',
      'description': 'Bespoke metal grill for windows or doors, combining security with intricate design.'
    },
    {
      'title': 'Steel Stairs',
      'price': '3,000,000 UGX',
      'image': 'assets/metal.jpeg',
      'description': 'Modern steel staircase, engineered for durability and sleek appearance.'
    },
    {
      'title': 'Metal Shelf',
      'price': '6,000,000 UGX',
      'image': 'assets/metal.jpeg',
      'description': 'Heavy-duty metal shelving unit, perfect for storage in warehouses or homes.'
    },
    {
      'title': 'Wrought Iron',
      'price': '3,000,000 UGX',
      'image': 'assets/metal.jpeg',
      'description': 'Ornamental wrought iron piece, ideal for decorative fencing or furniture accents.'
    },
    {
      'title': 'Basic Frame',
      'price': '2,000,000 UGX',
      'image': 'assets/metal.jpeg',
      'description': 'Simple yet robust metal frame for various applications, from signage to construction.'
    },
    {
      'title': 'Ornate Gate',
      'price': '9,000,000 UGX',
      'image': 'assets/metal.jpeg',
      'description': 'An intricately designed gate, blending functionality with artistic craftsmanship.'
    },
    {
      'title': 'Heavy Duty',
      'price': '12,000,000 UGX',
      'image': 'assets/metal.jpeg',
      'description': 'Heavy-duty metal structure for industrial use, built to withstand extreme conditions.'
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        for (var image in carouselImages) {
          precacheImage(AssetImage(image), context);
        }
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted && _pageController.hasClients && carouselImages.isNotEmpty) {
        setState(() {
          _currentImageIndex = (_currentImageIndex + 1) % carouselImages.length;
          _pageController.animateToPage(
            _currentImageIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          if (kDebugMode) {
            print('Carousel moved to index: $_currentImageIndex');
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

  void _onNavTap(int index) {
    if (index == _navIndex) return;
    setState(() {
      _navIndex = index;
    });
    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const MetalFabricationPage();
        break;
      case 1:
        nextScreen = const ServicesHomePage();
        break;
      case 2:
        nextScreen = const BookingScreen();
        break;
      case 3:
        nextScreen = const ProfilePage();
        break;
      case 4:
        nextScreen = const ChatPage();
        break;
      case 5:
        nextScreen = const OngoingProjects();
        break;
      case 6:
        nextScreen = const FeedbackInquiryScreen();
        break;
      default:
        return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.grey.shade100,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCarousel(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  "Metal Fabrication Works",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: metalWorks.length,
                  itemBuilder: (context, index) {
                    final work = metalWorks[index];
                    final String image = work['image'] ?? 'assets/metal.jpeg';
                    final String title = work['title'] ?? 'Unknown Work';
                    final String price = work['price'] ?? 'N/A';

                    return Semantics(
                      label: 'Metal work: $title, Price: $price',
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MetalWorkDetailsScreen(work: work),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade200, width: 1),
                          ),
                          elevation: 3,
                          shadowColor: Colors.black26,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  child: Image.asset(
                                    image,
                                    height: 80, // Reduced from 120px
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      if (kDebugMode) print('Failed to load image: $image, error: $error');
                                      return const Center(child: Icon(Icons.error, size: 40));
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      price,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _navIndex,
          onTap: _onNavTap,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey.shade600,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.construction), label: 'Metal Works'),
            BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Services'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Booking'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'),
            BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    if (carouselImages.isEmpty) {
      return const SizedBox(
        height: 140,
        child: Center(child: Text('No images available', style: TextStyle(color: Colors.grey))),
      );
    }
    return Stack(
      children: [
        Container(
          height: 140, // Reduced from 180px
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
              _imageTimer?.cancel();
              _imageTimer = Timer(const Duration(seconds: 5), () => _startTimer());
            },
            itemCount: carouselImages.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(carouselImages[index]),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      if (kDebugMode) print('Failed to load carousel image: ${carouselImages[index]}, error: $exception');
                    },
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          height: 140,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
            ),
          ),
        ),
        Positioned(
          bottom: 15,
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
                  color: _currentImageIndex == index ? Colors.orange : Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 15,
          top: 55,
          child: IconButton(
            icon: const Icon(Icons.arrow_left, color: Colors.white, size: 24),
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
        Positioned(
          right: 15,
          top: 55,
          child: IconButton(
            icon: const Icon(Icons.arrow_right, color: Colors.white, size: 24),
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ],
    );
  }
} 