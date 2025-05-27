




// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:laphic_app/booking.dart';
// import 'package:laphic_app/compound_design.dart';
// import 'package:laphic_app/construction.dart';
// import 'package:laphic_app/feedback.dart';
// import 'package:laphic_app/funitures_designs.dart';
// import 'package:laphic_app/gypsum_works.dart';
// import 'package:laphic_app/interior_design.dart';
// import 'package:laphic_app/livechat.dart';
// import 'package:laphic_app/metal_fabrication.dart';
// import 'package:laphic_app/notification.dart';
// import 'package:laphic_app/painting.dart';
// import 'package:laphic_app/profile_screen.dart';
// import 'package:laphic_app/projects_designn.dart';

// class ServicesHomePage extends StatefulWidget {
//   const ServicesHomePage({Key? key}) : super(key: key);

//   @override
//   State<ServicesHomePage> createState() => _ServicesHomePageState();
// }

// class _ServicesHomePageState extends State<ServicesHomePage> with SingleTickerProviderStateMixin {
//   // Color scheme
//   final Color primaryColor = const Color(0xFF080F2B);
//   final Color accentColor = const Color(0xFFFF9800);
//   final Color backgroundColor = Colors.grey.shade50;
//   final Color cardColor = Colors.white;
//   final Color textColor = const Color(0xFF333333);
//   final Color subtextColor = const Color(0xFF757575);
  
//   // Controllers
//   final TextEditingController _searchController = TextEditingController();
//   final PageController _carouselController = PageController();
//   late TabController _tabController;
  
//   // State variables
//   String _searchQuery = '';
//   final List<String> _searchHistory = [];
//   int _currentNavIndex = 1;
//   Timer? _carouselTimer;
//   int _currentCarouselPage = 0;
//   bool _isLoading = false;

//   // List of carousel banners
//   final List<Map<String, dynamic>> _banners = [
//     {
//       'image': 'assets/location.JPG',
//       'title': 'Limited Time Offer!',
//       'subtitle': 'Get 40% off on Interior Design',
//       'buttonText': 'Claim Now'
//     },
//     {
//       'image': 'assets/hommie.jpg',
//       'title': 'New Collection',
//       'subtitle': 'Modern furniture for your home',
//       'buttonText': 'Explore'
//     },
//     {
//       'image': 'assets/kit.jpg',
//       'title': 'Premium Quality',
//       'subtitle': 'Construction materials at best prices',
//       'buttonText': 'Shop Now'
//     },
//     {
//       'image': 'assets/SECOND PAGE.jpg',
//       'title': 'Custom Design',
//       'subtitle': 'Create your perfect living space',
//       'buttonText': 'Get Started'
//     },
//     {
//       'image': 'assets/THIRD SCREEN.jpg',
//       'title': 'Professional Service',
//       'subtitle': 'Expert contractors at your service',
//       'buttonText': 'Book Now'
//     },
//   ];

//   // List of categories with their titles, icons, screens, and image paths
//   final List<Map<String, dynamic>> _allCategories = [
//     {
//       'title': 'Construction',
//       'icon': Icons.construction,
//       'screen': const ConstructionPage(),
//       'imagePath': 'assets/THIRD SCREEN.jpg',
//       'rating': 4.8,
//       'description': 'Professional building services',
//     },
//     {
//       'title': 'Painting',
//       'icon': Icons.format_paint,
//       'screen': const PaintingPage(),
//       'imagePath': 'assets/painting2.jpeg',
//       'rating': 4.9,
//       'description': 'Premium painting solutions',
//     },
//     {
//       'title': 'Furniture',
//       'icon': Icons.chair,
//       'screen': const FurnitureDesignScreen(),
//       'imagePath': 'assets/interior3.jpeg',
//       'rating': 4.7,
//       'description': 'Custom furniture design',
//     },
//     {
//       'title': 'Compound Design',
//       'icon': Icons.landscape,
//       'screen': const CompoundDesignPage(),
//       'imagePath': 'assets/compound 1.jpg',
//       'rating': 4.6,
//       'description': 'Beautiful outdoor spaces',
//     },
//     {
//       'title': 'Interior Design',
//       'icon': Icons.home_work,
//       'screen': const InteriorGalleryScreen(),
//       'imagePath': 'assets/THIRD SCREEN.jpg',
//       'rating': 4.9,
//       'description': 'Transform your living space',
//     },
//     {
//       'title': 'Gypsum Work',
//       'icon': Icons.layers,
//       'screen': const GypsumWorksScreen(),
//       'imagePath': 'assets/THIRD SCREEN.jpg',
//       'rating': 4.5,
//       'description': 'Modern ceiling & wall designs',
//     },
//     {
//       'title': 'Metal Fabrication',
//       'icon': Icons.precision_manufacturing,
//       'screen': const MetalFabricationPage(),
//       'imagePath': 'assets/THIRD SCREEN.jpg',
//       'rating': 4.8,
//       'description': 'Custom metal works & gates',
//     },
//   ];

