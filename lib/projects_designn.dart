


// import 'dart:async';
// import 'package:flutter/foundation.dart' show kDebugMode;
// import 'package:flutter/material.dart';

// class OngoingProjects extends StatefulWidget {
//   const OngoingProjects({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _OngoingProjectsState createState() => _OngoingProjectsState();
// }

// class _OngoingProjectsState extends State<OngoingProjects> {
//   int _currentImageIndex = 0;
//   Timer? _imageTimer;
//   final PageController _pageController = PageController();

//   final List<String> carouselImages = [
//     'assets/SWIUXEXDJDK.jpg',
//     'assets/interior7.jpeg',
//     'assets/painting 1.jpg',
//     'assets/house5.jpeg',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
//           if (mounted && _pageController.hasClients) {
//             setState(() {
//               _currentImageIndex = (_currentImageIndex + 1) % carouselImages.length;
//               _pageController.animateToPage(
//                 _currentImageIndex,
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//               if (kDebugMode) {
//                 print('Carousel moved to index: $_currentImageIndex');
//               }
//             });
//           }
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _imageTimer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildCarousel(),
//             const SizedBox(height: 20),
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
//                   final String image = ongoingProjects[index]['image'] ?? 'assets/SWIUXEXDJDK.jpg';
//                   final String location = ongoingProjects[index]['location'] ?? 'Unknown Location';

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
//                               image,
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                               errorBuilder: (context, error, stackTrace) {
//                                 if (kDebugMode) print('Failed to load image: $image, error: $error');
//                                 return const Center(child: Icon(Icons.error));
//                               },
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             location,
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

//   Widget _buildCarousel() {
//     return Stack(
//       children: [
//         SizedBox(
//           height: 200,
//           child: PageView.builder(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentImageIndex = index;
//               });
//             },
//             itemCount: carouselImages.length,
//             itemBuilder: (context, index) {
//               return Stack(
//                 children: [
//                   Image.asset(
//                     carouselImages[index],
//                     height: 200,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       if (kDebugMode) print('Carousel image failed: ${carouselImages[index]}, error: $error');
//                       return const Center(child: Icon(Icons.error));
//                     },
//                   ),
//                   Container(
//                     height: 200,
//                     width: double.infinity,
//                     color: Colors.black.withOpacity(0.5),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//         const Positioned(
//           bottom: 20,
//           left: 20,
//           child: Text(
//             'ON GOING PROJECTS',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 10,
//           left: 0,
//           right: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               carouselImages.length,
//               (index) => Container(
//                 width: 8,
//                 height: 8,
//                 margin: const EdgeInsets.symmetric(horizontal: 4),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _currentImageIndex == index
//                       ? Colors.orange
//                       : Colors.white.withOpacity(0.5),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// final List<Map<String, String>> ongoingProjects = [
//   {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Congo'},
//   {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Lweza Plot No 77'},
//   {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Kitende Plot No 890'},
//   {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Jinja Plot No 44'},
//   {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Location: Nalumunye Bandwe'},
//   {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Congo'},
// ];


import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/livechat.dart';
import 'package:laphic_app/profile_screen.dart';
import 'package:laphic_app/projectDetails_screen.dart';
import 'package:laphic_app/services.dart';
import 'package:laphic_app/project_data.dart';

class OngoingProjects extends StatefulWidget {
  const OngoingProjects({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OngoingProjectsState createState() => _OngoingProjectsState();
}

class _OngoingProjectsState extends State<OngoingProjects> {
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();
  int _navIndex = 4; // Projects is index 4

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        for (var image in carouselImages) {
          precacheImage(AssetImage(image), context);
        }
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted && _pageController.hasClients && carouselImages.isNotEmpty) {
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

  @override
  void dispose() {
    _imageTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == _navIndex) return; // No action if already on Projects
    setState(() {
      _navIndex = index;
    });
    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const ServicesHomePage();
        break;
      case 1:
        nextScreen = const BookingScreen();
        break;
      case 2:
        nextScreen = const ProfilePage();
        break;
      case 3:
        nextScreen = const ChatPage();
        break;
      case 4:
        nextScreen = const OngoingProjects();
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
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.grey.shade100,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCarousel(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Text(
                  'Ongoing Projects',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
              _buildProjectGrid(ongoingProjects),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Text(
                  'Completed Projects',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
              _buildProjectGrid(completedProjects),
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _navIndex,
          onTap: _onNavTap,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey.shade600,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Services'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Booking'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'),
            BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    if (carouselImages.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No carousel images available', style: TextStyle(color: Colors.grey))),
      );
    }
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
              _imageTimer?.cancel();
              _imageTimer = Timer(const Duration(seconds: 5), () => _startTimer());
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
                    frameBuilder: (context, child, frame, _) =>
                        frame == null ? const Center(child: CircularProgressIndicator()) : child,
                    errorBuilder: (context, error, stackTrace) {
                      if (kDebugMode) print('Carousel image failed: ${carouselImages[index]}, error: $error');
                      return const Center(child: Icon(Icons.error));
                    },
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                      ),
                    ),
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
            'ONGOING PROJECTS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 2, color: Colors.black54, offset: Offset(1, 1))],
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
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageIndex == index ? Colors.orangeAccent : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 80,
          child: IconButton(
            icon: const Icon(Icons.arrow_left, color: Colors.white, size: 30),
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
        Positioned(
          right: 10,
          top: 80,
          child: IconButton(
            icon: const Icon(Icons.arrow_right, color: Colors.white, size: 30),
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProjectGrid(List<Map<String, String>> projects) {
    if (projects.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No projects available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2 / 3,
        ),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final String image = projects[index]['image'] ?? 'assets/placeholder.jpg';
          final String location = projects[index]['location'] ?? 'Unknown Location';
          final String name = projects[index]['name'] ?? 'Unnamed Project';
          final String progress = projects[index]['progress'] ?? '0';

          return Semantics(
            label: 'Project: $name at $location',
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectDetailsScreen(project: projects[index]),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
                elevation: 0,
                shadowColor: Colors.black26,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              frameBuilder: (context, child, frame, _) =>
                                  frame == null ? const Center(child: CircularProgressIndicator()) : child,
                              errorBuilder: (context, error, stackTrace) {
                                if (kDebugMode) print('Failed to load image: $image, error: $error');
                                return const Center(child: Icon(Icons.error));
                              },
                            ),
                          ),
                          if (progress != '0')
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '$progress%',
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            location,
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}