import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:laphic_app/booking.dart';

import 'package:laphic_app/feedback.dart';

import 'package:laphic_app/interior_design.dart';
import 'package:laphic_app/livechat.dart' show ChatPage;
import 'package:laphic_app/metal_fabrication.dart';
import 'package:laphic_app/painting_details.dart';

import 'package:laphic_app/profile_screen.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';

class PaintingPage extends StatefulWidget {
  const PaintingPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PaintingPageState createState() => _PaintingPageState();
}

class _PaintingPageState extends State<PaintingPage> {
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();
  int _navIndex = 8; // Painting is index 8 (per MainScreen)

  final List<String> carouselImages = [
    'assets/painting 1.jpg',
    'assets/painting2.jpeg',
    'assets/interior7.jpeg',
  ];

  final List<Map<String, String>> paintingDesigns = [
    {
      "title": "Simple & Affordable",
      "price": "500,000 UGX",
      "image": "assets/painting 1.jpg",
      "description": "A clean and budget-friendly painting scheme with neutral tones."
    },
    {
      "title": "Grey Lights",
      "price": "400,000 UGX",
      "image": "assets/painting 1.jpg",
      "description": "A modern grey palette with subtle lighting accents."
    },
    {
      "title": "Humble Lights",
      "price": "500,000 UGX",
      "image": "assets/painting 1.jpg",
      "description": "Warm and cozy painting design with soft lighting effects."
    },
    {
      "title": "Brown Design",
      "price": "300,000 UGX",
      "image": "assets/painting 1.jpg",
      "description": "Earthy brown tones for a rustic and natural feel."
    },
    {
      "title": "Blue Design",
      "price": "400,000 UGX",
      "image": "assets/painting 1.jpg",
      "description": "Vibrant blue hues for a bold and refreshing look."
    },
    {
      "title": "Rectangle Design",
      "price": "300,000 UGX",
      "image": "assets/painting 1.jpg",
      "description": "Geometric patterns with clean lines and modern aesthetics."
    },
    {
      "title": "Grey Design",
      "price": "400,000 UGX",
      "image": "assets/painting 1.jpg",
      "description": "Sleek grey tones for a contemporary painting style."
    },
    {
      "title": "Purple Design",
      "price": "400,000 UGX",
      "image": "assets/painting 1.jpg",
      "description": "Bold purple accents for a unique and artistic vibe."
    },
    {
      "title": "Circular Lights",
      "price": "400,000 UGX",
      "image": "assets/painting 1.jpg",
      "description": "Circular patterns with illuminated painting effects."
    },
    {
      "title": "Deep Lights",
      "price": "800,000 UGX",
      "image": "assets/painting 1.jpg",
      "description": "Luxurious deep tones with premium lighting integration."
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
        nextScreen = const InteriorGalleryScreen();
        break;
      case 2:
        nextScreen = const ServicesHomePage();
        break;
      case 3:
        nextScreen = const BookingScreen();
        break;
      case 4:
        nextScreen = const ProfilePage();
        break;
      case 5:
        nextScreen = const ChatPage();
        break;
      case 6:
        nextScreen = const OngoingProjects();
        break;
      case 7:
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
                  "Painting Designs",
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
                  itemCount: paintingDesigns.length,
                  itemBuilder: (context, index) {
                    final design = paintingDesigns[index];
                    final String image = design['image'] ?? 'assets/painting 1.jpg';
                    final String title = design['title'] ?? 'Unknown Design';
                    final String price = design['price'] ?? 'N/A';

                    return _DesignCard(
                      image: image,
                      title: title,
                      price: price,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaintingDetailsScreen(design: design),
                          ),
                        );
                      },
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'service'),
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
          height: 140,
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
                  color: _currentImageIndex == index ? Colors.orange : Colors.grey.shade400,
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
      label: 'Painting design: ${widget.title}, Price: ${widget.price}, Tap to view details',
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap();
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            elevation: 3,
            shadowColor: Colors.black26,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Stack(
                      children: [
                        Image.asset(
                          widget.image,
                          height: 80,
                          fit: BoxFit.cover,
                          frameBuilder: (context, child, frame, _) =>
                              frame == null
                                  ? Container(
                                      height: 80,
                                      color: Colors.grey.shade200,
                                      child: const Center(child: CircularProgressIndicator(color: Colors.orange)),
                                    )
                                  : child,
                          errorBuilder: (context, error, stackTrace) {
                            if (kDebugMode) print('Failed to load image: ${widget.image}, error: $error');
                            return Container(
                              height: 80,
                              color: Colors.grey.shade200,
                              child: const Center(child: Icon(Icons.error, size: 40, color: Colors.red)),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                      Text(
                        widget.price,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}