//   // Featured services - we can highlight some special services here
//   final List<Map<String, dynamic>> _featuredServices = [
//     {
//       'title': 'Interior Design Consultation',
//       'imagePath': 'assets/interior3.jpeg',
//       'price': 'UGX 150,000',
//       'rating': 4.9,
//       'duration': '1 hour',
//     },
//     {
//       'title': 'Premium Wall Painting',
//       'imagePath': 'assets/painting2.jpeg',
//       'price': 'UGX 25,000/sqm',
//       'rating': 4.8,
//       'duration': 'Varies',
//     },
//     {
//       'title': 'Custom Furniture Design',
//       'imagePath': 'assets/hommie.jpg',
//       'price': 'From UGX 500,000',
//       'rating': 4.7,
//       'duration': '7-14 days',
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//     _startCarouselTimer();
//     _tabController = TabController(length: 3, vsync: this);
    
//     // Simulate loading state
//     setState(() {
//       _isLoading = true;
//     });
    
//     Future.delayed(const Duration(milliseconds: 800), () {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     _carouselController.dispose();
//     _tabController.dispose();
//     _carouselTimer?.cancel();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     setState(() {
//       _searchQuery = _searchController.text.toLowerCase();
//     });
//   }

//   void _startCarouselTimer() {
//     _carouselTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
//       if (_carouselController.hasClients) {
//         _currentCarouselPage = (_currentCarouselPage + 1) % _banners.length;
//         _carouselController.animateToPage(
//           _currentCarouselPage,
//           duration: const Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }

//   void _pauseCarouselTimer() {
//     _carouselTimer?.cancel();
//     Future.delayed(const Duration(seconds: 5), () {
//       if (mounted) {
//         _startCarouselTimer();
//       }
//     });
//   }

//   void _addToSearchHistory(String query) {
//     if (query.isNotEmpty && !_searchHistory.contains(query)) {
//       setState(() {
//         _searchHistory.insert(0, query);
//         if (_searchHistory.length > 5) {
//           _searchHistory.removeLast();
//         }
//       });
//     }
//   }

//   void _showSearchHistory(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Recent Searches',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: textColor,
//                     fontSize: 18,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text(
//                     'Close',
//                     style: TextStyle(color: accentColor),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             _searchHistory.isEmpty
//                 ? Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.search_off,
//                             size: 40,
//                             color: subtextColor,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'No recent searches',
//                             style: TextStyle(color: subtextColor),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 : Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: _searchHistory.length,
//                       itemBuilder: (context, index) {
//                         final query = _searchHistory[index];
//                         return ListTile(
//                           leading: const Icon(Icons.history),
//                           title: Text(query),
//                           trailing: const Icon(Icons.north_west, size: 16),
//                           onTap: () {
//                             setState(() {
//                               _searchController.text = query;
//                               _searchQuery = query.toLowerCase();
//                             });
//                             Navigator.pop(context);
//                           },
//                         );
//                       },
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _navigateToServiceDetail(Map<String, dynamic> service) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => service['screen'],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredCategories = _searchQuery.isEmpty
//         ? _allCategories
//         : _allCategories
//             .where((category) =>
//                 category['title'].toLowerCase().contains(_searchQuery))
//             .toList();

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       drawer: _buildDrawer(),
//       appBar: _buildAppBar(),
//       body: _isLoading
//           ? _buildLoadingState()
//           : RefreshIndicator(
//               color: accentColor,
//               onRefresh: () async {
//                 // Simulate a refresh
//                 setState(() {
//                   _isLoading = true;
//                 });
//                 await Future.delayed(const Duration(seconds: 1));
//                 if (mounted) {
//                   setState(() {
//                     _isLoading = false;
//                   });
//                 }
//               },
//               child: SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildSearchBar(),
//                     _buildCarousel(),
//                     const SizedBox(height: 8),
//                     _buildCarouselIndicator(),
//                     const SizedBox(height: 16),
//                     _buildTabBar(),
//                     const SizedBox(height: 16),
//                     _buildCategorySection(filteredCategories),
//                     const SizedBox(height: 24),
//                     _buildSectionTitle('Featured Services', onSeeAll: () {}),
//                     _buildFeaturedServices(),
//                     const SizedBox(height: 24),
//                     _buildRecommendedServices(filteredCategories),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             ),
//       bottomNavigationBar: _buildBottomNavigationBar(),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: accentColor,
//         child: const Icon(Icons.message),
//         onPressed: () {
//           Navigator.push(
//             context, 
//             MaterialPageRoute(builder: (_) => const ChatPage()),
//           );
//         },
//       ),
//     );
//   }
  
