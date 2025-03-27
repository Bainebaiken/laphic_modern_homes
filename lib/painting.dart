// import 'package:flutter/material.dart';





// class PaintingPage extends StatefulWidget {
//   const PaintingPage({super.key});

//   @override
//   State<PaintingPage> createState() => _PaintingPageState();
// }

// class _PaintingPageState extends State<PaintingPage> {


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Colors.grey[300],
//         title: const Text(
//           'painting ',
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
//                   image: AssetImage('assets/painting 1.jpg'), // Replace with your image path
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             // Title Section
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: Text(
//                 "painting ",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),

//             // Grid of Gypsum Designs
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
//                 itemCount: gypsumDesigns.length,
//                 itemBuilder: (context, index) {
//                   final design = gypsumDesigns[index];
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

// // Gypsum Designs Data
// final List<Map<String, String>> gypsumDesigns = [
//   {
//     "title": "Simple & Affordable",
//     "price": "500,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Grey Lights",
//     "price": "400,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Humble Lights",
//     "price": "500,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Brown Design",
//     "price": "300,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Blue Design",
//     "price": "400,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Rectangle Design",
//     "price": "300,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Grey Design",
//     "price": "400,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Purple Design",
//     "price": "400,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Circular Lights",
//     "price": "400,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Deep Lights",
//     "price": "800,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//    {
//     "title": "Simple & Affordable",
//     "price": "500,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Grey Lights",
//     "price": "400,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Humble Lights",
//     "price": "500,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Brown Design",
//     "price": "300,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Blue Design",
//     "price": "400,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Rectangle Design",
//     "price": "300,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Grey Design",
//     "price": "400,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Purple Design",
//     "price": "400,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Circular Lights",
//     "price": "400,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
//   {
//     "title": "Deep Lights",
//     "price": "800,000 UGX",
//     "image": "assets/painting 1.jpg", // Replace with your image path
//   },
// ];









import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode; // For debug logging
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide CarouselController;

class PaintingPage extends StatefulWidget {
  const PaintingPage({Key? key}) : super(key: key); // Updated from super.key

  @override
  // ignore: library_private_types_in_public_api
  _PaintingPageState createState() => _PaintingPageState();
}

class _PaintingPageState extends State<PaintingPage> {
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();

  final List<String> carouselImages = [
    'assets/painting 1.jpg',
    'assets/painting2.jpeg',
    'assets/interior7.jpeg', // Add more painting-related images from your assets
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
          'Painting',
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
                "Painting Designs",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Grid of Painting Designs
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
                itemCount: paintingDesigns.length,
                itemBuilder: (context, index) {
                  final design = paintingDesigns[index];
                  final String image = design['image'] ?? 'assets/painting 1.jpg';
                  final String title = design['title'] ?? 'Unknown Design';
                  final String price = design['price'] ?? 'N/A';

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

// Painting Designs Data
final List<Map<String, String>> paintingDesigns = [
  {"title": "Simple & Affordable", "price": "500,000 UGX", "image": "assets/painting 1.jpg"},
  {"title": "Grey Lights", "price": "400,000 UGX", "image": "assets/painting 1.jpg"},
  {"title": "Humble Lights", "price": "500,000 UGX", "image": "assets/painting 1.jpg"},
  {"title": "Brown Design", "price": "300,000 UGX", "image": "assets/painting 1.jpg"},
  {"title": "Blue Design", "price": "400,000 UGX", "image": "assets/painting 1.jpg"},
  {"title": "Rectangle Design", "price": "300,000 UGX", "image": "assets/painting 1.jpg"},
  {"title": "Grey Design", "price": "400,000 UGX", "image": "assets/painting 1.jpg"},
  {"title": "Purple Design", "price": "400,000 UGX", "image": "assets/painting 1.jpg"},
  {"title": "Circular Lights", "price": "400,000 UGX", "image": "assets/painting 1.jpg"},
  {"title": "Deep Lights", "price": "800,000 UGX", "image": "assets/painting 1.jpg"},
  // Removed duplicates for brevity; add varied images if available
];



