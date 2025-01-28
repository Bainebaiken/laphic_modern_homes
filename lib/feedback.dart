import 'package:flutter/material.dart';
import 'package:laphic_app/compound_design.dart';
import 'package:laphic_app/construction.dart';
import 'package:laphic_app/funitures_designs.dart';
import 'package:laphic_app/gypsum_works.dart';
import 'package:laphic_app/interior_design.dart';
import 'package:laphic_app/metal_fabrication.dart';
import 'package:laphic_app/painting.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens for navigation
  final List<Widget> _pages = [
    const FeedbackInquiryScreen(),
    const ServicesPage(),
    const OngoingProjects(),
    const GypsumWorksScreen(),
    const FunitureDesignScreen(),
    const ConstructionPage(),
    const CompoundDesignPage(),
    const InteriorGalleryScreen(),
    const PaintingPage(),
    const MetalFabricationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: "Feedback",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_repair_service),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.construction),
            label: "Projects",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: "Booking",
          ),
        ],
      ),
    );
  }
}

class ProjectsPage {
  const ProjectsPage();
}

class FeedbackInquiryScreen extends StatelessWidget {
  const FeedbackInquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Map Section
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/location.JPG'), // Replace with your map image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Contact Information
              const Row(
                children: [
                  Icon(Icons.location_pin, color: Colors.red),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Kitende, Entebbe Road, Kampala, Uganda',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.phone, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    '+256 705029291',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.email, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'laphicmodernhomes@gmail.com',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Inquiry / Feedback Title
              const Text(
                'Inquiry / Feedback',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Name Field
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Comments Field
              const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Comments',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Rate Us Section
              const Text(
                'Rate us:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Row(
                children: List.generate(5, (index) {
                  return const Icon(
                    Icons.star_border,
                    color: Colors.orange,
                    size: 30,
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Submit action logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

