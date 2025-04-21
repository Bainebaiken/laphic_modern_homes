// // import 'package:flutter/material.dart';







// // class InteriorGalleryScreen extends StatelessWidget {
// //   const InteriorGalleryScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
      
// //       body: SingleChildScrollView(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Header Image
// //             Container(
// //               margin: const EdgeInsets.all(10),
// //               height: 180,
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(10),
// //                 image: const DecorationImage(
// //                   image: AssetImage('assets/interior3.jpeg'), 
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //             ),

// //             // Title Section
// //             const Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// //               child: Text(
// //                 "Interior Designs",
// //                 style: TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),

// //             // Grid of Designs
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 16),
// //               child: GridView.builder(
// //                 shrinkWrap: true,
// //                 physics: const NeverScrollableScrollPhysics(),
// //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                   crossAxisCount: 2,
// //                   crossAxisSpacing: 10,
// //                   mainAxisSpacing: 10,
// //                   childAspectRatio: 3 / 4,
// //                 ),
// //                 itemCount: designs.length,
// //                 itemBuilder: (context, index) {
// //                   final design = designs[index];
// //                   return Card(
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     elevation: 4,
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.stretch,
// //                       children: [
// //                         // Image Section
// //                         ClipRRect(
// //                           borderRadius: const BorderRadius.vertical(
// //                             top: Radius.circular(10),
// //                           ),
// //                           child: Image.asset(
// //                             design['image']!,
// //                             height: 120,
// //                             fit: BoxFit.cover,
// //                           ),
// //                         ),
// //                         // Title and Price Section
// //                         Padding(
// //                           padding: const EdgeInsets.all(8.0),
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text(
// //                                 design['title']!,
// //                                 style: const TextStyle(
// //                                   fontWeight: FontWeight.bold,
// //                                   fontSize: 16,
// //                                 ),
// //                               ),
// //                               const SizedBox(height: 4),
// //                               Text(
// //                                 design['price']!,
// //                                 style: const TextStyle(
// //                                   color: Colors.grey,
// //                                   fontSize: 14,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // Interior Design Data
// // final List<Map<String, String>> designs = [
// //   {
// //     "title": "Affordable",
// //     "price": "8,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Affordable",
// //     "price": "7,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Shining Theme",
// //     "price": "6,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Golden Theme",
// //     "price": "9,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Black Theme",
// //     "price": "3,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Interior Design",
// //     "price": "6,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Simple Grey Theme",
// //     "price": "3,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Simple Theme",
// //     "price": "2,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Humble Theme",
// //     "price": "9,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Gold Design",
// //     "price": "12,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Affordable",
// //     "price": "8,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Affordable",
// //     "price": "7,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Shining Theme",
// //     "price": "6,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Golden Theme",
// //     "price": "9,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Black Theme",
// //     "price": "3,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Interior Design",
// //     "price": "6,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Simple Grey Theme",
// //     "price": "3,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Simple Theme",
// //     "price": "2,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Humble Theme",
// //     "price": "9,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// //   {
// //     "title": "Gold Design",
// //     "price": "12,000,000 UGX",
// //     "image": "assets/interior3.jpeg", 
// //   },
// // ];


// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class InteriorGalleryScreen extends StatelessWidget {
//   const InteriorGalleryScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Carousel Section
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: CarouselSlider(
//                 options: CarouselOptions(
//                   height: 180,
//                   autoPlay: true,
//                   autoPlayInterval: const Duration(seconds: 3),
//                   enlargeCenterPage: true,
//                   viewportFraction: 0.9,
//                   aspectRatio: 16 / 9,
//                 ),
//                 items: carouselImages.map((item) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           image: DecorationImage(
//                             image: NetworkImage(item['image']!),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         child: Stack(
//                           children: [
//                             Positioned(
//                               bottom: 10,
//                               left: 10,
//                               child: Text(
//                                 item['title']!,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   shadows: [
//                                     Shadow(
//                                       blurRadius: 5.0,
//                                       color: Colors.black,
//                                       offset: Offset(2.0, 2.0),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 }).toList(),
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

// // Carousel Data with Dummy URLs
// final List<Map<String, String>> carouselImages = [
//   {
//     "title": "Modern Living",
//     "image": "assets/gypsum6.webp",
//   },
//   {
//     "title": "Cozy Bedroom",
//     "image": "assets/kit.jpg",
//   },
//   {
//     "title": "Luxury Kitchen",
//     "image": "assets/gypsum6.webp",
//   },
//   {
//     "title": "Minimalist Office",
//     "image": "assets/interior7.jpeg",
//   },
//   {
    
//     "image": "assets/interior3.jpeg",
//   },
// ];

// // Interior Design Data for Grid (using local asset for now)
// final List<Map<String, String>> designs = [
//   {
//     "title": "Affordable",
//     "price": "8,000,000 UGX",
//     "image": "assets/interior3.jpeg",
//   },
//   {
//     "title": "Shining Theme",
//     "price": "6,000,000 UGX",
//     "image": "assets/interior3.jpeg",
//   },
//   {
//     "title": "Golden Theme",
//     "price": "9,000,000 UGX",
//     "image": "assets/interior3.jpeg",
//   },
//   {
//     "title": "Black Theme",
//     "price": "3,000,000 UGX",
//     "image": "assets/interior3.jpeg",
//   },
//   {
//     "title": "Simple Grey Theme",
//     "price": "3,000,000 UGX",
//     "image": "assets/interior3.jpeg",
//   },
//   {
//     "title": "Humble Theme",
//     "price": "9,000,000 UGX",
//     "image": "assets/interior3.jpeg",
//   },
//   {
//     "title": "Gold Design",
//     "price": "12,000,000 UGX",
//     "image": "assets/interior3.jpeg",
//   },
// ];

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

class InteriorGalleryScreen extends StatelessWidget {
  const InteriorGalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interior Gallery'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Static Header Image
            Container(
              margin: const EdgeInsets.all(10),
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/interior3.jpeg'), // Default image, adjust as needed
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Title Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "Interior Designs",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Grid of Interior Designs
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
                itemCount: designs.length,
                itemBuilder: (context, index) {
                  final design = designs[index];
                  final String image = design['image'] ?? 'assets/interior3.jpeg';
                  final String title = design['title'] ?? 'Untitled Design';
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
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
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
}

final List<Map<String, String>> designs = [
  {"title": "Affordable", "price": "8,000,000 UGX", "image": "assets/interior3.jpeg"},
  {"title": "Shining Theme", "price": "6,000,000 UGX", "image": "assets/interior3.jpeg"},
  {"title": "Golden Theme", "price": "9,000,000 UGX", "image": "assets/interior3.jpeg"},
  {"title": "Black Theme", "price": "3,000,000 UGX", "image": "assets/interior3.jpeg"},
  {"title": "Simple Grey Theme", "price": "3,000,000 UGX", "image": "assets/interior3.jpeg"},
  {"title": "Humble Theme", "price": "9,000,000 UGX", "image": "assets/interior3.jpeg"},
  {"title": "Gold Design", "price": "12,000,000 UGX", "image": "assets/interior3.jpeg"},
];

// Removed carouselImages since it's no longer needed