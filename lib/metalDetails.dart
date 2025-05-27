import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/livechat.dart';
import 'package:laphic_app/metal_fabrication.dart';

import 'package:laphic_app/profile_screen.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';

class MetalWorkDetailsScreen extends StatelessWidget {
  final Map<String, String> work;

  const MetalWorkDetailsScreen({Key? key, required this.work}) : super(key: key);

  void _onNavTap(BuildContext context, int index) {
    if (index == 0) return; // Stay on Metal Works
    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const MetalFabricationPage();
        break;
      case 1:
        nextScreen = const ServicesHomePage();
        break;
      case 2:
        nextScreen = const BookingScreen(initialDesign: '', initialServiceType: '',);
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
    final String image = work['image'] ?? 'assets/metal.jpeg';
    final String title = work['title'] ?? 'Unknown Work';
    final String price = work['price'] ?? 'N/A';
    final String description = work['description'] ?? 'No description available.';

    // Embedded relatedWorks data
    final List<Map<String, String>> relatedWorks = [
      {
        'title': 'Steel Gate',
        'price': '8,000,000 UGX',
        'image': 'assets/metal.jpeg',
        'description': 'A durable steel gate designed for security and aesthetic appeal.'
      },
      {
        'title': 'Iron Railings',
        'price': '7,000,000 UGX',
        'image': 'assets/SWIUXEXDJDK.jpg',
        'description': 'Custom iron railings for staircases or balconies.'
      },
      {
        'title': 'Metal Frame',
        'price': '6,000,000 UGX',
        'image': 'assets/interior7.jpeg',
        'description': 'Sturdy metal frame for structural support.'
      },{
        'title': 'Iron Railings',
        'price': '7,000,000 UGX',
        'image': 'assets/SWIUXEXDJDK.jpg',
        'description': 'Custom iron railings for staircases or balconies.'
      },
      {
        'title': 'Metal Frame',
        'price': '6,000,000 UGX',
        'image': 'assets/interior7.jpeg',
        'description': 'Sturdy metal frame for structural support.'
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
                    frame == null ? const Center(child: CircularProgressIndicator()) : child,
                errorBuilder: (context, error, stackTrace) {
                  if (kDebugMode) print('Failed to load image: $image, error: $error');
                  return const Center(child: Icon(Icons.error, size: 40));
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
                      'Related Works',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: relatedWorks.length,
                      itemBuilder: (context, index) {
                        final relatedWork = relatedWorks[index];
                        final String relatedImage = relatedWork['image'] ?? 'assets/metal.jpeg';
                        final String relatedTitle = relatedWork['title'] ?? 'Unknown Work';
                        final String relatedPrice = relatedWork['price'] ?? 'N/A';

                        return Semantics(
                          label: 'Related work: $relatedTitle, Price: $relatedPrice',
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MetalWorkDetailsScreen(work: relatedWork),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.grey.shade200, width: 1),
                              ),
                              elevation: 3,
                              shadowColor: Colors.black26,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                                    child: Image.asset(
                                      relatedImage,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        if (kDebugMode) print('Failed to load related image: $relatedImage, error: $error');
                                        return const SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Center(child: Icon(Icons.error, size: 30)),
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            relatedTitle,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Price: $relatedPrice',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade600,
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
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0, // Highlight Metal Works
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