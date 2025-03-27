// import 'package:flutter/material.dart';



// class OngoingProjects extends StatelessWidget {
//   const OngoingProjects({super.key});

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
//                   'assets/SWIUXEXDJDK.jpg', // Replace with your header image path
//                   height: 200,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//                 Container(
//                   height: 200,
//                   color: Colors.black.withOpacity(0.5),
//                 ),
//                 const Positioned(
//                   bottom: 20,
//                   left: 20,
//                   child: Text(
//                     'ON GOING PROJECTS',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),

//             // Grid Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: GridView.builder(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 3 / 4,
//                 ),
//                 itemCount: ongoingProjects.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.vertical(
//                               top: Radius.circular(10),
//                             ),
//                             child: Image.asset(
//                               ongoingProjects[index]['image']!,
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             ongoingProjects[index]['location']!,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black54,
//                             ),
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

// // Data for ongoing projects
// final List<Map<String, String>> ongoingProjects = [
//   {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Congo'},
//   {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Lweza Plot No 77'},
//   {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Kitende Plot No 890'},
//   {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Jinja Plot No 44'},
//   {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Location: Nalumunye Bandwe'},
//   {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Congo'},
// ];



import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode; // For debug logging
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide CarouselController;

class OngoingProjects extends StatefulWidget {
  const OngoingProjects({Key? key}) : super(key: key); // Updated from super.key

  @override
  // ignore: library_private_types_in_public_api
  _OngoingProjectsState createState() => _OngoingProjectsState();
}

class _OngoingProjectsState extends State<OngoingProjects> {
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();

  final List<String> carouselImages = [
    'assets/SWIUXEXDJDK.jpg',
    'assets/interior7.jpeg',
    'assets/painting 1.jpg',
    'assets/house5.jpeg', // Add more images from your assets
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel Section
            _buildCarousel(),
            const SizedBox(height: 20),
            // Grid Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: ongoingProjects.length,
                itemBuilder: (context, index) {
                  final String image = ongoingProjects[index]['image'] ?? 'assets/SWIUXEXDJDK.jpg';
                  final String location = ongoingProjects[index]['location'] ?? 'Unknown Location';

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                if (kDebugMode) print('Failed to load image: $image, error: $error');
                                return const Center(child: Icon(Icons.error));
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            location,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
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
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemCount: carouselImages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.asset(
                    carouselImages[index],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      if (kDebugMode) print('Carousel image failed: ${carouselImages[index]}, error: $error');
                      return const Center(child: Icon(Icons.error));
                    },
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              );
            },
          ),
        ),
        const Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            'ON GOING PROJECTS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
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

// Data for ongoing projects
final List<Map<String, String>> ongoingProjects = [
  {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Congo'},
  {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Lweza Plot No 77'},
  {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Kitende Plot No 890'},
  {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Jinja Plot No 44'},
  {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Location: Nalumunye Bandwe'},
  {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Congo'},
];