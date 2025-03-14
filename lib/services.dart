// import 'dart:async';
// import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/compound_design.dart';
import 'package:laphic_app/construction.dart';
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
  int _selectedIndex = 0;
  late List<Widget> _pages;

  int _currentImageIndex = 0;
  Timer? _imageTimer;

  final List<String> headerImages = [
    "assets/interior7.jpeg",
    "assets/painting 1.jpg",
    "assets/interior3.jpeg",
    "assets/house5.jpeg",
    "assets/laphic2.PNG",
    "assets/SWIUXEXDJDK.jpg",
    "assets/painting2.jpeg",
  ];

  @override
  void initState() {
    super.initState();
    _pages = [
      const FeedbackInquiryScreen(),
      _buildServicesContent(),
      const OngoingProjects(),
      const BookingScreen(),
    ];

    _imageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentImageIndex = (_currentImageIndex + 1) % headerImages.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _imageTimer?.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.brightness == Brightness.dark ? const Color(0xFF001F3F) : Colors.white;

    return Scaffold(
      
      body: Container(
        color: backgroundColor,
        child: _pages[_selectedIndex],
      ),
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

  Widget _buildServicesContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Image.asset(
                  headerImages[_currentImageIndex],
                  key: ValueKey<String>(headerImages[_currentImageIndex]),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
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

  final List<Map<String, dynamic>> services = [
    {
      "title": "Compound Design",
      "image": "assets/compound 1.jpg",
      "page": const CompoundDesignPage(),
    },
    {
      "title": "Construction",
      "image": "assets/SWIUXEXDJDK.jpg",
      "page": const ConstructionPage(),
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

// class ServicesPage extends StatefulWidget {
//   const ServicesPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ServicesPageState createState() => _ServicesPageState();
// }

// class _ServicesPageState extends State<ServicesPage> {
//   int _selectedIndex = 1;
//   late List<Widget> _pages;
//   final List<String> _pageTitles = ["Feedback", "Services", "Projects", "Booking"];

//   int _currentImageIndex = 0;
//   Timer? _imageTimer; // Use nullable Timer to avoid issues

//   final List<String> headerImages = [
//     "assets/interior7.jpeg",
//     "assets/painting 1.jpg",
//     "assets/interior3.jpeg",
//     "assets/house5.jpeg",
//     "assets/laphic2.PNG",
//     "assets/SWIUXEXDJDK.jpg",
//     "assets/painting2.jpeg",
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       const FeedbackInquiryScreen(),
//       _buildServicesContent(),
//       const OngoingProjects(),
//       const BookingScreen(),
//     ];

//     // Start a timer to change images every second
//     _imageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (mounted) { // Prevent calling setState on a disposed widget
//         setState(() {
//           _currentImageIndex = (_currentImageIndex + 1) % headerImages.length;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _imageTimer?.cancel(); // Stop the timer
//     super.dispose();
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_pageTitles[_selectedIndex]),
//         centerTitle: true,
//       ),
//       body: _pages[_selectedIndex],
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

//   Widget _buildServicesContent() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           // Header with Image Slider
//           Stack(
//             children: [
//               AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 500),
//                 child: Image.asset(
//                   headerImages[_currentImageIndex],
//                   key: ValueKey<String>(headerImages[_currentImageIndex]),
//                   height: 200,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 color: Colors.black.withOpacity(0.4),
//               ),
//               const Positioned(
//                 bottom: 20,
//                 left: 20,
//                 child: Text(
//                   'Services',
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 213, 214, 219),
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Services Grid
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 3 / 2.5,
//               ),
//               itemCount: services.length,
//               itemBuilder: (context, index) {
//                 final service = services[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => service['page']!,
//                       ),
//                     );
//                   },
//                   child: Card(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 5,
//                     child: Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.asset(
//                             service['image']!,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             height: double.infinity,
//                           ),
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.4),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         Center(
//                           child: Text(
//                             service['title']!,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   final List<Map<String, dynamic>> services = [
//     {
//       "title": "Compound Design",
//       "image": "assets/compound 1.jpg",
//       "page": const CompoundDesignPage(),
//     },
//     {
//       "title": "Construction",
//       "image": "assets/SWIUXEXDJDK.jpg",
//       "page": const ConstructionPage(),
//     },
//     {
//       "title": "Painting",
//       "image": "assets/painting2.jpeg",
//       "page": const PaintingPage(),
//     },
//     {
//       "title": "Interior Design",
//       "image": "assets/design.jpeg",
//       "page": const InteriorGalleryScreen(),
//     },
//     {
//       "title": "Metal Fabrication",
//       "image": "assets/metal.jpeg",
//       "page": const MetalFabricationPage(),
//     },
//     {
//       "title": "Gypsum Works",
//       "image": "assets/gypsum6.webp",
//       "page": const GypsumWorksScreen(),
//     },
//     {
//       "title": "Furniture Works",
//       "image": "assets/gypsum6.webp",
//       "page": const FunitureDesignScreen(),
//     },
//   ];
// }
















