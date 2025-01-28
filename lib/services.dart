import 'package:flutter/material.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/funitures_designs.dart';
import 'package:laphic_app/gypsum_works.dart';
import 'package:laphic_app/interior_design.dart';
import 'package:laphic_app/metal_fabrication.dart';
import 'package:laphic_app/painting.dart';
import 'package:laphic_app/projects_designn.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  int _selectedIndex = 1; // Default to "Services" page

  // List of pages for the BottomNavigationBar
  late List<Widget> _pages;

  final List<String> _pageTitles = ["Feedback", "Services", "Projects", "Booking"];

  @override
  void initState() {
    super.initState();
    // Initialize _pages in initState to allow calling instance methods
    _pages = [
      const FeedbackInquiryScreen(),
      _buildServicesContent(), // Correctly use the instance method here
      const OngoingProjects(),
      const BookingScreen(),
    ];
  }

  // Function to handle navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex], // Display the selected page
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

  // Function to build the services content
  Widget _buildServicesContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Section
          Stack(
            children: [
              Image.asset(
                "assets/laphic2.PNG",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.black.withOpacity(0.4),
              ),
              const Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  'Services',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // Services Grid
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 2.5,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => service['page']!,
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            service['image']!,
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
                          child: Text(
                            service['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Services Data
  final List<Map<String, dynamic>> services = [
    {
      "title": "Compound Design",
      "image": "assets/compound 1.jpg",
      "page": const FeedbackInquiryScreen(), // Replace with actual pages
    },
    {
      "title": "Construction",
      "image": "assets/SWIUXEXDJDK.jpg",
      "page": const OngoingProjects(),
    },
    {
      "title": "Painting",
      "image": "assets/painting2.jpeg",
      "page": const PaintingPage(),
    },
    {
      "title": "Interior Design",
      "image": "assets/design.jpeg",
      "page": const InteriorGalleryScreen(),
    },
    {
      "title": "Metal Fabrication",
      "image": "assets/metal.jpeg",
      "page": const MetalFabricationPage(),
    },
    {
      "title": "Gypsum Works",
      "image": "assets/gypsum6.webp",
      "page": const GypsumWorksScreen(),
    },
    {
      "title": "Furniture Works",
      "image": "assets/gypsum6.webp",
      "page": const FunitureDesignScreen(),
    },
  ];
}











// import 'package:flutter/material.dart';
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




// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;

//   // List of labels for the pages
//   final List<String> _pageTitles = ["Feedback", "Services", "Projects", "Booking"];

//   // Function to handle navigation
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     // Custom navigation logic
//     switch (index) {
//       case 0:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const FeedbackInquiryScreen()),
//         );
//         break;
//       case 1:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const ServicesPage()),
//         );
//         break;
//       case 2:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const OngoingProjects()),
//         );
//         break;
//       case 3:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const BookingScreen()),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_pageTitles[_selectedIndex]),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text(
//           "Selected Page: ${_pageTitles[_selectedIndex]}",
//           style: const TextStyle(fontSize: 24),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.feedback),
//             label: "Feedback",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_repair_service),
//             label: "Services",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.construction),
//             label: "Projects",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book_online),
//             label: "Booking",
//           ),
//         ],
//       ),
//     );
//   }
// }
// class ServicesPage extends StatelessWidget {
//   const ServicesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
     
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Header Section
//             Stack(
//               children: [
//                 Image.asset(
//                   "assets/laphic2.PNG", 
//                   height: 200,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//                 Container(
//                   height: 200,
//                   width: double.infinity,
//                   color: Colors.black.withOpacity(0.4),
//                 ),
//                 const Positioned(
//                   bottom: 20,
//                   left: 20,
//                   child: Text(
//                     'Services',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Services Grid
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 3 / 2.5,
//                 ),
//                 itemCount: services.length,
//                 itemBuilder: (context, index) {
//                   final service = services[index];
//                   return GestureDetector(
//                     onTap: () {
//                       // Navigate to the respective service page
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => service['page']!,
//                         ),
//                       );
//                     },
//                     child: Card(
//                       color: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       elevation: 5,
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.asset(
//                               service['image']!,
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                               height: double.infinity,
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.4),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           Center(
//                             child: Text(
//                               service['title']!,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ],
//                       ),
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
// }

// // Service Pages




// // Add similar pages for other services...

// // Services Data
// final List<Map<String, dynamic>> services = [
//   {
//     "title": "Compound Design",
//     "image": "assets/compound 1.jpg", 
//     "page": const CompoundDesignPage(),
//   },
//   {
//     "title": "Construction",
//     "image": "assets/SWIUXEXDJDK.jpg", 
//     "page": const ConstructionPage(),
//   },
//   {
//     "title": "Painting",
//     "image": "assets/painting2.jpeg", 
//     "page": const PaintingPage(),
//   },
//   {
//     "title": "Interior Design",
//     "image": "assets/design.jpeg", 
//     "page": const InteriorGalleryScreen(),
//   },
//   {
//     "title": "Metal Fabrication",
//     "image": "assets/metal.jpeg", 
//     "page": const MetalFabricationPage(),
//   },
//   {
//     "title": "Gypsum Works",
//     "image": "assets/gypsum6.webp", 
//     "page": const GypsumWorksScreen(),
//   },
//    {
//     "title": "funiture Works",
//     "image": "assets/gypsum6.webp", 
//     "page": const FunitureDesignScreen(),
//   },
// ];









