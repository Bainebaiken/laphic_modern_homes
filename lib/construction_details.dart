import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:laphic_app/booking.dart';


import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/interior_design.dart';
import 'package:laphic_app/livechat.dart';
import 'package:laphic_app/metal_fabrication.dart';

import 'package:laphic_app/profile_screen.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';


class ConstructionDetailsScreen extends StatelessWidget {
  final Map<String, String> design;

  const ConstructionDetailsScreen({Key? key, required this.design}) : super(key: key);

  void _onNavTap(BuildContext context, int index) {
    if (index == 3) return; // Stay on Booking (Construction)
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
    final String image = design['image'] ?? 'assets/house5.jpeg';
    final String title = design['title'] ?? 'Unknown Design';
    final String price = design['price'] ?? 'N/A';
    final String description = design['description'] ?? 'No description available.';

    // Embedded relatedDesigns data
    final List<Map<String, String>> relatedDesigns = [
      {
        'title': 'Simple & Affordable',
        'price': '500,000 UGX',
        'image': 'assets/house5.jpeg',
        'description': 'A cost-effective home design with practical layouts for small families.'
      },
      {
        'title': 'Modern Villa',
        'price': '400,000 UGX',
        'image': 'assets/house5.jpeg',
        'description': 'A sleek villa with contemporary architecture and open spaces.'
      },
      {
        'title': 'Humble Home',
        'price': '500,000 UGX',
        'image': 'assets/house5.jpeg',
        'description': 'A cozy home design emphasizing comfort and simplicity.'
      },
      {
        'title': 'Modern Villa',
        'price': '400,000 UGX',
        'image': 'assets/house5.jpeg',
        'description': 'A sleek villa with contemporary architecture and open spaces.'
      },
      {
        'title': 'Humble Home',
        'price': '500,000 UGX',
        'image': 'assets/house5.jpeg',
        'description': 'A cozy home design emphasizing comfort and simplicity.'
      },
      {
        'title': 'Modern Villa',
        'price': '400,000 UGX',
        'image': 'assets/house5.jpeg',
        'description': 'A sleek villa with contemporary architecture and open spaces.'
      },
      {
        'title': 'Humble Home',
        'price': '500,000 UGX',
        'image': 'assets/house5.jpeg',
        'description': 'A cozy home design emphasizing comfort and simplicity.'
      },
    ];

    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.grey.shade100,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.orange,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (kDebugMode) print('Main image tapped');
                },
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  frameBuilder: (context, child, frame, _) =>
                      frame == null
                          ? Container(
                              height: 180,
                              color: Colors.grey.shade200,
                              child: const Center(child: CircularProgressIndicator(color: Colors.orange)),
                            )
                          : child,
                  errorBuilder: (context, error, stackTrace) {
                    if (kDebugMode) print('Failed to load image: $image, error: $error');
                    return Container(
                      height: 180,
                      color: Colors.grey.shade200,
                      child: const Center(child: Icon(Icons.error, size: 40, color: Colors.red)),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Price: $price',
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Description',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Related Designs',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: relatedDesigns.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                          indent: 16,
                          endIndent: 16,
                        ),
                        itemBuilder: (context, index) {
                          final relatedDesign = relatedDesigns[index];
                          final String relatedImage = relatedDesign['image'] ?? 'assets/house5.jpeg';
                          final String relatedTitle = relatedDesign['title'] ?? 'Unknown Design';
                          final String relatedPrice = relatedDesign['price'] ?? 'N/A';

                          return _RelatedDesignCard(
                            image: relatedImage,
                            title: relatedTitle,
                            price: relatedPrice,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConstructionDetailsScreen(design: relatedDesign),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BookingScreen()),
            );
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.book, color: Colors.white),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 3, // Highlight Booking (Construction)
          onTap: (index) => _onNavTap(context, index),
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey.shade600,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: const [
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
}

class _RelatedDesignCard extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final VoidCallback onTap;

  const _RelatedDesignCard({
    required this.image,
    required this.title,
    required this.price,
    required this.onTap,
  });

  @override
  _RelatedDesignCardState createState() => _RelatedDesignCardState();
}

class _RelatedDesignCardState extends State<_RelatedDesignCard> with SingleTickerProviderStateMixin {
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
      label: 'Related construction design: ${widget.title}, Price: ${widget.price}, Tap to view details',
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
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange.withOpacity(0.1),
                  Colors.white,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                  child: Stack(
                    children: [
                      Image.asset(
                        widget.image,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        frameBuilder: (context, child, frame, _) =>
                            frame == null
                                ? Container(
                                    width: 120,
                                    height: 120,
                                    color: Colors.grey.shade200,
                                    child: const Center(child: CircularProgressIndicator(color: Colors.orange)),
                                  )
                                : child,
                        errorBuilder: (context, error, stackTrace) {
                          if (kDebugMode) print('Failed to load related image: ${widget.image}, error: $error');
                          return Container(
                            width: 120,
                            height: 120,
                            color: Colors.grey.shade200,
                            child: const Center(child: Icon(Icons.error, size: 30, color: Colors.red)),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Price: ${widget.price}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
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

