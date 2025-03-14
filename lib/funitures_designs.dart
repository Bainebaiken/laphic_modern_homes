import 'package:flutter/material.dart';

import 'package:laphic_app/compound_design.dart';
import 'package:laphic_app/construction.dart';
import 'package:laphic_app/feedback.dart';
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


class FunitureDesignScreen extends StatefulWidget {
  const FunitureDesignScreen({super.key});

  @override
  State<FunitureDesignScreen> createState() => _FunitureDesignScreenState();
}

class _FunitureDesignScreenState extends State<FunitureDesignScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.grey[300],
        title: const Text(
          'construction Works',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Container(
              margin: const EdgeInsets.all(10),
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/bed.jpg'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Title Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "contruction Works",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Grid of bed Designs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: gypsumDesigns.length,
                itemBuilder: (context, index) {
                  final design = gypsumDesigns[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Image Section
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.asset(
                            design['image']!,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Title and Price Section
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                design['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                design['price']!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// compound Designs Data
final List<Map<String, String>> gypsumDesigns = [
  {
    "title": "Simple & Affordable",
    "price": "500,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Grey Lights",
    "price": "400,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Humble Lights",
    "price": "500,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Brown Design",
    "price": "300,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Blue Design",
    "price": "400,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Rectangle Design",
    "price": "300,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Grey Design",
    "price": "400,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Purple Design",
    "price": "400,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Circular Lights",
    "price": "400,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Deep Lights",
    "price": "800,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Simple & Affordable",
    "price": "500,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Grey Lights",
    "price": "400,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Humble Lights",
    "price": "500,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Brown Design",
    "price": "300,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Blue Design",
    "price": "400,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Rectangle Design",
    "price": "300,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Grey Design",
    "price": "400,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Purple Design",
    "price": "400,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Circular Lights",
    "price": "400,000 UGX",
    "image": "assets/bed.jpg", 
  },
  {
    "title": "Deep Lights",
    "price": "800,000 UGX",
    "image": "assets/bed.jpg", 
  },
];













