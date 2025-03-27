// import 'package:flutter/material.dart';



// class MetalFabricationPage extends StatelessWidget {
//   const MetalFabricationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Colors.grey[300],
//         title: const Text(
//           'Interior Gallery',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Image
//             Container(
//               margin: const EdgeInsets.all(10),
//               height: 180,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: const DecorationImage(
//                   image: AssetImage('assets/metal.jpeg'), 
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             // Title Section
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: Text(
//                 "Interior Designs",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),

//             // Grid of Designs
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 3 / 4,
//                 ),
//                 itemCount: designs.length,
//                 itemBuilder: (context, index) {
//                   final design = designs[index];
//                   return Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 4,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         // Image Section
//                         ClipRRect(
//                           borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(10),
//                           ),
//                           child: Image.asset(
//                             design['image']!,
//                             height: 120,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         // Title and Price Section
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 design['title']!,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 design['price']!,
//                                 style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
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

// // Interior Design Data
// final List<Map<String, String>> designs = [
//   {
//     "title": "Affordable",
//     "price": "8,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Affordable",
//     "price": "7,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Shining Theme",
//     "price": "6,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Golden Theme",
//     "price": "9,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Black Theme",
//     "price": "3,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Interior Design",
//     "price": "6,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Simple Grey Theme",
//     "price": "3,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Simple Theme",
//     "price": "2,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Humble Theme",
//     "price": "9,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Gold Design",
//     "price": "12,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Affordable",
//     "price": "8,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Affordable",
//     "price": "7,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Shining Theme",
//     "price": "6,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Golden Theme",
//     "price": "9,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Black Theme",
//     "price": "3,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Interior Design",
//     "price": "6,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Simple Grey Theme",
//     "price": "3,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Simple Theme",
//     "price": "2,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Humble Theme",
//     "price": "9,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
//   {
//     "title": "Gold Design",
//     "price": "12,000,000 UGX",
//     "image": "assets/metal.jpeg", 
//   },
// ];




import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode; // For debug logging
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide CarouselController;

class MetalFabricationPage extends StatefulWidget {
  const MetalFabricationPage({Key? key}) : super(key: key); // Updated from super.key

  @override
  // ignore: library_private_types_in_public_api
  _MetalFabricationPageState createState() => _MetalFabricationPageState();
}

class _MetalFabricationPageState extends State<MetalFabricationPage> {
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();

  final List<String> carouselImages = [
    'assets/metal.jpeg',
    'assets/SWIUXEXDJDK.jpg', // Add more metal-related images from your assets
    'assets/interior7.jpeg',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
          if (mounted && _pageController.hasClients) {
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
    });
  }

  @override
  void dispose() {
    _imageTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Metal Fabrication',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Section
            _buildCarousel(),
            // Title Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "Metal Fabrication Works",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Grid of Metal Fabrication Designs
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
                itemCount: metalWorks.length,
                itemBuilder: (context, index) {
                  final work = metalWorks[index];
                  final String image = work['image'] ?? 'assets/metal.jpeg';
                  final String title = work['title'] ?? 'Unknown Work';
                  final String price = work['price'] ?? 'N/A';

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.asset(
                            image,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              if (kDebugMode) print('Failed to load image: $image, error: $error');
                              return const Center(child: Icon(Icons.error));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                price,
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
    );
  }

  Widget _buildCarousel() {
    return Stack(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemCount: carouselImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(carouselImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 20,
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
                  color: _currentImageIndex == index
                      ? Colors.orange
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Metal Fabrication Works Data
final List<Map<String, String>> metalWorks = [
  {"title": "Steel Gate", "price": "8,000,000 UGX", "image": "assets/metal.jpeg"},
  {"title": "Iron Railings", "price": "7,000,000 UGX", "image": "assets/metal.jpeg"},
  {"title": "Metal Frame", "price": "6,000,000 UGX", "image": "assets/metal.jpeg"},
  {"title": "Custom Grill", "price": "9,000,000 UGX", "image": "assets/metal.jpeg"},
  {"title": "Steel Stairs", "price": "3,000,000 UGX", "image": "assets/metal.jpeg"},
  {"title": "Metal Shelf", "price": "6,000,000 UGX", "image": "assets/metal.jpeg"},
  {"title": "Wrought Iron", "price": "3,000,000 UGX", "image": "assets/metal.jpeg"},
  {"title": "Basic Frame", "price": "2,000,000 UGX", "image": "assets/metal.jpeg"},
  {"title": "Ornate Gate", "price": "9,000,000 UGX", "image": "assets/metal.jpeg"},
  {"title": "Heavy Duty", "price": "12,000,000 UGX", "image": "assets/metal.jpeg"},
];