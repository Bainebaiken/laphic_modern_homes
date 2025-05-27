// import 'dart:async';
// import 'package:flutter/foundation.dart' show kDebugMode;
// import 'package:flutter/material.dart';
// import 'package:laphic_app/booking.dart';
// import 'package:laphic_app/feedback.dart';
// import 'package:laphic_app/livechat.dart';
// import 'package:laphic_app/profile_screen.dart';
// import 'package:laphic_app/projectDetails_screen.dart';
// import 'package:laphic_app/services.dart';
// import 'package:laphic_app/project_data.dart';

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
//   int _navIndex = 4; // Projects is index 4

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         for (var image in carouselImages) {
//           precacheImage(AssetImage(image), context);
//         }
//         _startTimer();
//       }
//     });
//   }

//   void _startTimer() {
//     _imageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (mounted && _pageController.hasClients && carouselImages.isNotEmpty) {
//         setState(() {
//           _currentImageIndex = (_currentImageIndex + 1) % carouselImages.length;
//           _pageController.animateToPage(
//             _currentImageIndex,
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.easeInOut,
//           );
//           if (kDebugMode) {
//             print('Carousel moved to index: $_currentImageIndex');
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

//   void _onNavTap(int index) {
//     if (index == _navIndex) return; // No action if already on Projects
//     setState(() {
//       _navIndex = index;
//     });
//     Widget nextScreen;
//     switch (index) {
//       case 0:
//          nextScreen = const ProfilePage();
//         break;
//       case 1:
        
//         nextScreen = const ServicesHomePage();
//         break;
//       case 2:
//         nextScreen = const OngoingProjects();
       
//         break;
//       case 3:
//         nextScreen = const ChatPage();
//         break;
//       case 4:
//         nextScreen = const BookingScreen(initialDesign: '', initialServiceType: '',);
//         break;
//       case 5:
//         nextScreen = const FeedbackInquiryScreen();
//         break;
//       default:
//         return;
//     }
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => nextScreen),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         primaryColor: Colors.orange,
//         scaffoldBackgroundColor: Colors.grey.shade100,
//         textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
//       ),
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildCarousel(),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//                 child: Text(
//                   'Ongoing Projects',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
//                 ),
//               ),
//               _buildProjectGrid(ongoingProjects),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//                 child: Text(
//                   'Completed Projects',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
//                 ),
//               ),
//               _buildProjectGrid(completedProjects),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _navIndex,
//           onTap: _onNavTap,
//           selectedItemColor: Colors.orange,
//           unselectedItemColor: Colors.grey.shade600,
//           backgroundColor: Colors.white,
//           type: BottomNavigationBarType.fixed,
//          items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Services'),
//           BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Projects'),
//           BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
//           BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
//           BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
//          ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCarousel() {
//     if (carouselImages.isEmpty) {
//       return const SizedBox(
//         height: 200,
//         child: Center(child: Text('No carousel images available', style: TextStyle(color: Colors.grey))),
//       );
//     }
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
//               _imageTimer?.cancel();
//               _imageTimer = Timer(const Duration(seconds: 5), () => _startTimer());
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
//                     frameBuilder: (context, child, frame, _) =>
//                         frame == null ? const Center(child: CircularProgressIndicator()) : child,
//                     errorBuilder: (context, error, stackTrace) {
//                       if (kDebugMode) print('Carousel image failed: ${carouselImages[index]}, error: $error');
//                       return const Center(child: Icon(Icons.error));
//                     },
//                   ),
//                   Container(
//                     height: 200,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
//                       ),
//                     ),
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
//             'ONGOING PROJECTS',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               shadows: [Shadow(blurRadius: 2, color: Colors.black54, offset: Offset(1, 1))],
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
//                 width: 10,
//                 height: 10,
//                 margin: const EdgeInsets.symmetric(horizontal: 4),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _currentImageIndex == index ? Colors.orangeAccent : Colors.white.withOpacity(0.5),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           left: 10,
//           top: 80,
//           child: IconButton(
//             icon: const Icon(Icons.arrow_left, color: Colors.white, size: 30),
//             onPressed: () {
//               _pageController.previousPage(
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//             },
//           ),
//         ),
//         Positioned(
//           right: 10,
//           top: 80,
//           child: IconButton(
//             icon: const Icon(Icons.arrow_right, color: Colors.white, size: 30),
//             onPressed: () {
//               _pageController.nextPage(
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProjectGrid(List<Map<String, String>> projects) {
//     if (projects.isEmpty) {
//       return const Center(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Text(
//             'No projects available',
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//         ),
//       );
//     }
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           childAspectRatio: 2 / 3,
//         ),
//         itemCount: projects.length,
//         itemBuilder: (context, index) {
//           final String image = projects[index]['image'] ?? 'assets/placeholder.jpg';
//           final String location = projects[index]['location'] ?? 'Unknown Location';
//           final String name = projects[index]['name'] ?? 'Unnamed Project';
//           final String progress = projects[index]['progress'] ?? '0';

//           return Semantics(
//             label: 'Project: $name at $location',
//             child: InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ProjectDetailsScreen(project: projects[index]),
//                   ),
//                 );
//               },
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   side: BorderSide(color: Colors.grey.shade200, width: 1),
//                 ),
//                 elevation: 0,
//                 shadowColor: Colors.black26,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//                             child: Image.asset(
//                               image,
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                               frameBuilder: (context, child, frame, _) =>
//                                   frame == null ? const Center(child: CircularProgressIndicator()) : child,
//                               errorBuilder: (context, error, stackTrace) {
//                                 if (kDebugMode) print('Failed to load image: $image, error: $error');
//                                 return const Center(child: Icon(Icons.error));
//                               },
//                             ),
//                           ),
//                           if (progress != '0')
//                             Positioned(
//                               top: 8,
//                               right: 8,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                 decoration: BoxDecoration(
//                                   color: Colors.orange,
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Text(
//                                   '$progress%',
//                                   style: const TextStyle(color: Colors.white, fontSize: 12),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             name,
//                             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             location,
//                             style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



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

class _OngoingProjectsState extends State<OngoingProjects> with SingleTickerProviderStateMixin {
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();
  int _navIndex = 2; // Projects is index 2
  late TabController _tabController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Simulate loading
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    
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
    _imageTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted && _pageController.hasClients && carouselImages.isNotEmpty) {
        setState(() {
          _currentImageIndex = (_currentImageIndex + 1) % carouselImages.length;
          _pageController.animateToPage(
            _currentImageIndex,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _imageTimer?.cancel();
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == _navIndex) return;
    setState(() {
      _navIndex = index;
    });
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
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.grey.shade50,
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Projects Gallery',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.black87),
              onPressed: () {
                // Implement search functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Search coming soon!'))
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.filter_list, color: Colors.black87),
              onPressed: () {
                // Implement filter functionality
                _showFilterDialog();
              },
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey.shade600,
            indicatorColor: Colors.orange,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'ONGOING'),
              Tab(text: 'COMPLETED'),
            ],
          ),
        ),
        body: _isLoading 
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                  SizedBox(height: 20),
                  Text('Loading your projects...',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              color: Colors.orange,
              onRefresh: () async {
                // Simulate refresh
                setState(() {
                  _isLoading = true;
                });
                await Future.delayed(const Duration(seconds: 1));
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCarousel(),
                    const SizedBox(height: 16),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildProjectList(ongoingProjects),
                          _buildProjectList(completedProjects),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.add),
          onPressed: () {
            // Navigation to create new project or some relevant action
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Create new project coming soon!'))
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _navIndex,
          onTap: _onNavTap,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey.shade600,
          backgroundColor: Colors.white,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Services'),
            BottomNavigationBarItem(
              icon: Icon(Icons.layers),
              label: 'Projects',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
            BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Projects',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text('Project Status', style: TextStyle(fontWeight: FontWeight.w500)),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: Text('All'),
                  selected: true,
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.grey.shade200,
                  selectedColor: Colors.orange.shade100,
                  checkmarkColor: Colors.orange,
                ),
                FilterChip(
                  label: Text('In Progress'),
                  selected: false,
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.grey.shade200,
                ),
                FilterChip(
                  label: Text('On Hold'),
                  selected: false,
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.grey.shade200,
                ),
              ],
            ),
            SizedBox(height: 12),
            Text('Location', style: TextStyle(fontWeight: FontWeight.w500)),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: Text('All Locations'),
                  selected: true,
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.grey.shade200,
                  selectedColor: Colors.orange.shade100,
                  checkmarkColor: Colors.orange,
                ),
                FilterChip(
                  label: Text('New York'),
                  selected: false,
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.grey.shade200,
                ),
                FilterChip(
                  label: Text('Los Angeles'),
                  selected: false,
                  onSelected: (bool selected) {},
                  backgroundColor: Colors.grey.shade200,
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text('Apply Filters'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    if (carouselImages.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: Text('No featured projects available', style: TextStyle(color: Colors.grey))),
      );
    }
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
              _imageTimer?.cancel();
              _startTimer();
            },
            itemCount: carouselImages.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    child: Image.asset(
                      carouselImages[index],
                      fit: BoxFit.cover,
                      frameBuilder: (context, child, frame, _) =>
                          frame == null ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange))) : child,
                      errorBuilder: (context, error, stackTrace) {
                        if (kDebugMode) print('Carousel image failed: ${carouselImages[index]}, error: $error');
                        return Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey.shade400));
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'FEATURED PROJECT',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Modern Urban Residence',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(blurRadius: 2, color: Colors.black54, offset: Offset(1, 1))
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'New York City',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 16),
                            Icon(Icons.timelapse, color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text(
                              '75% Complete',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                carouselImages.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: _currentImageIndex == index ? 20 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentImageIndex == index ? Colors.orange : Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectList(List<Map<String, String>> projects) {
    if (projects.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.layers, size: 60, color: Colors.grey.shade400),
            SizedBox(height: 16),
            Text(
              'No projects available',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
            ),
            SizedBox(height: 8),
            Text(
              'Projects will appear here once they begin',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final String image = projects[index]['image'] ?? 'assets/placeholder.jpg';
          final String location = projects[index]['location'] ?? 'Unknown Location';
          final String name = projects[index]['name'] ?? 'Unnamed Project';
          final String progress = projects[index]['progress'] ?? '0';
          final String date = projects[index]['date'] ?? 'In progress';

          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ProjectCard(
              name: name,
              location: location,
              image: image,
              progress: progress,
              date: date,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectDetailsScreen(project: projects[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String name;
  final String location;
  final String image;
  final String progress;
  final String date;
  final VoidCallback onTap;

  const ProjectCard({
    Key? key,
    required this.name,
    required this.location,
    required this.image,
    required this.progress,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    image,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    frameBuilder: (context, child, frame, _) =>
                        frame == null
                            ? Container(
                                height: 160,
                                width: double.infinity,
                                color: Colors.grey.shade200,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                                  ),
                                ),
                              )
                            : child,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 160,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                      );
                    },
                  ),
                  if (progress != '0')
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$progress%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                      SizedBox(width: 4),
                      Text(
                        date,
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  if (progress != '0' && progress != '100')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Progress',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '$progress%',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: int.parse(progress) / 100,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    icon: Icon(Icons.visibility, size: 16),
                    label: Text('View Details'),
                    onPressed: onTap,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.orange,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // Implement share functionality
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(8),
                      minimumSize: Size(0, 0),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.share, size: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}