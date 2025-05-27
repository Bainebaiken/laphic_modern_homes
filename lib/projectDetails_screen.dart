import 'package:flutter/material.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/livechat.dart';
import 'package:laphic_app/profile_screen.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final Map<String, String> project;

  const ProjectDetailsScreen({Key? key, required this.project}) : super(key: key);

  void _onNavTap(BuildContext context, int index) {
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
    final String image = project['image'] ?? 'assets/placeholder.jpg';
    final String name = project['name'] ?? 'Unnamed Project';
    final String location = project['location'] ?? 'Unknown Location';
    final String progress = project['progress'] ?? '0';
    final String description = project['description'] ?? 'No description available.';

    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.grey.shade100,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                image,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover, // Fixed from BoxFit.coverWidth
                frameBuilder: (context, child, frame, _) =>
                    frame == null ? const Center(child: CircularProgressIndicator()) : child,
                errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error, size: 50)),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      location,
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 8),
                    if (progress != '0')
                      Row(
                        children: [
                          const Text(
                            'Progress: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          Text(
                            '$progress%',
                            style: const TextStyle(fontSize: 16, color: Colors.orange),
                          ),
                        ],
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
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 4, // Highlight Projects
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