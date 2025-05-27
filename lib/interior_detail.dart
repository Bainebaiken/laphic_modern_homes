import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/livechat.dart';
import 'package:laphic_app/profile_screen.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';


class InteriorDetailsScreen extends StatelessWidget {
  final Map<String, String> design;

  const InteriorDetailsScreen({Key? key, required this.design}) : super(key: key);

  void _onNavTap(BuildContext context, int index) {
    if (index == 1) return; // Stay on Interior Gallery
    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const ProfilePage();
        break;
      case 1:
        nextScreen = const ServicesHomePage();
        break;
      
      case 2:
        nextScreen = const OngoingProjects();
        break;
      case 3:
        nextScreen = const ChatPage();
        break;
          
      case 4:
        nextScreen = const BookingScreen(initialDesign: '', initialServiceType: '',);
        break;
        
      case 5:
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
    final String image = design['image'] ?? 'assets/interior3.jpeg';
    final String title = design['title'] ?? 'Untitled Design';
    final String price = design['price'] ?? 'N/A';
    final String description = design['description'] ?? 'No description available.';

    // Embedded relatedDesigns data
    final List<Map<String, String>> relatedDesigns = [
      {
        'title': 'Affordable',
        'price': '8,000,000 UGX',
        'image': 'assets/interior3.jpeg',
        'description': 'A cost-effective interior design with modern aesthetics, perfect for small spaces.'
      },
      {
        'title': 'Golden Theme',
        'price': '9,000,000 UGX',
        'image': 'assets/interior3.jpeg',
        'description': 'Luxurious golden accents for an opulent and elegant interior.'
      },
      {
        'title': 'Black Theme',
        'price': '3,000,000 UGX',
        'image': 'assets/interior3.jpeg',
        'description': 'Sleek and minimalist black-themed design for a modern look.'
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
              Image.asset(
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
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                            blurRadius: 10,
                            offset: const Offset(0, 2),
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
                          final String relatedImage = relatedDesign['image'] ?? 'assets/interior3.jpeg';
                          final String relatedTitle = relatedDesign['title'] ?? 'Untitled Design';
                          final String relatedPrice = relatedDesign['price'] ?? 'N/A';

                          return _RelatedDesignCard(
                            image: relatedImage,
                            title: relatedTitle,
                            price: relatedPrice,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InteriorDetailsScreen(design: relatedDesign),
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1, // Highlight Interior
          onTap: (index) => _onNavTap(context, index),
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey.shade600,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
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
      label: 'Related design: ${widget.title}, Price: ${widget.price}, Tap to view details',
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