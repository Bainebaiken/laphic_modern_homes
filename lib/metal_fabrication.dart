
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:laphic_app/booking.dart';
// import 'package:laphic_app/livechat.dart';
// import 'package:laphic_app/metalDetails.dart';
// import 'package:laphic_app/profile_screen.dart';
// import 'package:laphic_app/projects_designn.dart';
// import 'package:laphic_app/services.dart';

// class MetalFabricationPage extends StatefulWidget {
//   const MetalFabricationPage({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _MetalFabricationPageState createState() => _MetalFabricationPageState();
// }

// class _MetalFabricationPageState extends State<MetalFabricationPage> {
//   int _currentImageIndex = 0;
//   Timer? _imageTimer;
//   final PageController _pageController = PageController();
//   int _navIndex = 0; // Metal Fabrication is index 0
//   bool _isSearching = false;
//   final TextEditingController _searchController = TextEditingController();
//   List<Map<String, String>> _filteredMetalWorks = [];

//   final List<String> carouselImages = [
//     'assets/metal.jpeg',
//     'assets/SWIUXEXDJDK.jpg',
//     'assets/interior7.jpeg',
//   ];

//   final List<Map<String, String>> metalWorks = [
//     {
//       'title': 'Steel Gate',
//       'price': '8,000,000 UGX',
//       'image': 'assets/metal.jpeg',
//       'description': 'A durable steel gate designed for security and aesthetic appeal, suitable for residential and commercial properties.'
//     },
//     {
//       'title': 'Iron Railings',
//       'price': '7,000,000 UGX',
//       'image': 'assets/metal.jpeg',
//       'description': 'Custom iron railings for staircases or balconies, crafted with precision for safety and elegance.'
//     },
//     {
//       'title': 'Metal Frame',
//       'price': '6,000,000 UGX',
//       'image': 'assets/metal.jpeg',
//       'description': 'Sturdy metal frame for structural support, ideal for construction projects or furniture.'
//     },
//     {
//       'title': 'Custom Grill',
//       'price': '9,000,000 UGX',
//       'image': 'assets/metal.jpeg',
//       'description': 'Bespoke metal grill for windows or doors, combining security with intricate design.'
//     },
//     {
//       'title': 'Steel Stairs',
//       'price': '3,000,000 UGX',
//       'image': 'assets/metal.jpeg',
//       'description': 'Modern steel staircase, engineered for durability and sleek appearance.'
//     },
//     {
//       'title': 'Metal Shelf',
//       'price': '6,000,000 UGX',
//       'image': 'assets/metal.jpeg',
//       'description': 'Heavy-duty metal shelving unit, perfect for storage in warehouses or homes.'
//     },
//     {
//       'title': 'Wrought Iron',
//       'price': '3,000,000 UGX',
//       'image': 'assets/metal.jpeg',
//       'description': 'Ornamental wrought iron piece, ideal for decorative fencing or furniture accents.'
//     },
//     {
//       'title': 'Basic Frame',
//       'price': '2,000,000 UGX',
//       'image': 'assets/metal.jpeg',
//       'description': 'Simple yet robust metal frame for various applications, from signage to construction.'
//     },
//     {
//       'title': 'Ornate Gate',
//       'price': '9,000,000 UGX',
//       'image': 'assets/metal.jpeg',
//       'description': 'An intricately designed gate, blending functionality with artistic craftsmanship.'
//     },
//     {
//       'title': 'Heavy Duty',
//       'price': '12,000,000 UGX',
//       'image': 'assets/metal.jpeg',
//       'description': 'Heavy-duty metal structure for industrial use, built to withstand extreme conditions.'
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _filteredMetalWorks = List.from(metalWorks);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         for (var image in carouselImages) {
//           precacheImage(AssetImage(image), context);
//         }
//         _startTimer();
//       }
//     });
//     _searchController.addListener(_filterMetalWorks);
//   }

//   void _filterMetalWorks() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       if (query.isEmpty) {
//         _filteredMetalWorks = List.from(metalWorks);
//       } else {
//         _filteredMetalWorks = metalWorks
//             .where((work) =>
//                 work['title']!.toLowerCase().contains(query) ||
//                 work['description']!.toLowerCase().contains(query))
//             .toList();
//       }
//     });
//   }

//   void _startTimer() {
//     _imageTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       if (mounted && _pageController.hasClients && carouselImages.isNotEmpty) {
//         setState(() {
//           _currentImageIndex = (_currentImageIndex + 1) % carouselImages.length;
//           _pageController.animateToPage(
//             _currentImageIndex,
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.easeInOut,
//           );
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _imageTimer?.cancel();
//     _pageController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _onNavTap(int index) {
//     if (index == _navIndex) return;
//     setState(() {
//       _navIndex = index;
//     });
//     Widget nextScreen;
//     switch (index) {
//       case 0:
//         nextScreen = const ServicesHomePage();
//         break;
//       case 1:
//         nextScreen = const OngoingProjects();
//         break;
//       case 2:
//         nextScreen = const BookingScreen(initialDesign: '', initialServiceType: '',);
//         break;
//       case 3:
//         nextScreen = const ProfilePage();
//         break;
//         case 4:
//         nextScreen = const ChatPage();
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
//         scaffoldBackgroundColor: Colors.grey.shade50,
//         textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black87),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           title: _isSearching
//               ? TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     hintText: 'Search metal works...',
//                     border: InputBorder.none,
//                     hintStyle: TextStyle(color: Colors.grey.shade400),
//                   ),
//                   autofocus: true,
//                 )
//               : const Text(
//                   'Metal Fabrication',
//                   style: TextStyle(
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//           actions: [
//             IconButton(
//               icon: Icon(_isSearching ? Icons.close : Icons.search,
//                   color: Colors.black87),
//               onPressed: () {
//                 setState(() {
//                   _isSearching = !_isSearching;
//                   if (!_isSearching) {
//                     _searchController.clear();
//                   }
//                 });
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.chat_bubble_outline, color: Colors.black87),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ChatPage()),
//                 );
//               },
//             ),
//           ],
//         ),
//         body: RefreshIndicator(
//           color: Colors.orange,
//           onRefresh: () async {
//             // Simulate refresh
//             await Future.delayed(const Duration(seconds: 1));
//             setState(() {
//               _filteredMetalWorks = List.from(metalWorks);
//             });
//           },
//           child: CustomScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             slivers: [
//               SliverToBoxAdapter(
//                 child: _buildCarousel(),
//               ),
//               SliverPadding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                 sliver: SliverToBoxAdapter(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Our Products",
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       TextButton.icon(
//                         icon: const Icon(Icons.filter_list, color: Colors.orange),
//                         label: const Text(
//                           "Filter",
//                           style: TextStyle(color: Colors.orange),
//                         ),
//                         onPressed: () {
//                           _showFilterBottomSheet(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SliverPadding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 sliver: _filteredMetalWorks.isEmpty
//                     ? SliverToBoxAdapter(
//                         child: SizedBox(
//                           height: 200,
//                           child: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
//                                 const SizedBox(height: 16),
//                                 Text(
//                                   'No results found',
//                                   style: TextStyle(color: Colors.grey.shade600),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     : SliverGrid(
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 12,
//                           mainAxisSpacing: 12,
//                           childAspectRatio: 0.7,
//                         ),
//                         delegate: SliverChildBuilderDelegate(
//                           (context, index) {
//                             final work = _filteredMetalWorks[index];
//                             final String image = work['image'] ?? 'assets/metal.jpeg';
//                             final String title = work['title'] ?? 'Unknown Work';
//                             final String price = work['price'] ?? 'N/A';

//                             return Semantics(
//                               label: 'Metal work: $title, Price: $price',
//                               child: Hero(
//                                 tag: 'metal_work_$index',
//                                 child: Material(
//                                   color: Colors.transparent,
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         PageRouteBuilder(
//                                           pageBuilder: (_, animation, __) => FadeTransition(
//                                             opacity: animation,
//                                             child: MetalWorkDetailsScreen(work: work),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(16),
//                                       ),
//                                       elevation: 4,
//                                       shadowColor: Colors.black12,
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                                         children: [
//                                           Expanded(
//                                             flex: 3,
//                                             child: Stack(
//                                               fit: StackFit.expand,
//                                               children: [
//                                                 ClipRRect(
//                                                   borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//                                                   child: Image.asset(
//                                                     image,
//                                                     fit: BoxFit.cover,
//                                                     errorBuilder: (context, error, stackTrace) {
//                                                       return Container(
//                                                         color: Colors.grey.shade200,
//                                                         child: const Center(
//                                                           child: Icon(Icons.broken_image, size: 32, color: Colors.grey),
//                                                         ),
//                                                       );
//                                                     },
//                                                   ),
//                                                 ),
//                                                 Positioned(
//                                                   top: 8,
//                                                   right: 8,
//                                                   child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.white.withOpacity(0.7),
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                     child: IconButton(
//                                                       icon: const Icon(Icons.favorite_border, size: 20),
//                                                       color: Colors.red,
//                                                       onPressed: () {
//                                                         ScaffoldMessenger.of(context).showSnackBar(
//                                                           SnackBar(
//                                                             content: Text('Added ${work['title']} to favorites'),
//                                                             duration: const Duration(seconds: 1),
//                                                             behavior: SnackBarBehavior.floating,
//                                                           ),
//                                                         );
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Expanded(
//                                             flex: 2,
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(12.0),
//                                               child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     title,
//                                                     style: const TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 16,
//                                                       color: Colors.black87,
//                                                     ),
//                                                     maxLines: 1,
//                                                     overflow: TextOverflow.ellipsis,
//                                                   ),
//                                                   Text(
//                                                     price,
//                                                     style: TextStyle(
//                                                       color: Colors.orange.shade800,
//                                                       fontSize: 15,
//                                                       fontWeight: FontWeight.w600,
//                                                     ),
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Icon(Icons.star, size: 16, color: Colors.amber.shade700),
//                                                       Icon(Icons.star, size: 16, color: Colors.amber.shade700),
//                                                       Icon(Icons.star, size: 16, color: Colors.amber.shade700),
//                                                       Icon(Icons.star, size: 16, color: Colors.amber.shade700),
//                                                       Icon(Icons.star_half, size: 16, color: Colors.amber.shade700),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                           childCount: _filteredMetalWorks.length,
//                         ),
//                       ),
//               ),
//               // Add empty space at the bottom for better scrolling
//               const SliverToBoxAdapter(
//                 child: SizedBox(height: 20),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.orange,
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const BookingScreen(
//                   initialDesign: '',
//                   initialServiceType: 'Metal Fabrication',
//                 ),
//               ),
//             );
//           },
//           tooltip: 'Make a booking',
//           child: const Icon(Icons.add_shopping_cart),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _navIndex,
//           onTap: _onNavTap,
//           selectedItemColor: Colors.orange,
//           unselectedItemColor: Colors.grey.shade600,
//           backgroundColor: Colors.white,
//           elevation: 8,
//           type: BottomNavigationBarType.fixed,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Projects'),
//             BottomNavigationBarItem(icon: Icon(Icons.book_online), label: 'Booking'),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//             BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showFilterBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Container(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Filter Products',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   const Text(
//                     'Price Range',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   RangeSlider(
//                     values: const RangeValues(2000000, 9000000),
//                     min: 1000000,
//                     max: 12000000,
//                     divisions: 11,
//                     labels: const RangeLabels('2M UGX', '9M UGX'),
//                     onChanged: (RangeValues values) {},
//                     activeColor: Colors.orange,
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Categories',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Wrap(
//                     spacing: 8,
//                     children: [
//                       FilterChip(
//                         label: const Text('Gates'),
//                         selected: true,
//                         onSelected: (bool selected) {},
//                         selectedColor: Colors.orange.withOpacity(0.2),
//                         checkmarkColor: Colors.orange,
//                       ),
//                       FilterChip(
//                         label: const Text('Railings'),
//                         selected: false,
//                         onSelected: (bool selected) {},
//                       ),
//                       FilterChip(
//                         label: const Text('Frames'),
//                         selected: false,
//                         onSelected: (bool selected) {},
//                       ),
//                       FilterChip(
//                         label: const Text('Stairs'),
//                         selected: false,
//                         onSelected: (bool selected) {},
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton(
//                           style: OutlinedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             side: const BorderSide(color: Colors.orange),
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text(
//                             'Reset',
//                             style: TextStyle(color: Colors.orange),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text('Apply'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildCarousel() {
//     if (carouselImages.isEmpty) {
//       return const SizedBox(
//         height: 160,
//         child: Center(child: Text('No images available', style: TextStyle(color: Colors.grey))),
//       );
//     }
//     return Container(
//       height: 200,
//       margin: const EdgeInsets.only(top: 8),
//       child: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentImageIndex = index;
//               });
//               _imageTimer?.cancel();
//               _startTimer();
//             },
//             itemCount: carouselImages.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       spreadRadius: 1,
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Image.asset(
//                         carouselImages[index],
//                         fit: BoxFit.cover,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.transparent,
//                               Colors.black.withOpacity(0.6),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 16,
//                         left: 16,
//                         right: 16,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               'Premium Metal Works',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'Discover our finest craftsmanship',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//           Positioned(
//             bottom: 8,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 carouselImages.length,
//                 (index) => AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   width: _currentImageIndex == index ? 20 : 8,
//                   height: 8,
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     color: _currentImageIndex == index ? Colors.orange : Colors.white.withOpacity(0.5),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/livechat.dart';
import 'package:laphic_app/metalDetails.dart';
import 'package:laphic_app/profile_screen.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';

// Model class for Gallery data
class GalleryItem {
  final int id;
  final int serviceId;
  final String imageName;
  final String imageDescription;
  final String imagePath;
  final double minCost;
  final double maxCost;
  final double? minSquareMeters;
  final double? maxSquareMeters;

  GalleryItem({
    required this.id,
    required this.serviceId,
    required this.imageName,
    required this.imageDescription,
    required this.imagePath,
    required this.minCost,
    required this.maxCost,
    this.minSquareMeters,
    this.maxSquareMeters,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      id: json['id'],
      serviceId: json['Service_ID'],
      imageName: json['Image_Name'],
      imageDescription: json['Image_Description'],
      imagePath: json['Image_Path'],
      minCost: (json['Min_Cost'] as num).toDouble(),
      maxCost: (json['Max_Cost'] as num).toDouble(),
      minSquareMeters: json['Min_Square_Meters']?.toDouble(),
      maxSquareMeters: json['Max_Square_Meters']?.toDouble(),
    );
  }

  Map<String, String> toMap() {
    return {
      'title': imageName,
      'price': '${minCost.toInt().toString()} UGX',
      'image': imagePath,
      'description': imageDescription,
    };
  }
}

class MetalFabricationPage extends StatefulWidget {
  const MetalFabricationPage({Key? key}) : super(key: key);

  @override
  _MetalFabricationPageState createState() => _MetalFabricationPageState();
}

class _MetalFabricationPageState extends State<MetalFabricationPage> {
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();
  int _navIndex = 0;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredMetalWorks = [];
  List<GalleryItem> _galleryItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Replace with your Flask backend URL
  final String _baseUrl = 'http://your-backend-url:5000/api/gallery';
  final int _serviceId = 1; // Adjust based on your Metal Fabrication Service_ID

  @override
  void initState() {
    super.initState();
    _fetchGalleryItems();
    _searchController.addListener(_filterMetalWorks);
  }

  Future<void> _fetchGalleryItems() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(Uri.parse('$_baseUrl/service/$_serviceId'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _galleryItems = data.map((json) => GalleryItem.fromJson(json)).toList();
          _filteredMetalWorks = _galleryItems.map((item) => item.toMap()).toList();
          _isLoading = false;
          _startTimer();
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load gallery items';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  void _filterMetalWorks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredMetalWorks = _galleryItems.map((item) => item.toMap()).toList();
      } else {
        _filteredMetalWorks = _galleryItems
            .where((item) =>
                item.imageName.toLowerCase().contains(query) ||
                item.imageDescription.toLowerCase().contains(query))
            .map((item) => item.toMap())
            .toList();
      }
    });
  }

  void _startTimer() {
    if (_galleryItems.isEmpty) return;
    _imageTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted && _pageController.hasClients) {
        setState(() {
          _currentImageIndex = (_currentImageIndex + 1) % _galleryItems.length;
          _pageController.animateToPage(
            _currentImageIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _imageTimer?.cancel();
    _pageController.dispose();
    _searchController.dispose();
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
        nextScreen = const ServicesHomePage();
        break;
      case 1:
        nextScreen = const OngoingProjects();
        break;
      case 2:
        nextScreen = const BookingScreen(initialDesign: '', initialServiceType: '');
        break;
      case 3:
        nextScreen = const ProfilePage();
        break;
      case 4:
        nextScreen = const ChatPage();
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
        scaffoldBackgroundColor: Colors.grey.shade50,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black87),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search metal works...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                  ),
                  autofocus: true,
                )
              : const Text(
                  'Metal Fabrication',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search,
                  color: Colors.black87),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchController.clear();
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.black87),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
              },
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.orange))
            : _errorMessage != null
                ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)))
                : RefreshIndicator(
                    color: Colors.orange,
                    onRefresh: _fetchGalleryItems,
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: _buildCarousel(),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          sliver: SliverToBoxAdapter(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Our Products",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                TextButton.icon(
                                  icon: const Icon(Icons.filter_list, color: Colors.orange),
                                  label: const Text(
                                    "Filter",
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  onPressed: () {
                                    _showFilterBottomSheet(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: _filteredMetalWorks.isEmpty
                              ? SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.search_off,
                                              size: 48, color: Colors.grey.shade400),
                                          const SizedBox(height: 16),
                                          Text(
                                            'No results found',
                                            style:
                                                TextStyle(color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : SliverGrid(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.7,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      final work = _filteredMetalWorks[index];
                                      final String image = work['image'] ?? '';
                                      final String title = work['title'] ?? 'Unknown Work';
                                      final String price = work['price'] ?? 'N/A';

                                      return Semantics(
                                        label: 'Metal work: $title, Price: $price',
                                        child: Hero(
                                          tag: 'metal_work_$index',
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (_, animation, __) =>
                                                        FadeTransition(
                                                      opacity: animation,
                                                      child: MetalWorkDetailsScreen(
                                                          work: work),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                elevation: 4,
                                                shadowColor: Colors.black12,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.stretch,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Stack(
                                                        fit: StackFit.expand,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .vertical(
                                                                    top:
                                                                        Radius.circular(
                                                                            16)),
                                                            child: Image.network(
                                                              '$_baseUrl/images/$image', // Adjust based on how images are served
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) {
                                                                return Container(
                                                                  color: Colors
                                                                      .grey.shade200,
                                                                  child: const Center(
                                                                    child: Icon(
                                                                        Icons
                                                                            .broken_image,
                                                                        size: 32,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                );
                                                              },
                                                              loadingBuilder: (context,
                                                                  child,
                                                                  loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null)
                                                                  return child;
                                                                return const Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 8,
                                                            right: 8,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors.white
                                                                    .withOpacity(
                                                                        0.7),
                                                                shape:
                                                                    BoxShape.circle,
                                                              ),
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    size: 20),
                                                                color: Colors.red,
                                                                onPressed: () {
                                                                  ScaffoldMessenger
                                                                          .of(context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content: Text(
                                                                          'Added $title to favorites'),
                                                                      duration:
                                                                          const Duration(
                                                                              seconds:
                                                                                  1),
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                12.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              title,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                              maxLines: 1,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                            Text(
                                                              price,
                                                              style: TextStyle(
                                                                color: Colors.orange
                                                                    .shade800,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.star,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .amber
                                                                        .shade700),
                                                                Icon(Icons.star,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .amber
                                                                        .shade700),
                                                                Icon(Icons.star,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .amber
                                                                        .shade700),
                                                                Icon(Icons.star,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .amber
                                                                        .shade700),
                                                                Icon(
                                                                    Icons.star_half,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .amber
                                                                        .shade700),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    childCount: _filteredMetalWorks.length,
                                  ),
                                ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 20),
                        ),
                      ],
                    ),
                  ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BookingScreen(
                  initialDesign: '',
                  initialServiceType: 'Metal Fabrication',
                ),
              ),
            );
          },
          tooltip: 'Make a booking',
          child: const Icon(Icons.add_shopping_cart),
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Projects'),
            BottomNavigationBarItem(
                icon: Icon(Icons.book_online), label: 'Booking'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter Products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Price Range',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RangeSlider(
                    values: const RangeValues(2000000, 9000000),
                    min: 1000000,
                    max: 12000000,
                    divisions: 11,
                    labels: const RangeLabels('2M UGX', '9M UGX'),
                    onChanged: (RangeValues values) {
                      // Implement filtering based on price range
                      setState(() {
                        _filteredMetalWorks = _galleryItems
                            .where((item) =>
                                item.minCost >= values.start &&
                                item.maxCost <= values.end)
                            .map((item) => item.toMap())
                            .toList();
                      });
                    },
                    activeColor: Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('Gates'),
                        selected: true,
                        onSelected: (bool selected) {
                          // Implement category filtering
                        },
                        selectedColor: Colors.orange.withOpacity(0.2),
                        checkmarkColor: Colors.orange,
                      ),
                      FilterChip(
                        label: const Text('Railings'),
                        selected: false,
                        onSelected: (bool selected) {},
                      ),
                      FilterChip(
                        label: const Text('Frames'),
                        selected: false,
                        onSelected: (bool selected) {},
                      ),
                      FilterChip(
                        label: const Text('Stairs'),
                        selected: false,
                        onSelected: (bool selected) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Colors.orange),
                          ),
                          onPressed: () {
                            setState(() {
                              _filteredMetalWorks =
                                  _galleryItems.map((item) => item.toMap()).toList();
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Reset',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCarousel() {
    if (_galleryItems.isEmpty) {
      return const SizedBox(
        height: 160,
        child: Center(child: Text('No images available', style: TextStyle(color: Colors.grey))),
      );
    }
    return Container(
      height: 200,
      margin: const EdgeInsets.only(top: 8),
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
            itemCount: _galleryItems.length,
            itemBuilder: (context, index) {
              final item = _galleryItems[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        '$_baseUrl/images/${item.imagePath}', // Adjust based on how images are served
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 32, color: Colors.grey),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(color: Colors.orange),
                          );
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.imageName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.imageDescription,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
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
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _galleryItems.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentImageIndex == index ? 20 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentImageIndex == index
                        ? Colors.orange
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}