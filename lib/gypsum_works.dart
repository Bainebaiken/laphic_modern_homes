


// import 'dart:async';
// import 'package:flutter/foundation.dart' show kDebugMode;
// import 'package:flutter/material.dart';

// import 'package:laphic_app/feedback.dart';
// import 'package:laphic_app/gypsum_details.dart';


// class GypsumWorksScreen extends StatefulWidget {
//   const GypsumWorksScreen({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _GypsumWorksScreenState createState() => _GypsumWorksScreenState();
// }

// class _GypsumWorksScreenState extends State<GypsumWorksScreen> {
//   int _currentImageIndex = 0;
//   Timer? _imageTimer;
//   final PageController _pageController = PageController();
//   final int _navIndex = 1; // Services (aligned with MainScreen)

//   final List<String> carouselImages = [
//     'assets/gypsum6.webp',
//     'assets/gypsum1.webp', // Replaced interior7.jpeg
//     'assets/gypsum2.webp', // Replaced kit.jpg
//   ];

//   final List<Map<String, String>> gypsumDesigns = [
//     {
//       "title": "Simple & Affordable",
//       "price": "500,000 UGX",
//       "image": "assets/gypsum6.webp",
//       "description": "A minimalist gypsum ceiling design, cost-effective and elegant for small spaces."
//     },
//     {
//       "title": "Grey Lights",
//       "price": "400,000 UGX",
//       "image": "assets/gypsum6.webp",
//       "description": "Modern gypsum design with integrated grey lighting for a sleek ambiance."
//     },
//     {
//       "title": "Humble Lights",
//       "price": "500,000 UGX",
//       "image": "assets/gypsum6.webp",
//       "description": "Warm gypsum ceiling with subtle lighting, perfect for cozy interiors."
//     },
//     {
//       "title": "Brown Design",
//       "price": "300,000 UGX",
//       "image": "assets/gypsum6.webp",
//       "description": "Earthy brown-toned gypsum design for a rustic aesthetic."
//     },
//     {
//       "title": "Blue Design",
//       "price": "400,000 UGX",
//       "image": "assets/gypsum6.webp",
//       "description": "Vibrant blue gypsum ceiling with dynamic patterns for bold spaces."
//     },
//     {
//       "title": "Rectangle Design",
//       "price": "300,000 UGX",
//       "image": "assets/gypsum6.webp",
//       "description": "Geometric rectangular gypsum design for a structured, modern look."
//     },
//     {
//       "title": "Grey Design",
//       "price": "400,000 UGX",
//       "image": "assets/gypsum6.webp",
//       "description": "Neutral grey gypsum ceiling, versatile for various interior styles."
//     },
//     {
//       "title": "Purple Design",
//       "price": "400,000 UGX",
//       "image": "assets/gypsum6.webp",
//       "description": "Elegant purple-toned gypsum design for a luxurious touch."
//     },
//     {
//       "title": "Circular Lights",
//       "price": "400,000 UGX",
//       "image": "assets/gypsum6.webp",
//       "description": "Gypsum ceiling with circular light fixtures for a contemporary feel."
//     },
//     {
//       "title": "Deep Lights",
//       "price": "800,000 UGX",
//       "image": "assets/gypsum6.webp",
//       "description": "Premium gypsum design with deep-set lighting for dramatic effect."
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         for (var image in carouselImages) {
//           precacheImage(AssetImage(image), context, onError: (exception, stackTrace) {
//             if (kDebugMode) print('Failed to precache image: $image, error: $exception');
//           });
//         }
//         _startTimer();
//       }
//     });
//   }

//   void _startTimer() {
//     _imageTimer?.cancel(); // Ensure no duplicate timers
//     _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (mounted && _pageController.hasClients && carouselImages.isNotEmpty) {
//         setState(() {
//           _currentImageIndex = (_currentImageIndex + 1) % carouselImages.length;
//           _pageController.animateToPage(
//             _currentImageIndex,
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.easeInOut,
//           );
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

//   void _onNavTap(BuildContext context, int index) {
//     if (index == 1) return; // Stay on Services
//     if (index < 0 || index >= 6) {
//       if (kDebugMode) print('Invalid navigation index: $index');
//       return;
//     }
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => MainScreen(initialIndex: index)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         primaryColor: Colors.orange,
//         scaffoldBackgroundColor: Colors.grey.shade100,
//         textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
//       ),
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildCarousel(),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                 child: Text(
//                   "Gypsum Designs",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     childAspectRatio: 3 / 4,
//                   ),
//                   itemCount: gypsumDesigns.length,
//                   itemBuilder: (context, index) {
//                     final design = gypsumDesigns[index];
//                     final String image = design['image'] ?? 'assets/gypsum6.webp';
//                     final String title = design['title'] ?? 'Unknown Design';
//                     final String price = design['price'] ?? 'N/A';

//                     return _DesignCard(
//                       image: image,
//                       title: title,
//                       price: price,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => GypsumDetailsScreen(design: design),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _navIndex,
//           onTap: (index) => _onNavTap(context, index),
//           selectedItemColor: Colors.orange,
//           unselectedItemColor: Colors.grey.shade600,
//           backgroundColor: Colors.white,
//           type: BottomNavigationBarType.fixed,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Services'),
//             BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Projects'),
//             BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
//             BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
//             BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCarousel() {
//     if (carouselImages.isEmpty) {
//       return const SizedBox(
//         height: 140,
//         child: Center(child: Text('No images available', style: TextStyle(color: Colors.grey))),
//       );
//     }
//     return Stack(
//       children: [
//         Container(
//           height: 140,
//           margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           child: PageView.builder(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() => _currentImageIndex = index);
//             },
//             itemCount: carouselImages.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   image: DecorationImage(
//                     image: AssetImage(carouselImages[index]),
//                     fit: BoxFit.cover,
//                     onError: (exception, stackTrace) {
//                       if (kDebugMode) print('Failed to load carousel image: ${carouselImages[index]}, error: $exception');
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Container(
//           height: 140,
//           margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 15,
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
//                   color: _currentImageIndex == index ? Colors.orange : Colors.white.withOpacity(0.7),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           left: 15,
//           top: 55,
//           child: IconButton(
//             icon: const Icon(Icons.arrow_left, color: Colors.white, size: 24),
//             onPressed: () {
//               _pageController.previousPage(
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//             },
//           ),
//         ),
//         Positioned(
//           right: 15,
//           top: 55,
//           child: IconButton(
//             icon: const Icon(Icons.arrow_right, color: Colors.white, size: 24),
//             onPressed: () {
//               _pageController.nextPage(
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _DesignCard extends StatefulWidget {
//   final String image;
//   final String title;
//   final String price;
//   final VoidCallback onTap;

//   const _DesignCard({
//     required this.image,
//     required this.title,
//     required this.price,
//     required this.onTap,
//   });

//   @override
//   _DesignCardState createState() => _DesignCardState();
// }

// class _DesignCardState extends State<_DesignCard> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 200),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Semantics(
//       label: 'Gypsum design: ${widget.title}, Price: ${widget.price}, Tap to view details',
//       child: GestureDetector(
//         onTapDown: (_) => _controller.forward(),
//         onTapUp: (_) {
//           _controller.reverse();
//           widget.onTap();
//         },
//         onTapCancel: () => _controller.reverse(),
//         child: AnimatedBuilder(
//           animation: _scaleAnimation,
//           builder: (context, child) {
//             return Transform.scale(
//               scale: _scaleAnimation.value,
//               child: child,
//             );
//           },
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//               side: BorderSide(color: Colors.grey.shade200, width: 1),
//             ),
//             elevation: 3,
//             shadowColor: Colors.black26,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Expanded(
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//                     child: Stack(
//                       children: [
//                         Image.asset(
//                           widget.image,
//                           fit: BoxFit.cover,
//                           frameBuilder: (context, child, frame, _) => frame == null
//                               ? Container(
//                                   color: Colors.grey.shade200,
//                                   child: const Center(child: CircularProgressIndicator(color: Colors.orange)),
//                                 )
//                               : child,
//                           errorBuilder: (context, error, stackTrace) {
//                             if (kDebugMode) print('Failed to load image: ${widget.image}, error: $error');
//                             return Container(
//                               color: Colors.grey.shade200,
//                               child: const Center(child: Icon(Icons.error, size: 40, color: Colors.red)),
//                             );
//                           },
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           left: 0,
//                           right: 0,
//                           child: Container(
//                             height: 30,
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 begin: Alignment.bottomCenter,
//                                 end: Alignment.topCenter,
//                                 colors: [Colors.black.withOpacity(0.4), Colors.transparent],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.title,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 16,
//                           color: Colors.black87,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         widget.price,
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
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


import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/gypsum_details.dart';

class GypsumWorksScreen extends StatefulWidget {
  const GypsumWorksScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GypsumWorksScreenState createState() => _GypsumWorksScreenState();
}

class _GypsumWorksScreenState extends State<GypsumWorksScreen> with SingleTickerProviderStateMixin {
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();
  final int _navIndex = 1; // Services (aligned with MainScreen)
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();
  bool _showTopShadow = false;

  final List<String> carouselImages = [
    'assets/gypsum6.webp',
    'assets/gypsum1.webp',
    'assets/gypsum2.webp',
  ];

  final List<Map<String, String>> gypsumDesigns = [
    {
      "title": "Simple & Affordable",
      "price": "500,000 UGX",
      "image": "assets/gypsum6.webp",
      "description": "A minimalist gypsum ceiling design, cost-effective and elegant for small spaces."
    },
    {
      "title": "Grey Lights",
      "price": "400,000 UGX",
      "image": "assets/gypsum6.webp",
      "description": "Modern gypsum design with integrated grey lighting for a sleek ambiance."
    },
    {
      "title": "Humble Lights",
      "price": "500,000 UGX",
      "image": "assets/gypsum6.webp",
      "description": "Warm gypsum ceiling with subtle lighting, perfect for cozy interiors."
    },
    {
      "title": "Brown Design",
      "price": "300,000 UGX",
      "image": "assets/gypsum6.webp",
      "description": "Earthy brown-toned gypsum design for a rustic aesthetic."
    },
    {
      "title": "Blue Design",
      "price": "400,000 UGX",
      "image": "assets/gypsum6.webp",
      "description": "Vibrant blue gypsum ceiling with dynamic patterns for bold spaces."
    },
    {
      "title": "Rectangle Design",
      "price": "300,000 UGX",
      "image": "assets/gypsum6.webp",
      "description": "Geometric rectangular gypsum design for a structured, modern look."
    },
    {
      "title": "Grey Design",
      "price": "400,000 UGX",
      "image": "assets/gypsum6.webp",
      "description": "Neutral grey gypsum ceiling, versatile for various interior styles."
    },
    {
      "title": "Purple Design",
      "price": "400,000 UGX",
      "image": "assets/gypsum6.webp",
      "description": "Elegant purple-toned gypsum design for a luxurious touch."
    },
    {
      "title": "Circular Lights",
      "price": "400,000 UGX",
      "image": "assets/gypsum6.webp",
      "description": "Gypsum ceiling with circular light fixtures for a contemporary feel."
    },
    {
      "title": "Deep Lights",
      "price": "800,000 UGX",
      "image": "assets/gypsum6.webp",
      "description": "Premium gypsum design with deep-set lighting for dramatic effect."
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _scrollController.addListener(_scrollListener);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        for (var image in carouselImages) {
          precacheImage(AssetImage(image), context, onError: (exception, stackTrace) {
            if (kDebugMode) print('Failed to precache image: $image, error: $exception');
          });
        }
        _startTimer();
      }
    });
  }

  void _scrollListener() {
    if (_scrollController.offset > 10 && !_showTopShadow) {
      setState(() {
        _showTopShadow = true;
      });
    } else if (_scrollController.offset <= 10 && _showTopShadow) {
      setState(() {
        _showTopShadow = false;
      });
    }
  }

  void _startTimer() {
    _imageTimer?.cancel(); // Ensure no duplicate timers
    _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted && _pageController.hasClients && carouselImages.isNotEmpty) {
        setState(() {
          _currentImageIndex = (_currentImageIndex + 1) % carouselImages.length;
          _pageController.animateToPage(
            _currentImageIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _imageTimer?.cancel();
    _pageController.dispose();
    _animationController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _onNavTap(BuildContext context, int index) {
    if (index == 1) return; // Stay on Services
    if (index < 0 || index >= 6) {
      if (kDebugMode) print('Invalid navigation index: $index');
      return;
    }
    
    // Animate navigation selection
    _animationController.forward().then((_) {
      _animationController.reverse();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(initialIndex: index)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.orange,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          primary: Colors.orange,
          secondary: Colors.orangeAccent,
        ),
        scaffoldBackgroundColor: Colors.grey.shade50,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 160.0,
                    floating: true,
                    pinned: true,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      background: _buildCarousel(),
                      title: Text(
                        'Gypsum Designs',
                        style: TextStyle(
                          color: _showTopShadow ? Colors.black87 : Colors.transparent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      centerTitle: true,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 8),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Our Collections",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          _buildFilterButton(),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 3 / 4,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final design = gypsumDesigns[index];
                          final String image = design['image'] ?? 'assets/gypsum6.webp';
                          final String title = design['title'] ?? 'Unknown Design';
                          final String price = design['price'] ?? 'N/A';

                          return _DesignCard(
                            image: image,
                            title: title,
                            price: price,
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => GypsumDetailsScreen(design: design),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        childCount: gypsumDesigns.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      child: _buildPromoCard(),
                    ),
                  ),
                ],
              ),
              if (_showTopShadow)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Scroll to top
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.arrow_upward, color: Colors.white),
        ),
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: _navIndex,
          onTap: (index) => _onNavTap(context, index),
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey.shade600,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 11,
          ),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'Profile',
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Services',
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.home),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.layers),
              label: 'Projects',
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.layers),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.chat),
              label: 'Chat',
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.chat),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.book),
              label: 'Booking',
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.book),
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.feedback),
              label: 'Feedback',
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.feedback),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return OutlinedButton.icon(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => _buildFilterModal(),
        );
      },
      icon: const Icon(Icons.filter_list, size: 18),
      label: const Text("Filter"),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.orange,
        side: const BorderSide(color: Colors.orange),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildFilterModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Filter Designs",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                color: Colors.grey,
              ),
            ],
          ),
          const Divider(),
          const Text(
            "Price Range",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // Price range slider would go here
          const Divider(),
          const Text(
            "Design Style",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // Design style chips would go here
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade800,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Reset"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Apply"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCard() {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Colors.orange, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "15% OFF",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "On all premium designs",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.orange,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Get Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    if (carouselImages.isEmpty) {
      return const SizedBox(
        height: 180,
        child: Center(child: Text('No images available', style: TextStyle(color: Colors.grey))),
      );
    }
    return Stack(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentImageIndex = index);
            },
            itemCount: carouselImages.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
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
          height: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Column(
            children: [
              const Text(
                "Premium Gypsum Designs",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      offset: Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  carouselImages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _currentImageIndex == index ? 20 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: _currentImageIndex == index ? Colors.orange : Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          top: 90,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 90,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.white, size: 28),
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _DesignCard extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final VoidCallback onTap;

  const _DesignCard({
    required this.image,
    required this.title,
    required this.price,
    required this.onTap,
  });

  @override
  _DesignCardState createState() => _DesignCardState();
}

class _DesignCardState extends State<_DesignCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Gypsum design: ${widget.title}, Price: ${widget.price}, Tap to view details',
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap();
        },
        onTapCancel: () => _controller.reverse(),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _isHovering ? Colors.black.withOpacity(0.12) : Colors.black.withOpacity(0.08),
                    blurRadius: _isHovering ? 8 : 4,
                    spreadRadius: _isHovering ? 2 : 0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Hero(
                              tag: 'design_${widget.title}',
                              child: Image.asset(
                                widget.image,
                                fit: BoxFit.cover,
                                frameBuilder: (context, child, frame, _) => frame == null
                                    ? Container(
                                        color: Colors.grey.shade200,
                                        child: const Center(child: CircularProgressIndicator(color: Colors.orange)),
                                      )
                                    : child,
                                errorBuilder: (context, error, stackTrace) {
                                  if (kDebugMode) print('Failed to load image: ${widget.image}, error: $error');
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: const Center(child: Icon(Icons.error, size: 40, color: Colors.red)),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  "Popular",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.price,
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.star, color: Colors.amber, size: 14),
                                  Text(
                                    " 4.8",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}