//   Widget _buildLoadingState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(color: accentColor),
//           const SizedBox(height: 16),
//           Text(
//             'Loading services...',
//             style: TextStyle(color: subtextColor),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDrawer() {
//     return Drawer(
//       child: Column(
//         children: [
//           UserAccountsDrawerHeader(
//             decoration: BoxDecoration(color: primaryColor),
//             currentAccountPicture: const CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Icon(Icons.person, size: 40, color: Colors.grey),
//             ),
//             accountName: const Text("User Name"),
//             accountEmail: const Text("user@example.com"),
//           ),
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 _buildDrawerItem(
//                   icon: Icons.person,
//                   title: 'Profile',
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const ProfilePage()),
//                     );
//                   },
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.book_online,
//                   title: 'My Bookings',
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const BookingScreen(
//                           initialDesign: '',
//                           initialServiceType: '',
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.history,
//                   title: 'Order History',
//                   onTap: () {
//                     Navigator.pop(context);
//                     // Navigate to order history
//                   },
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.favorite,
//                   title: 'Saved Services',
//                   onTap: () {
//                     Navigator.pop(context);
//                     // Navigate to saved services
//                   },
//                 ),
//                 const Divider(),
//                 _buildDrawerItem(
//                   icon: Icons.payment,
//                   title: 'Payment Methods',
//                   onTap: () {
//                     Navigator.pop(context);
//                     // Navigate to payment methods
//                   },
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.location_on,
//                   title: 'Addresses',
//                   onTap: () {
//                     Navigator.pop(context);
//                     // Navigate to addresses
//                   },
//                 ),
//                 const Divider(),
//                 _buildDrawerItem(
//                   icon: Icons.chat,
//                   title: 'Live Chat Support',
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const ChatPage()),
//                     );
//                   },
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.feedback,
//                   title: 'Provide Feedback',
//                   onTap: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const FeedbackInquiryScreen()),
//                     );
//                   },
//                 ),
//                 const Divider(),
//                 _buildDrawerItem(
//                   icon: Icons.settings,
//                   title: 'Settings',
//                   onTap: () {
//                     Navigator.pop(context);
//                     // Navigate to settings
//                   },
//                 ),
//                 _buildDrawerItem(
//                   icon: Icons.help,
//                   title: 'Help & Support',
//                   onTap: () {
//                     Navigator.pop(context);
//                     // Navigate to help
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: Column(
//               children: [
//                 const Divider(),
//                 ListTile(
//                   leading: Icon(Icons.logout, color: textColor),
//                   title: Text(
//                     'Logout',
//                     style: TextStyle(color: textColor),
//                   ),
//                   onTap: () {
//                     // Handle logout
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDrawerItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: textColor),
//       title: Text(title),
//       onTap: onTap,
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: primaryColor,
//       title: Row(
//         children: [
//           Icon(Icons.location_on, color: accentColor, size: 18),
//           const SizedBox(width: 4),
//           Text(
//             'Kitende, Kampala',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
//         ],
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.notifications_outlined, color: Colors.white),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const NotificationsScreen()),
//             );
//           },
//         ),
//         const SizedBox(width: 8),
//       ],
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.search, color: subtextColor),
//           const SizedBox(width: 12),
//           Expanded(
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search for services...',
//                 hintStyle: TextStyle(color: subtextColor),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(vertical: 16),
//               ),
//               onSubmitted: (value) {
//                 _addToSearchHistory(value);
//               },
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.history, color: subtextColor),
//             onPressed: () => _showSearchHistory(context),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCarousel() {
//     return SizedBox(
//       height: 180,
//       child: PageView.builder(
//         controller: _carouselController,
//         itemCount: _banners.length,
//         onPageChanged: (index) {
//           setState(() {
//             _currentCarouselPage = index;
//           });
//           _pauseCarouselTimer();
//         },
//         itemBuilder: (context, index) {
//           final banner = _banners[index];
//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               image: DecorationImage(
//                 image: AssetImage(banner['image']),
//                 fit: BoxFit.cover,
//                 onError: (exception, stackTrace) {
//                   if (kDebugMode) {
//                     print('Error loading carousel image: ${banner['image']}, Error: $exception');
//                   }
//                 },
//               ),
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.black.withOpacity(0.1),
//                     Colors.black.withOpacity(0.6),
//                   ],
//                 ),
//               ),
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     banner['title'],
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     banner['subtitle'],
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.9),
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: accentColor,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: Text(banner['buttonText']),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCarouselIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//         _banners.length,
//         (index) => Container(
//           width: 8,
//           height: 8,
//           margin: const EdgeInsets.symmetric(horizontal: 4),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: _currentCarouselPage == index
//                 ? accentColor
//                 : Colors.grey.withOpacity(0.3),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTabBar() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TabBar(
//         controller: _tabController,
//         labelColor: accentColor,
//         unselectedLabelColor: subtextColor,
//         indicatorColor: accentColor,
//         indicatorSize: TabBarIndicatorSize.label,
//         tabs: const [
//           Tab(text: 'All Services'),
//           Tab(text: 'Top Rated'),
//           Tab(text: 'Featured'),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategorySection(List<Map<String, dynamic>> categories) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionTitle('Service Categories', onSeeAll: () {}),
//         SizedBox(
//           height: 110,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             itemCount: categories.length,
//             itemBuilder: (context, index) {
//               final category = categories[index];
//               return Padding(
//                 padding: const EdgeInsets.only(right: 16),
//                 child: GestureDetector(
//                   onTap: () => _navigateToServiceDetail(category),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: accentColor.withOpacity(0.1),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           category['icon'] as IconData,
//                           color: accentColor,
//                           size: 32,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         category['title'] as String,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: textColor,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFeaturedServices() {
//     return SizedBox(
//       height: 220,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: _featuredServices.length,
//         itemBuilder: (context, index) {
//           final service = _featuredServices[index];
//           return Container(
//             width: 240,
//             margin: const EdgeInsets.only(right: 16),
//             decoration: BoxDecoration(
//               color: cardColor,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: const Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//                   child: Image.asset(
//                     service['imagePath'],
//                     height: 120,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         height: 120,
//                         color: Colors.grey.shade200,
//                         child: const Center(
//                           child: Icon(Icons.image_not_supported, size: 50),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         service['title'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: textColor,
//                           fontSize: 14,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Icon(Icons.star, color: accentColor, size: 16),
//                           const SizedBox(width: 4),
//                           Text(
//                             service['rating'].toString(),
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: textColor,
//                               fontSize: 12,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           Icon(Icons.schedule, color: subtextColor, size: 14),
//                           const SizedBox(width: 4),
//                           Text(
//                             service['duration'],
//                             style: TextStyle(
//                               color: subtextColor,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             service['price'],
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: accentColor,
//                               fontSize: 14,
//                             ),
//                           ),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: accentColor,
//                               foregroundColor: Colors.white,
//                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               minimumSize: const Size(80, 32),
//                             ),
//                             onPressed: () {},
//                             child: const Text('Book'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildRecommendedServices(List<Map<String, dynamic>> categories) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionTitle('Recommended for You', onSeeAll: () {}),
//         ListView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           itemCount: categories.length > 3 ? 3 : categories.length,
//           itemBuilder: (context, index) {
//             final category = categories[index];
//             return Container(
//               margin: const EdgeInsets.only(bottom: 16),
//               decoration: BoxDecoration(
//                 color: cardColor,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: InkWell(
//                 onTap: () => _navigateToServiceDetail(category),
//                 borderRadius: BorderRadius.circular(12),
//                 child: Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
//                       child: Image.asset(
//                         category['imagePath'],
//                         height: 100,
//                         width: 100,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             height: 100,
//                             width: 100,
//                             color: Colors.grey.shade200,
//                             child: Icon(
//                               category['icon'] as IconData,
//                               size: 36,
//                               color: accentColor,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               category['title'],
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: textColor,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               category['description'],
//                               style: TextStyle(
//                                 color: subtextColor,
//                                 fontSize: 12,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 8),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Icon(Icons.star, color: accentColor, size: 16),
//                                     const SizedBox(width: 4),
//                                     Text(
//                                       category['rating'].toString(),
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: textColor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Icon(
//                                   Icons.arrow_forward_ios,
//                                   color: accentColor,
//                                   size: 16,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildSectionTitle(String title, {required VoidCallback onSeeAll}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//               color: textColor,
//             ),
//           ),
//           InkWell(
//             onTap: onSeeAll,
//             borderRadius: BorderRadius.circular(4),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//               child: Row(
//                 children: [
//                   Text(
//                     'See all',
//                     style: TextStyle(
//                       color: accentColor,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(width: 2),
//                   Icon(
//                     Icons.arrow_forward,
//                     color: accentColor,
//                     size: 16,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomNavigationBar() {
//     return BottomNavigationBar(
//       backgroundColor: cardColor,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: accentColor,
//       unselectedItemColor: subtextColor,
//       currentIndex: _currentNavIndex,
//       elevation: 16,
//       showUnselectedLabels: true,
//       selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
//       unselectedLabelStyle: const TextStyle(fontSize: 10),
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
//         BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Services'),
//         BottomNavigationBarItem(icon: Icon(Icons.layers_outlined), activeIcon: Icon(Icons.layers), label: 'Projects'),
//         BottomNavigationBarItem(icon: Icon(Icons.book_outlined), activeIcon: Icon(Icons.book), label: 'Booking'),
//         BottomNavigationBarItem(icon: Icon(Icons.feedback_outlined), activeIcon: Icon(Icons.feedback), label: 'Feedback'),
//       ],
//       onTap: (index) {
//         setState(() {
//           _currentNavIndex = index;
//         });
//         switch (index) {
//           case 0:
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const ProfilePage()),
//             );
//             break;
//           case 1:
//             // Already on Services, do nothing
//             break;
//           case 2:
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const OngoingProjects()),
//             );
//             break;
//           case 3:
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const BookingScreen(initialDesign: '', initialServiceType: '')),
//             );
//             break;
//           case 4:
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const FeedbackInquiryScreen()),
//             );
//             break;
//         }
//       },
//     );
//   }
// }






import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:laphic_app/constants/app_color.dart';
import 'package:laphic_app/models/featured_services.dart';
import 'package:laphic_app/models/service_categories.dart';
import 'package:laphic_app/painting.dart';
import 'package:shimmer/shimmer.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/compound_design.dart';
import 'package:laphic_app/construction.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/funitures_designs.dart';
import 'package:laphic_app/gypsum_works.dart';
import 'package:laphic_app/interior_design.dart';
import 'package:laphic_app/livechat.dart';
import 'package:laphic_app/metal_fabrication.dart';
import 'package:laphic_app/notification.dart';
import 'package:laphic_app/profile_screen.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/widgets/rating_stars.dart';


class ServicesHomePage extends StatefulWidget {
  const ServicesHomePage({Key? key}) : super(key: key);

  @override
  State<ServicesHomePage> createState() => _ServicesHomePageState();
}

class _ServicesHomePageState extends State<ServicesHomePage>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late PageController _carouselController;
  late TabController _tabController;
  late AnimationController _animationController;
  String _searchQuery = '';
  final List<String> _searchHistory = [];
  int _currentNavIndex = 1;
  Timer? _carouselTimer;
  int _currentCarouselPage = 0;
  bool _isLoading = true;
  Timer? _searchDebounce;
  bool _favoriteToggled = false;
  bool _isRefreshing = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final ScrollController _scrollController = ScrollController();
  List<ServiceCategory> _filteredCategories = [];

  final List<Map<String, dynamic>> _banners = [
    {
      'image': 'assets/kit.jpg',
      'title': 'Limited Time Offer!',
      'subtitle': 'Get 40% off on Interior Design',
      'buttonText': 'Claim Now',
      'color': AppColors.primaryColor
    },
    {
      'image': 'assets/hommie.jpg',
      'title': 'New Collection',
      'subtitle': 'Modern furniture for your home',
      'buttonText': 'Explore',
      'color': AppColors.primaryColor
    },
    {
      'image': 'assets/kit.jpg',
      'title': 'Premium Quality',
      'subtitle': 'Construction materials at best prices',
      'buttonText': 'Shop Now',
      'color': AppColors.primaryColor
    },
    {
      'image': 'assets/SECOND PAGE.jpg',
      'title': 'Custom Design',
      'subtitle': 'Create your perfect living space',
      'buttonText': 'Get Started',
      'color': AppColors.primaryColor
    },
    {
      'image': 'assets/THIRD SCREEN.jpg',
      'title': 'Professional Service',
      'subtitle': 'Expert contractors at your service',
      'buttonText': 'Book Now',
      'color': AppColors.primaryColor
    },
  ];

  final List<Map<String, dynamic>> _inspirations = [
    {
      'image': 'assets/painting2.jpeg',
      'title': 'Vibrant Wall Painting',
      'service': 'Painting',
      'screen': const PaintingPage(),
    },
    {
      'image': 'assets/interior3.jpeg',
      'title': 'Modern Interior Design',
      'service': 'Interior Design',
      'screen': const InteriorGalleryScreen(),
    },
    {
      'image': 'assets/bed.jpg',
      'title': 'Custom Furniture',
      'service': 'Furniture',
      'screen': const FurnitureDesignScreen(),
    },
    {
      'image': 'assets/SWIUXEXDJDK.jpg',
      'title': 'Solid Construction',
      'service': 'Construction',
      'screen': const ConstructionPage(),
    },
    {
      'image': 'assets/metal.jpeg',
      'title': 'Metal Fabrication',
      'service': 'Metal Fabrication',
      'screen': const MetalFabricationPage(),
    },
  ];

  final List<ServiceCategory> _allCategories = [
    ServiceCategory(
      title: 'Construction',
      icon: Icons.construction,
      screen: const ConstructionPage(),
      imagePath: 'assets/SWIUXEXDJDK.jpg',
      rating: 4.8,
      description: 'Professional building services',
      isPopular: true,
    ),
    ServiceCategory(
      title: 'Painting',
      icon: Icons.format_paint,
      screen: const PaintingPage(),
      imagePath: 'assets/painting2.jpeg',
      rating: 4.9,
      description: 'Premium painting solutions',
      isPopular: true,
    ),
    ServiceCategory(
      title: 'Furniture',
      icon: Icons.chair,
      screen: const FurnitureDesignScreen(),
      imagePath: 'assets/bed.jpg',
      rating: 4.7,
      description: 'Custom furniture design',
      isPopular: false,
    ),
    ServiceCategory(
      title: 'Compound Design',
      icon: Icons.landscape,
      screen: const CompoundDesignPage(),
      imagePath: 'assets/compound 1.jpg',
      rating: 4.6,
      description: 'Beautiful outdoor spaces',
      isPopular: false,
    ),
    ServiceCategory(
      title: 'Interior Design',
      icon: Icons.home_work,
      screen: const InteriorGalleryScreen(),
      imagePath: 'assets/interior7.jpeg',
      rating: 4.9,
      description: 'Transform your living space',
      isPopular: true,
    ),
    ServiceCategory(
      title: 'Gypsum',
      icon: Icons.layers,
      screen: const GypsumWorksScreen(),
      imagePath: 'assets/gypsum.jpg',
      rating: 4.5,
      description: 'Modern ceiling & wall designs',
      isPopular: false,
    ),
    ServiceCategory(
      title: 'Metal Fabrication',
      icon: Icons.precision_manufacturing,
      screen: const MetalFabricationPage(),
      imagePath: 'assets/metal.jpeg',
      rating: 4.8,
      description: 'Custom metal works & gates',
      isPopular: true,
    ),
  ];

  final List<FeaturedService> _featuredServices = [
    FeaturedService(
      title: 'Interior Design Consultation',
      imagePath: 'assets/interior3.jpeg',
      price: 'UGX 150,000',
      rating: 4.9,
      duration: '1 hour',
      serviceType: 'Interior Design',
      discount: 15,
      reviewCount: 127,
    ),
    FeaturedService(
      title: 'Premium Wall Painting',
      imagePath: 'assets/painting2.jpeg',
      price: 'UGX 25,000/sqm',
      rating: 4.8,
      duration: 'Varies',
      serviceType: 'Painting',
      discount: 0,
      reviewCount: 89,
    ),
    FeaturedService(
      title: 'Custom Furniture Design',
      imagePath: 'assets/hommie.jpg',
      price: 'From UGX 500,000',
      rating: 4.7,
      duration: '7-14 days',
      serviceType: 'Furniture',
      discount: 10,
      reviewCount: 64,
    ),
    FeaturedService(
      title: 'Complete Home Renovation',
      imagePath: 'assets/SWIUXEXDJDK.jpg',
      price: 'From UGX 5,000,000',
      rating: 4.9,
      duration: '30-90 days',
      serviceType: 'Construction',
      discount: 0,
      reviewCount: 42,
    ),
  ];

  List<ServiceCategory> get _recommendedServices {
    return _allCategories
        .where((category) => category.rating >= 4.7)
        .toList()
      ..shuffle();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _carouselController = PageController(
      viewportFraction: 0.92,
      initialPage: _currentCarouselPage,
    );
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _startCarouselTimer();
    _updateFilteredCategories();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {}

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _carouselController.dispose();
    _tabController.dispose();
    _carouselTimer?.cancel();
    _searchDebounce?.cancel();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _searchQuery = _searchController.text.toLowerCase();
          _updateFilteredCategories();
        });
      }
    });
  }

  void _updateFilteredCategories() {
    setState(() {
      if (_searchQuery.isEmpty) {
        _filteredCategories = List.from(_allCategories);
      } else {
        _filteredCategories = _allCategories
            .where((category) =>
                category.title.toLowerCase().contains(_searchQuery) ||
                category.description.toLowerCase().contains(_searchQuery))
            .toList();
      }
    });
  }

  void _startCarouselTimer() {
    _carouselTimer?.cancel();
    _carouselTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_carouselController.hasClients && mounted) {
        _currentCarouselPage = (_currentCarouselPage + 1) % _banners.length;
        _carouselController.animateToPage(
          _currentCarouselPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _pauseCarouselTimer() {
    _carouselTimer?.cancel();
  }

  void _addToSearchHistory(String query) {
    if (query.isNotEmpty && !_searchHistory.contains(query)) {
      setState(() {
        _searchHistory.insert(0, query);
        if (_searchHistory.length > 5) {
          _searchHistory.removeLast();
        }
      });
    }
  }

  void _showSearchHistory(BuildContext context) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.3,
        maxChildSize: 0.7,
        expand: false,
        builder: (context, scrollController) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Searches',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.textColor,
                    ),
                  ),
                  Row(
                    children: [
                      if (_searchHistory.isNotEmpty)
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _searchHistory.clear();
                            });
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.delete_outline, size: 16),
                          label: const Text('Clear'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primaryColor,
                          ),
                        ),
                      TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, size: 16),
                        label: const Text('Close'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: _searchHistory.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No recent searches',
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your search history will appear here',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: _searchHistory.length,
                      itemBuilder: (context, index) {
                        final query = _searchHistory[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey.shade100,
                            child: Icon(
                              Icons.history,
                              color: AppColors.accentColor,
                              size: 18,
                            ),
                          ),
                          title: Text(
                            query,
                            style: const TextStyle(color: AppColors.textColor),
                          ),
                          trailing: const Icon(Icons.north_west, size: 14),
                          onTap: () {
                            setState(() {
                              _searchController.text = query;
                              _searchQuery = query.toLowerCase();
                              _updateFilteredCategories();
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    setState(() {
      _isRefreshing = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _updateFilteredCategories();
      _isRefreshing = false;
    });
  }

  void _navigateToServiceDetail(ServiceCategory service) {
    HapticFeedback.selectionClick();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => service.screen),
    );
  }

  void _navigateToInspiration(Widget screen) {
    HapticFeedback.selectionClick();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void _navigateToFeaturedService(FeaturedService service) {
    HapticFeedback.selectionClick();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingScreen(
          initialDesign: '',
          initialServiceType: service.serviceType,
        ),
      ),
    );
  }

  void _toggleFavorite() {
    HapticFeedback.lightImpact();
    setState(() {
      _favoriteToggled = !_favoriteToggled;
      _animationController.reset();
      _animationController.forward();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_favoriteToggled
            ? 'Added to favorites'
            : 'Removed from favorites'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(bottom: 70, left: 20, right: 20),
        backgroundColor: AppColors.accentColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      drawer: _buildDrawer(),
      appBar: _buildAppBar(),
      body: _isLoading
          ? _buildLoadingState()
          : RefreshIndicator(
              key: _refreshIndicatorKey,
              color: AppColors.primaryColor,
              onRefresh: _refreshData,
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: _buildSearchBar()),
                  SliverToBoxAdapter(child: _buildCarousel()),
                  SliverToBoxAdapter(child: const SizedBox(height: 8)),
                  SliverToBoxAdapter(child: _buildCarouselIndicator()),
                  SliverToBoxAdapter(child: const SizedBox(height: 16)),
                  SliverToBoxAdapter(child: _buildTabBar()),
                  SliverToBoxAdapter(child: _buildTabBarView()),
                  SliverToBoxAdapter(child: const SizedBox(height: 16)),
                  SliverToBoxAdapter(child: _buildInspirations()),
                  SliverToBoxAdapter(child: const SizedBox(height: 16)),
                  SliverToBoxAdapter(child: _buildRecommendedServices()),
                  SliverToBoxAdapter(
                    child: _searchQuery.isNotEmpty && _filteredCategories.isEmpty
                        ? _buildNoSearchResults()
                        : const SizedBox.shrink(),
                  ),
                  SliverToBoxAdapter(child: const SizedBox(height: 70)),
                ],
              ),
            ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildNoSearchResults() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No results found for "$_searchQuery"',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search term or browse our services',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _searchController.text = '';
                _searchQuery = '';
                _updateFilteredCategories();
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Clear Search'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 60,
                        height: 10,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 20,
              width: 150,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 240,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 20,
                width: 180,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      elevation: 2,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.accentColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                const Text(
                  "User Name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "user@example.com",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    );
                  },
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.accentColor,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerCategory(title: 'Account'),
                _buildDrawerItem(
                  icon: Icons.person,
                  title: 'Profile',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.book_online,
                  title: 'My Bookings',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BookingScreen(
                          initialDesign: '',
                          initialServiceType: '',
                        ),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.history,
                  title: 'Order History',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to order history
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.favorite,
                  title: 'Saved Services',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to saved services
                  },
                ),
                const Divider(height: 32),
                _buildDrawerCategory(title: 'Payment & Delivery'),
                _buildDrawerItem(
                  icon: Icons.payment,
                  title: 'Payment Methods',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to payment methods
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.location_on,
                  title: 'Saved Addresses',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to addresses
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.local_shipping_outlined,
                  title: 'Track Order',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to track order
                  },
                ),
                const Divider(height: 32),
                _buildDrawerCategory(title: 'Support'),
                _buildDrawerItem(
                  icon: Icons.chat,
                  title: 'Live Chat Support',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChatPage()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.feedback,
                  title: 'Provide Feedback',
                  badge: 'New',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FeedbackInquiryScreen()),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.help_outline,
                  title: 'Help & FAQs',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to help & FAQs
                  },
                ),
                const Divider(height: 32),
                _buildDrawerItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  textColor: AppColors.primaryColor,
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: Perform logout action
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Logged out successfully'),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: AppColors.accentColor,
                                ),
                              );
                            },
                            child: Text(
                              'Logout',
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: Open app settings
                  },
                  icon: const Icon(Icons.settings, size: 18),
                  label: const Text('Settings'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textColor,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChatPage()),
                    );
                  },
                  icon: const Icon(Icons.chat_bubble_outline, size: 18),
                  label: const Text('Contact Us'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerCategory({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? badge,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.accentColor),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? AppColors.textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Row(
        children: [
          Text(
            'LAPHIC',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Text(
            ' Services',
            style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined,
                  color: AppColors.textColor),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen(token: '',)),
            );
          },
        ),
        IconButton(
          icon: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Icon(
                _favoriteToggled ? Icons.favorite : Icons.favorite_border,
                color: _favoriteToggled
                    ? AppColors.primaryColor
                    : AppColors.textColor,
              );
            },
          ),
          onPressed: _toggleFavorite,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for services...',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(Icons.search, color: AppColors.accentColor),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                      _updateFilteredCategories();
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.history, color: Colors.grey),
                  onPressed: () => _showSearchHistory(context),
                ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          _addToSearchHistory(value);
          setState(() {
            _searchQuery = value.toLowerCase();
            _updateFilteredCategories();
          });
        },
      ),
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _carouselController,
        onPageChanged: (index) {
          setState(() {
            _currentCarouselPage = index;
          });
        },
        itemCount: _banners.length,
        itemBuilder: (context, index) {
          final banner = _banners[index];
          return GestureDetector(
            onPanDown: (_) => _pauseCarouselTimer(),
            onPanCancel: _startCarouselTimer,
            onPanEnd: (_) => _startCarouselTimer(),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: banner['image'],
                        placeholder: (context, url) => Container(
                          color: Colors.grey.shade200,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(Icons.error_outline, color: Colors.grey),
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              banner['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              banner['subtitle'],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Handle action based on banner type
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: banner['color'],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(banner['buttonText']),
                            ),
                          ],
                        ),
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

  Widget _buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _banners.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentCarouselPage == index ? 16 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: _currentCarouselPage == index
                ? AppColors.primaryColor
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildInspirations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Inspirations',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _inspirations.length,
            itemBuilder: (context, index) {
              final inspiration = _inspirations[index];
              return GestureDetector(
                onTap: () => _navigateToInspiration(inspiration['screen']),
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: inspiration['image'],
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey.shade200,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryColor),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: Icon(Icons.error_outline, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          inspiration['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppColors.textColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textColor,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: 'Services'),
          Tab(text: 'Featured'),
          Tab(text: 'Popular'),
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return SizedBox(
      height: 320,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildServicesGrid(),
          _buildFeaturedServices(),
          _buildPopularServices(),
        ],
      ),
    );
  }

  Widget _buildServicesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Our Services',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: _filteredCategories.length,
            itemBuilder: (context, index) {
              final category = _filteredCategories[index];
              return GestureDetector(
                onTap: () => _navigateToServiceDetail(category),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(category.icon, color: AppColors.primaryColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColors.textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      RatingStars(rating: category.rating, size: 10),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedServices() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Featured Services',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _featuredServices.length,
              itemBuilder: (context, index) {
                final service = _featuredServices[index];
                return GestureDetector(
                  onTap: () => _navigateToFeaturedService(service),
                  child: Container(
                    width: 240,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: service.imagePath,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: Colors.grey.shade200,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.primaryColor),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.grey.shade200,
                                  child: const Center(
                                    child:
                                        Icon(Icons.error_outline, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            if (service.discount > 0)
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${service.discount}% OFF',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: IconButton(
                                onPressed: _toggleFavorite,
                                icon: Icon(
                                  _favoriteToggled
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: _favoriteToggled
                                      ? AppColors.primaryColor
                                      : Colors.white,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.black38,
                                  padding: const EdgeInsets.all(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColors.textColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  RatingStars(rating: service.rating, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    '(${service.reviewCount})',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 14,
                                        color: AppColors.accentColor,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        service.duration,
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    service.price,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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

  Widget _buildPopularServices() {
    final popularCategories = _allCategories.where((c) => c.isPopular).toList();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: popularCategories.length,
      itemBuilder: (context, index) {
        final category = popularCategories[index];
        return GestureDetector(
          onTap: () => _navigateToServiceDetail(category),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: category.imagePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(Icons.error_outline, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              category.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppColors.textColor,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Popular',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category.description,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            RatingStars(rating: category.rating, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              '${category.rating}',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecommendedServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recommended for You',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _recommendedServices.length,
            itemBuilder: (context, index) {
              final service = _recommendedServices[index];
              return GestureDetector(
                onTap: () => _navigateToServiceDetail(service),
                child: Container(
                  width: 180,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: service.imagePath,
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey.shade200,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.primaryColor),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: Icon(Icons.error_outline, color: Colors.grey),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: AppColors.primaryColor,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${service.rating}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              service.description,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentNavIndex,
      onTap: (index) {
        setState(() {
          _currentNavIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OngoingProjects()),
            );
            break;
          case 1:
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const BookingScreen(
                  initialDesign: '',
                  initialServiceType: '',
                ),
              ),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
            break;
        }
      },
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey.shade500,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.design_services),
          label: 'Projects',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_online),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        HapticFeedback.mediumImpact();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChatPage()),
        );
      },
      backgroundColor: AppColors.primaryColor,
      child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
    );
  }
}